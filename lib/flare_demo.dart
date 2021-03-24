import 'package:flutter/material.dart';
import 'package:smart_flare/actors/smart_flare_actor.dart';
import 'package:smart_flare/models.dart';

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    double animationWidth = 295;
    double animationHeight = 251;

    double animationWidthThird = animationWidth / 3;
    double halfAnimationHeight = animationHeight / 2;

    List<ActiveArea> activeAreas = [
      ActiveArea(
        area: Rect.fromLTWH(
          0,
          0,
          animationWidthThird,
          halfAnimationHeight,
        ),
        // debugArea: true,
        animationName: 'camera_tapped',
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print('Camera');
        },
      ),
      ActiveArea(
        area: Rect.fromLTWH(
          animationWidthThird,
          0,
          animationWidthThird,
          halfAnimationHeight,
        ),
        // debugArea: true,
        animationName: 'pulse_tapped',
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print('Pulse');
        },
      ),
      ActiveArea(
        area: Rect.fromLTWH(
          animationWidthThird * 2,
          0,
          animationWidthThird,
          halfAnimationHeight,
        ),
        // debugArea: true,
        animationName: 'image_tapped',
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print('Image');
        },
      ),
      ActiveArea(
        area: Rect.fromLTWH(
          0,
          halfAnimationHeight,
          animationWidth,
          halfAnimationHeight,
        ),
        // debugArea: true,
        animationsToCycle: ['activate', 'deactivate'],
        onAreaTapped: () {
          print('Toggle animation!');
        },
      )
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 18, 222),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SmartFlareActor(
          width: animationWidth,
          height: animationHeight,
          filename: 'assets/button-animation.flr',
          startingAnimation: 'deactivate',
          activeAreas: activeAreas,
        ),
      ),
/*
        body: Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareActor(
              width: animationWidth,
              height: animationHeight,
              filename: 'assets/button-animation.flr',
              startingAnimation: 'deactivate',
            )),
*/
    );
  }
}
