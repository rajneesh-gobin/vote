
import "package:flutter/material.dart";


void gotoHomeScreen(BuildContext context) {
  Future.microtask(() {

      Navigator.pushReplacementNamed(context, '/home');

  });
}

void gotoLoginScreen(BuildContext context) {
  Future.microtask(() {

      Navigator.pushReplacementNamed(context, '/');

  });
}