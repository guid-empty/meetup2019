import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raw_graphics/liquid-swipe-fork/constants/constants.dart';

import '../liquid_swipe.dart';

/// This class is used to get user gesture and work according to it.

class PageDragger extends StatefulWidget {
  final double fullTransitionPX;
  final bool enableSlideIcon;

  //Stream controller
  final StreamController<SlideUpdate> slideUpdateStream;

  //Constructor
  PageDragger({
    this.slideUpdateStream,
    this.fullTransitionPX = FULL_TRANSITION_PX,
    this.enableSlideIcon = false,
  }) : assert(fullTransitionPX != null);

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  //Variables
  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0;

  // This methods executes when user starts dragging.
  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  // This methods executes while user is dragging.
  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      //Getting new position details
      final newPosition = details.globalPosition;
      //Change in position in x
      final dx = dragStart.dx - newPosition.dx;

      //predicting slide direction
      if (dx > 0.0) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      //predicting slide percent
      if (slideDirection != SlideDirection.none) {
        //clamp method is used to clamp the value of slidePercent from 0.0 to 1.0, after 1.0 it set to 1.0
        slidePercent = (dx / widget.fullTransitionPX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      // Adding to slideUpdateStream
      widget.slideUpdateStream.add(SlideUpdate(slideDirection, slidePercent, UpdateType.dragging));
    }
  }

  // This method executes when user ends dragging.
  onDragEnd(DragEndDetails details) {
    // Adding to slideUpdateStream
    widget.slideUpdateStream.add(SlideUpdate(SlideDirection.none, slidePercent, UpdateType.doneDragging));

    //Making dragStart to null for the reallocation
    slidePercent = 0;
    slideDirection = SlideDirection.none;
    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    //Gesture Detector for horizontal drag
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      child: widget.enableSlideIcon
          ? Align(
              alignment: Alignment(1 - slidePercent + 0.005, 0.54),
              child: Opacity(
                  opacity: 1 - slidePercent,
                  child: FloatingActionButton(
                    onPressed: null,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    child: slideDirection == SlideDirection.leftToRight ? null : Icon(Icons.arrow_back_ios),
                    foregroundColor: Colors.black,
                  )))
          : null,
    );
  }
}
