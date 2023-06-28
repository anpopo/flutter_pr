import 'package:first_web/pattern_codelab/data.dart';
import 'package:flutter/material.dart';

class DocumentApp extends StatelessWidget {
  const DocumentApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  Widget build(BuildContext context) {
    final (title, :modified) = document.metadata;
    final power = document.power();
    final blocks = document.getBlocks();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title and ${power.$1} and ${power.$2}',
        ),
      ),
      body: Column(
        children: [
          Text(
            'Last modified ${formatDate(modified)} and last ${power.$3}',
          ),
          Expanded(
              child: ListView.builder(
            itemCount: blocks.length,
            itemBuilder: (context, index) {
              return BlockWidget(block: blocks[index]);
            },
          ))
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({
    super.key,
    required this.block,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: switch (block) {
        HeaderBlock(
          :final text,
        ) =>
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ParagraphBlock(
          :final text,
        ) =>
          Text(text),
        CheckboxBlock(
          :final text,
          :final isChecked,
        ) =>
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: (_) {}),
              Text(text),
            ],
          ),
      },
    );
  }
}

String formatDate(DateTime dateTime) {
  return switch (dateTime.difference(DateTime.now())) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    Duration(inDays: final days) when days > 7 => '${days ~/ 7} weeks from now',
    Duration(inDays: final days) when days < -7 =>
      '${days.abs() ~/ 7} weeks ago',
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}
