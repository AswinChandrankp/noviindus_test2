import 'package:flutter/material.dart';
import 'package:noviindus_test2/auth/provider/auth_provider.dart';
import 'package:noviindus_test2/auth/screens/login_screen.dart';
import 'package:noviindus_test2/constants.dart';

import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/provider/video_provider.dart';
import 'package:noviindus_test2/home/screens/addfeed_screen.dart';
import 'package:noviindus_test2/home/screens/homescreen.dart';
import 'package:noviindus_test2/home/screens/video_section.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return  MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
       
//       ],
//       child: MaterialApp(
//         home:  const LoginScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  final String? savedToken = await getSavedToken();

  runApp(MyApp(initialToken: savedToken));
}

Future<String?> getSavedToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(AppConstants.tokenKey);
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({Key? key, required this.initialToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
         ChangeNotifierProvider<Homeprovider>(create: (_) => Homeprovider()),
         ChangeNotifierProvider<VideoProvider>(create: (_) => VideoProvider()),
      
      ],
      child: MaterialApp(
        home: initialToken != null ?  HomeScreen () : const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
