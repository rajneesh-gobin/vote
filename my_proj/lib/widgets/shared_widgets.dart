// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget
{

  String label;
  double size;
 // Function onPressed;
  final VoidCallback onPressed;
  final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

  LoginButton ({  this.label,this.size=300.00,    this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Material(  //Wrap with Material
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
        elevation: 18.0,
        color: Color(0xFF801E48),
        clipBehavior: Clip.antiAlias, // Add This
        child: MaterialButton(
          minWidth: size,
          height: 35,
          color: Color(0xFF801E48),
          child: new Text(label,
              style: new TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: onPressed,
        ),
      ),
    );
  }
  }

