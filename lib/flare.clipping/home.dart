import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  final String initialAnimation;

  const Home({Key key, this.initialAnimation = 'idle'}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _currentAnimation;

  @override
  void initState() {
    super.initState();

    _currentAnimation = widget.initialAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0, right: 0),
      alignment: Alignment.center,
      child: FlareActor(
        'assets/flare/justtry.basics.clipping.flr',
        fit: BoxFit.fitWidth,
        animation: _currentAnimation,
        alignment: Alignment.center,
      ),
    );
  }
}
