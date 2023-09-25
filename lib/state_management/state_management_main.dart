import 'package:flutter/material.dart';

void main() {
  runApp(const StateManagementApp());
}

// const children = [
//   BottomNavigatorScreen(
//     text: 'Profile',
//   ),
//   BottomNavigatorScreen(
//     text: 'Calendar',
//   ),
//   BottomNavigatorScreen(
//     text: 'Settings',
//   ),
// ];

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
  bool _isLogin = false;
  String? _name;

  void _onLoginPress() {
    setState(() {
      _isLogin = true;
      _name = 'dev_hippo_an';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _isLogin ? Text('Hello! $_name') : const Text('State Management'),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
                _isLogin ? _name = 'dev_hippo_an' : _name = null;
              });
            },
            icon:
                _isLogin ? const Icon(Icons.logout) : const Icon(Icons.logout),
            label: _isLogin ? const Text('Logout') : const Text('Login'),
          ),
        ],
      ),
      body: <Widget>[
        BottomNavigatorScreen(
          text: 'Profile',
          isLogin: _isLogin,
          name: _name,
          onLoginPress: _onLoginPress,
        ),
        BottomNavigatorScreen(
          text: 'Calendar',
          isLogin: _isLogin,
          name: _name,
          onLoginPress: _onLoginPress,
        ),
        BottomNavigatorScreen(
          text: 'Settings',
          isLogin: _isLogin,
          name: _name,
          onLoginPress: _onLoginPress,
        ),
      ][_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.amber[700],
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

class BottomNavigatorScreen extends StatelessWidget {
  const BottomNavigatorScreen({
    super.key,
    required this.text,
    required this.isLogin,
    required this.name,
    required this.onLoginPress,
  });

  final String text;
  final bool isLogin;
  final String? name;
  final void Function() onLoginPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLogin
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hello!!! $name'),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Please Login first!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onLoginPress,
                    child: const Text('login'),
                  ),
                ],
              ),
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
          children: [Scaffold(), Scaffold(), Scaffold()],
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [Scaffold(), Scaffold(), Scaffold()],
    );
  }
}
