import 'package:flutter/material.dart';

class TheaterSelectorPopup extends PopupRoute {

  final opacityTween = Tween(begin: 0.0, end: 1.0);
  final positionTween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return Container(
      color: const Color(0xFF152451),
      child: null,
    );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.decelerate,
    );

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRect(
        child: FadeTransition(
          opacity: opacityTween.animate(curve),
          child: SlideTransition(
            position: positionTween.animate(curve),
            child: child,
          ),
        ),
      ),
    );
  }

}