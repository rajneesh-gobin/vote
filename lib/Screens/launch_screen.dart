import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/constants.dart';
import 'package:my_proj/widgets/shared_widgets.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: const Text(
              kAppName,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          LoginButton(
            label: 'Tester Vote',
            size: 300,
            onPressed: () {
              signIn(context);
//          setState(() {
//            _isNeedHelp = true;
//          });
            },
          ),
          SizedBox(
            height: 10,
          ),
          LoginButton(
            label: 'Google Sign In',
            size: 300,
            onPressed: () {
              signIn(context);
              print("bbb");
//          setState(() {
//            _isNeedHelp = true;
//          });
            },
          ),
        ],
      ),
    );
  }

  void signIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
