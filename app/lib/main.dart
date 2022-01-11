import 'package:app/helpers/shared_pref.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/circle_progress_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Developer Assignment',
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int isUserLoggedIn = 0;
  void initState() {
    autoLogin();
    super.initState();
  }

  void autoLogin() async {
    final loggedInUsername = await SharedPreferencesHelper().getLoggedInUser();
    Future.delayed(Duration(seconds: 2), () async {
      if (loggedInUsername != null && loggedInUsername.isNotEmpty) {
        setState(() {
          isUserLoggedIn = 1;
        });
      } else {
        setState(() {
          isUserLoggedIn = 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isUserLoggedIn == 0) {
      return CircleProgressIndicator();
    } else if (isUserLoggedIn == 1) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
