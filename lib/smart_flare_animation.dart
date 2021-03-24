import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  // create our flare controls
  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;

  // width and height retrieved from the artboard values in the animation
  static const double AnimationWidth = 295;
  static const double AnimationHeight = 251;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          setState(() {
            Offset localTouchPosition =
                (context.findRenderObject() as RenderBox)
                    .globalToLocal(tapInfo.globalPosition);

            // where did we touch
            bool topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;

            bool leftSideTouched = localTouchPosition.dx < AnimationWidth / 3;

            bool rightSideTouched =
                localTouchPosition.dx > (AnimationWidth / 3) * 2;

            bool middleTouched = !leftSideTouched && !rightSideTouched;

            if (leftSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
            } else if (middleTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
            } else if (rightSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
            } else {
              if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else {
                _setAnimationToPlay(AnimationToPlay.Activate);
              }

              isOpen = !isOpen;
            }
          });
        },
        child: FlareActor(
          'assets/button-animation.flr',
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
        break;
      case AnimationToPlay.Deactivate:
        return 'deactivate';
        break;
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
        break;
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
        break;
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
        break;
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    bool isTappedAnimation = _getAnimationName(animation).contains('_tapped');

    if (isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate)
      return;

    animationControls.play(_getAnimationName(animation));

    // remember our last played animation
    _lastPlayedAnimation = animation;
  }
}
