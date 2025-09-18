import 'package:flutter/material.dart';
import 'package:noviindus_test2/auth/provider/auth_provider.dart';
import 'package:noviindus_test2/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
       
      ],
      child: MaterialApp(
        home:  const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
