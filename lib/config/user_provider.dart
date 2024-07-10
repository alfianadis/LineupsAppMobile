import 'package:flutter/material.dart';
import 'package:lineups/features/login/data/models/auth_response.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
