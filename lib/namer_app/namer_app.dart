import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamerApp extends StatelessWidget {
  const NamerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      lazy: true,
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(194, 149, 237, 0)),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentWord = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, currentWord);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    currentWord = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite(WordPair? pair) {
    pair = pair ?? currentWord;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var page =
        selectedIndex == 0 ? const GeneratorHome() : const GeneratorFavorites();

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return Column(
          children: [
            Expanded(child: mainArea),
            SafeArea(
                child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ))
          ],
        );
      }
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 800,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.home), label: Text('Home')),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite), label: Text('Favorites'))
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(child: mainArea)
          ],
        ),
      );
    });
  }
}

class GeneratorHome extends StatelessWidget {
  const GeneratorHome({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentWord;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 2,
            child: HistoryListView(),
          ),
          const SizedBox(
            height: 10,
          ),
          BigCard(pair: pair),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(null);
                },
                icon: Icon(appState.favorites.contains(pair)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
                label: const Text('Like'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class GeneratorFavorites extends StatelessWidget {
  const GeneratorFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
            children: [
              for (var pair in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      semanticLabel: 'Delete',
                    ),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      appState.removeFavorite(pair);
                    },
                  ),
                  title: Text(
                    pair.asLowerCase,
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? const Icon(Icons.favorite, size: 12)
                    : const SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          child: MergeSemantics(
            child: Wrap(children: [
              Text(
                pair.first,
                style: style.copyWith(fontWeight: FontWeight.w200),
              ),
              Text(
                pair.second,
                style: style.copyWith(fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
