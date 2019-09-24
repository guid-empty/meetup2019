import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raw_graphics/flare.actions.panel/products.dart';

class Home extends StatefulWidget {
  final String initialAnimation;

  const Home({Key key, this.initialAnimation = 'idle'}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _currentAnimation;
  bool _isExpanded = false;
  double _currentActorHeight = IS_COLLAPSED_ACTOR_HEIGHT;
  final _flareController = FlareControls();

  static const double ACTOR_WIDTH = 120.0;
  static const double IS_EXPANDED_ACTOR_HEIGHT = 450.0;
  static const double IS_COLLAPSED_ACTOR_HEIGHT = 120.0;

  List<String> _products = [];

  @override
  void initState() {
    super.initState();

    _currentAnimation = widget.initialAnimation;
    _products.addAll(Iterable.generate(7, (int index) => 'Laptop $index'));
  }

  Rect get mainButtonRect => Rect.fromLTWH(0, _currentActorHeight - 90, ACTOR_WIDTH, 65);
  Rect get recycleBinButtonRect => _isExpanded ? Rect.fromLTWH(0, 40, ACTOR_WIDTH, 62) : Rect.zero;
  Rect get orgButtonRect => _isExpanded ? recycleBinButtonRect.translate(0, 62) : Rect.zero;
  Rect get lampButtonRect => _isExpanded ? orgButtonRect.translate(0, 62) : Rect.zero;
  Rect get galleryButtonRect => _isExpanded ? lampButtonRect.translate(0, 62) : Rect.zero;
  Rect get checkButtonRect => _isExpanded ? galleryButtonRect.translate(0, 62) : Rect.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 0, right: 0),
          alignment: Alignment.center,
          child: Products(_products),
        ),
        Positioned(
          child: GestureDetector(
            onTapUp: (TapUpDetails info) {
              if (mainButtonRect.contains(info.localPosition)) {
                setState(() {
                  _isExpanded = !_isExpanded;
                  _currentAnimation = _isExpanded ? 'showing' : 'hiding';
                  if (_isExpanded) {
                    _currentActorHeight = IS_EXPANDED_ACTOR_HEIGHT;
                  }
                });
              } else if (recycleBinButtonRect.contains(info.localPosition)) {
                _currentAnimation = 'tapped_recyclebin';
                _flareController.play(_currentAnimation);
              } else if (orgButtonRect.contains(info.localPosition)) {
                _currentAnimation = 'tapped_org';
                _flareController.play(_currentAnimation);
              } else if (lampButtonRect.contains(info.localPosition)) {
                _currentAnimation = 'tapped_lamp';
                _flareController.play(_currentAnimation);
              } else if (galleryButtonRect.contains(info.localPosition)) {
                _currentAnimation = 'tapped_gallery';
                _flareController.play(_currentAnimation);
              } else if (checkButtonRect.contains(info.localPosition)) {
                _currentAnimation = 'tapped_checkthetext';
                _flareController.play(_currentAnimation);
              }
            },
            child: FlareActor(
              'assets/flare/justtry.actions.panel.flr',
              fit: BoxFit.scaleDown,
              controller: _flareController,
              animation: _currentAnimation,
              alignment: Alignment.bottomCenter,
              callback: (String animationName) {
                if (animationName == 'hiding') {
                  setState(() {
                    _currentAnimation = 'idle';
                    _currentActorHeight = IS_COLLAPSED_ACTOR_HEIGHT;
                  });
                }
              },
            ),
          ),
          height: _currentActorHeight,
          width: ACTOR_WIDTH,
          bottom: 0,
          right: 0,
        )
      ],
    );
  }
}
