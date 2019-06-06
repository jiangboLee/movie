import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LeeBottomBar extends StatelessWidget {

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const LeeBottomBar({Key key, this.currentIndex, this.onTap, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: Colors.black54,
      inactiveColor: Colors.white54,
      activeColor: Colors.white,
      iconSize: 24.0,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
