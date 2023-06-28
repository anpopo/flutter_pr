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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title and ${power.$1} and ${power.$2}',
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Last modified $modified and last ${power.$3}',
            ),
          ),
        ],
      ),
    );
  }
}
