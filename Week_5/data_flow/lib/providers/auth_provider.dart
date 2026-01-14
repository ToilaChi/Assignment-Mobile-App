import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  // Lưu trữ thông tin reset password
  String _email = '';
  String _newPassword = '';
  String _confirmPassword = '';

  // Getters
  String get email => _email;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  // Setters - cập nhật data từng bước
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setNewPassword(String password) {
    _newPassword = password;
    notifyListeners();
  }

  void setConfirmPassword(String password) {
    _confirmPassword = password;
    notifyListeners();
  }

  // Lấy credentials sau khi reset thành công
  UserCredentials getResetCredentials() {
    return UserCredentials(email: _email, password: _newPassword);
  }

  // Reset data sau khi hoàn tất
  void resetData() {
    _email = '';
    _newPassword = '';
    _confirmPassword = '';
    notifyListeners();
  }

  // Kiểm tra password khớp
  bool isPasswordMatch() {
    return _newPassword == _confirmPassword && _newPassword.isNotEmpty;
  }

  // In ra data flow (dùng để debug)
  void printDataFlow() {
    print('=== DATA FLOW ===');
    print('Email: $_email');
    print('New Password: $_newPassword');
    print('Confirm Password: $_confirmPassword');
    print('================');
  }
}
