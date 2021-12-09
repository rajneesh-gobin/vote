// @dart=2.9
import 'package:flutter/material.dart';
import 'package:my_proj/Screens/home_screen.dart';
import 'package:my_proj/Screens/launch_screen.dart';
import 'package:my_proj/Screens/result_screen.dart';
import 'package:my_proj/constants.dart';
import 'package:my_proj/State/vote.dart';
import 'package:provider/provider.dart';
import 'package:my_proj/screens/login_pages.dart';

import 'Screens/maps_page.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //builder is deprecated-- https://stackoverflow.com/questions/59100723/flutter-changenotifierprovider-builder-is-deprecated
          create: (_) => VoteState(),
        )
      ],
      child: MaterialApp(
        initialRoute: "/login",
        routes: {
          "/": (context) => Scaffold(
                body: LoginPage(),
              ),
          '/home': (context) => Scaffold(
                appBar: AppBar(
                  title: const Text(kAppName),
                ),
                //body: HomeScreen(),
              ),
          '/map': (context) => Scaffold(
                appBar: AppBar(
                  title: const Text(kAppName),
                ),
                body: MapsApp(),
              ),
          '/result': (context) => Scaffold(
                appBar: AppBar(
                  title: const Text('Result'),
                  leading: IconButton(
                    icon: const Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),
                body: ResultScreen(),
              ),
          '/login': (context) => Scaffold(
            appBar: AppBar(
              title: const Text(kAppName),
            ),
            body: LoginPage(),
          )
        },
      ),
    );
  }
}
//https://blog.logrocket.com/implementing-firebase-authentication-in-a-flutter-app/
//https://github.com/sbis04/flutter-authentication
//https://firebase.flutter.dev/docs/installation/android/