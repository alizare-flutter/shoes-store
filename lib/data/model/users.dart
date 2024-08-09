import 'package:flutter/material.dart';

class Users {
  String name;
  String password;
  String email;
  String pictrue;

  Users(this.name, this.password, this.email, this.pictrue);
}

class UsersProvider with ChangeNotifier {
  List<Users> _users = [
    Users('Ali Asghar Zare', '1234zare', 'alizare.flutter@gmail.com', ''),
    Users('test1', 'test11234', 'example@gmail.com', ''),
    Users('test2', 'test21234', 'example@gmail.com', ''),
  ];

  List<Users> get users => _users;

  void addUser(String name, String password, String email, String pictrue) {
    _users.add(Users(name, password, email, pictrue));
    notifyListeners();
  }
}
