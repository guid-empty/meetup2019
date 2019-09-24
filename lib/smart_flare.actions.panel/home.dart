import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raw_graphics/flare.actions.panel/products.dart';
import 'package:smart_flare/smart_flare.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  double get _currentActorHeight => IS_EXPANDED_ACTOR_HEIGHT;

  static const double ACTOR_WIDTH = 120.0;
  static const double IS_EXPANDED_ACTOR_HEIGHT = 850.0;
  static const double IS_COLLAPSED_ACTOR_HEIGHT = 120.0;

  List<String> _products = [];

  @override
  void initState() {
    super.initState();

    _products.addAll(Iterable.generate(7, (int index) => 'Laptop $index'));
  }

  Rect get mainButtonRect => Rect.fromLTWH(0, _currentActorHeight - 460, ACTOR_WIDTH, 70);
  Rect get recycleBinButtonRect => _isExpanded ? Rect.fromLTWH(0, 40, ACTOR_WIDTH, 62) : Rect.zero;
  Rect get orgButtonRect => _isExpanded ? recycleBinButtonRect.translate(0, 62) : Rect.zero;
  Rect get lampButtonRect => _isExpanded ? orgButtonRect.translate(0, 62) : Rect.zero;
  Rect get galleryButtonRect => _isExpanded ? lampButtonRect.translate(0, 62) : Rect.zero;
  Rect get checkButtonRect => _isExpanded ? galleryButtonRect.translate(0, 62) : Rect.zero;

  @override
  Widget build(BuildContext context) {
    final debugArea = true;
    final areas = <ActiveArea>[
      ActiveArea(area: mainButtonRect, animationsToCycle: ['showing', 'hiding'], debugArea: debugArea),
      ActiveArea(area: recycleBinButtonRect, animationName: 'tapped_recyclebin', debugArea: debugArea),
      ActiveArea(area: orgButtonRect, animationName: 'tapped_org', debugArea: debugArea),
      ActiveArea(area: lampButtonRect, animationName: 'tapped_lamp', debugArea: debugArea),
      ActiveArea(area: galleryButtonRect, animationName: 'tapped_gallery', debugArea: debugArea),
      ActiveArea(area: checkButtonRect, animationName: 'tapped_checkthetext', debugArea: debugArea),
    ];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Positioned(
          child: SmartFlareActor(
            height: _currentActorHeight,
            width: ACTOR_WIDTH,
            filename: 'assets/flare/justtry.actions.panel.flr',
            startingAnimation: 'showing',
            activeAreas: areas,
          ),
          height: _currentActorHeight,
          width: ACTOR_WIDTH,
          bottom: -350,
          right: 0,
        )
      ],
    );
  }
}
