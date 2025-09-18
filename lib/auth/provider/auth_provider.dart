import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:noviindus_test2/auth/service/auth_service.dart';
import 'package:noviindus_test2/widgets/customSnackbar.dart';


class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();


  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _selectedCountryCode = '+91';
  bool _isButtonEnabled = false;

  
  TextEditingController get phoneController => _phoneController;
  FocusNode get phoneFocusNode => _phoneFocusNode;
  String get selectedCountryCode => _selectedCountryCode;
  bool get isButtonEnabled => _isButtonEnabled;

  bool _isLoading = false;
  String? _token;


  bool get isLoading => _isLoading;
  String? get token => _token;

  AuthProvider() {

    _phoneController.addListener(() {
      _isButtonEnabled = _phoneController.text.length == 10;
      notifyListeners();
    });
  }

  void setCountryCode(String code) {
    _selectedCountryCode = code;
    notifyListeners();
  }

 
  void setPhoneNumber(String number) {
    _isButtonEnabled = number.length == 10;
    notifyListeners();
  }

  Future<void> getToken() async {
    _token = await _authService.getToken();
    notifyListeners();
  }

  Future<void> login(BuildContext context, String countryCode, String phoneNumber) async {
    _isLoading = true;
    notifyListeners();
    final loginModel = await _authService.login(countryCode, phoneNumber);
    if (loginModel?.status == true) {
      _token = loginModel?.token?.access;
      debugPrint("Login successful");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      CustomSnackbar.show(context: context, message:  'Login failed', isSucces: false);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    await _authService.removeToken();
    notifyListeners();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
}