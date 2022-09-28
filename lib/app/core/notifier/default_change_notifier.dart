import 'package:flutter/cupertino.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  bool _sucess = false;

  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSucess => _sucess;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void sucess() => _sucess = true;
  void setError(String? error) => _error = error;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _sucess = false;
  }
}
