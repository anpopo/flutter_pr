import 'dart:convert';

class Document {
  Document() : _json = jsonDecode(documentJson);
  final Map<String, Object?> _json;

  (String, {DateTime modified}) get metadata {
    const title = 'My Document';
    final now = DateTime.now();

    return (title, modified: now);
  }

  (String, String, int) power() {
    const first = 'first';
    const second = 'second';
    const last = 1000;

    return (first, second, last);
  }
}

const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';
