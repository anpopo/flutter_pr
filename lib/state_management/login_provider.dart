import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _isLogin = false;
  String? _name;

  bool get isLogin => _isLogin;
  String? get name => _name;

  void onPress() {
    _isLogin = !_isLogin;
    _isLogin ? _name = 'dev_hippo_an' : _name = null;

    notifyListeners();
  }
}