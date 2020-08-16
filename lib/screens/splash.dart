import 'package:Covid19/screens/home.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute<HomeScreen>(
        builder: (BuildContext context) {
          return HomeScreen();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F9A79),
      body: FlareActor(
        "assets/flare/covid.flr",
        animation: "covid",
        fit: BoxFit.cover,
      ),
    );
  }
}
