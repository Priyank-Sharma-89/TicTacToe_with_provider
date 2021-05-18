import 'package:flutter/foundation.dart';

class PlayerInfoProvider extends ChangeNotifier {
  String _playerOneName;
  String _playerTwoName;
  String _playerOneSide;
  String _playerTwoSide;

  String get getPlayerOneName => _playerOneName;

  set playerOneName(String value) {
    _playerOneName = value;
    notifyListeners();
  }

  String get getPlayerTwoName => _playerTwoName;

  set playerTwoName(String value) {
    _playerTwoName = value;
    notifyListeners();
  }

  String get getPlayerOneSide => _playerOneSide;

  set playerOneSide(String value) {
    _playerOneSide = value;
    notifyListeners();
  }

  String get getPlayerTwoSide => _playerTwoSide;

  set playerTwoSide(String value) {
    _playerTwoSide = value;
    notifyListeners();
  }
}
