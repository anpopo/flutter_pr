import 'package:first_web/provider_tuto/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderTutoApp());
}

class ProviderTutoApp extends StatelessWidget {
  const ProviderTutoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('ProviderTutoApp build..');
    return MaterialApp(
      home: ChangeNotifierProvider<CountProvider>(
        create: (context) => CountProvider(),
        child: const MaterialApp(
          home: CountScreen(),
        ),
      ),
    );
  }
}

class CountScreen extends StatelessWidget {
  const CountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('CountScreen build...');
    final provider = Provider.of<CountProvider>(context, listen: false);
    // final provider = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ConsumerColorContainer(),
          const SelectorColorContainer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  provider.countUp();
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  provider.countDown();
                },
                icon: const Icon(Icons.exposure_minus_1),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class ConsumerColorContainer extends StatelessWidget {
  const ConsumerColorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    print('ConsumerColorContainer build...');
    return Center(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.orange[100],
        child: const ConsumerNumberBox(),
      ),
    );
  }
}

class SelectorColorContainer extends StatelessWidget {
  const SelectorColorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    print('SelectorColorContainer build...');
    return Center(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.green[100],
        child: const SelectorNumberBox(),
      ),
    );
  }
}

class ConsumerNumberBox extends StatelessWidget {
  const ConsumerNumberBox({super.key});

  @override
  Widget build(BuildContext context) {
    print('ConsumerNumberBox build....');
    return Consumer<CountProvider>(
      builder: (context, countProvider, child) {
        return Text(countProvider.count.toString());
      },
    );
  }
}

class SelectorNumberBox extends StatelessWidget {
  const SelectorNumberBox({super.key});

  @override
  Widget build(BuildContext context) {
    print('SelectorNumberBox build....');
    return Selector<CountProvider, int>(
      builder: (context, value, child) => Text(value.toString()),
      selector: (context, countProvider) => countProvider.count,
    );
  }
}
