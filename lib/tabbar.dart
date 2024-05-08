import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(text: 'Tab 1'),
        Tab(text: 'Tab 2'),
      ],
    );
  }
}

class MyTabBarView extends StatelessWidget {
  final TabController tabController;

  const MyTabBarView({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        Container(
          child: Center(
            child: Text('Content of Tab 1'),
          ),
        ),
        Container(
          child: Center(
            child: Text('Content of Tab 2'),
          ),
        ),
      ],
    );
  }
}
