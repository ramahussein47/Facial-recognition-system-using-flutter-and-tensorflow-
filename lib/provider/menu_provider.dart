import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  int _selectedMenu = 0;

  int get selectedMenu => _selectedMenu;

  void selectMenu(int index) {
    _selectedMenu = index;
    notifyListeners();
  }
}
