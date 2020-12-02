import 'dart:async';

import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../screen/dashboard_screen.dart';
import '../screen/sign_in_screen.dart';
import '../util/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _height = _size.height;

    void _navigateToSignIn() async {
      UserModel userModel = await UserModel.get();
      Timer(Duration(seconds: 3), () {
        if (userModel != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ),
          );
        }
      });
    }

    _navigateToSignIn();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: _height * 0.1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(Constants.hashImageURL),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Constants.splashImageURL),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
