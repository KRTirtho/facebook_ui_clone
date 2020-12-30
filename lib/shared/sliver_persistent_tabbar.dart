import 'package:flutter/material.dart';

class SliverPersistentTabBar extends SliverPersistentHeaderDelegate {
  SliverPersistentTabBar(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2.0,
      child: Container(
        child: _tabBar,
        color: Theme.of(context).backgroundColor,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
