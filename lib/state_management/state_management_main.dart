import 'package:flutter/material.dart';

void main() {
  runApp(const StateManagementApp());
}

final children = [
  const Scaffold(
    body: Center(
      child: Text('Profile'),
    ),
  ),
  const Scaffold(
    body: Center(
      child: Text('Calendar'),
    ),
  ),
  const Scaffold(
    body: Center(
      child: Text('Settings'),
    ),
  ),
];

class StateManagementApp extends StatelessWidget {
  const StateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigator(),
    );
  }
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.amber[800],
        onTap: (selectedIndex) {
          setState(() {
            _index = selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: children.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Calendar'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: children,
        ),
      ),
    );
  }
}

class PageViewNavigator extends StatefulWidget {
  const PageViewNavigator({super.key});

  @override
  State<PageViewNavigator> createState() => _PageViewNavigatorState();
}

class _PageViewNavigatorState extends State<PageViewNavigator> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: children,
    );
  }
}
