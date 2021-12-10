import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_proj/Screens/profile_page.dart';
import 'package:my_proj/State/vote.dart';
import 'package:my_proj/models/service.dart';
import 'package:my_proj/utils/fire_auth.dart';

import 'package:my_proj/utils/validator.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _nicTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusNic = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  String dropdownvalue = 'Flacq';
  var items = [
    'BlackRiver',
    'Flacq',
    'GrandPort',
    'Moka',
    'Pamplemousses',
    'PlainesWilhems',
    'PortLouis',
    'RiviereduRempart',
    'Savanne'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("wawa");
        setState(() {
          _isProcessing = false;
        });
        _focusName.unfocus();
        _focusNic.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
            backgroundColor:Colors.orange
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Name",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _nicTextController,
                        focusNode: _focusNic,
                        validator: (value) => Validator.validateNic(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "NIC",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          /* showSnackBar(
                              context, 'Verifying NIC');*/
                          checkNicExist(_nicTextController.text, context);
                          setState(() {
                            _isProcessing = false;
                          });
                        }, // do not hide keyboar
                      ),
                      SizedBox(height: 13.0),
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 13.0),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        validator: (value) => Validator.validatePassword(
                          password: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Password",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        items: <String>[
                          'BlackRiver',
                          'Flacq',
                          'GrandPort',
                          'Moka',
                          'Pamplemousses',
                          'PlainesWilhems',
                          'PortLouis',
                          'RiviereduRempart',
                          'Savanne'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: dropdownvalue,
                        onChanged: (newValue) {
                          dropdownvalue = newValue.toString();
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                          print(newValue);
                        },
                      ),
                      SizedBox(height: 32.0),
                      _isProcessing
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                                    ),
                                    onPressed: () async {
                                      print(Provider.of<VoteState>(context,
                                              listen: false)
                                          .nicVerified);
                                      print(Provider.of<VoteState>(context,
                                              listen: false)
                                          .numofnic);
                                      print("start of check");
                                      checkNicExist(
                                          _nicTextController.text, context);

                                      if (Provider.of<VoteState>(context,
                                                      listen: false)
                                                  .nicVerified ==
                                              true &&
                                          Provider.of<VoteState>(context,
                                                      listen: false)
                                                  .numofnic ==
                                              0) {
                                        print("start of check 0");
                                        Provider.of<VoteState>(context,
                                                listen: false)
                                            .nicVerified = false;

                                        print("registering");
                                        setState(() {
                                          _isProcessing = true;
                                        });
                                        print("checking");
                                        print(_nameTextController.text);
                                        print(_emailTextController.text);
                                        print(_passwordTextController.text);

                                        if (_registerFormKey.currentState!
                                            .validate()) {
                                          User? user = await FireAuth
                                              .registerUsingEmailPassword(
                                            name: _nameTextController.text,
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            print("user is not null");
                                            saveUerDetails(_nicTextController.text,_nameTextController.text,_emailTextController.text,dropdownvalue);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(user: user),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          } else {
                                            print("user is null");
                                          }
                                        }
                                      } else if (Provider.of<VoteState>(context,
                                                  listen: false)
                                              .nicVerified ==
                                          false) {
                                        print("start of check 2");
                                        //checkNicExist(                                            _nicTextController.text, context);


                                      } else if (Provider.of<VoteState>(context,
                                                      listen: false)
                                                  .nicVerified ==
                                              true &&
                                          Provider.of<VoteState>(context,
                                                      listen: false)
                                                  .numofnic !=
                                              0) {
                                        print("error exists");


                                        _showDialog(
                                            "NIC already exists in the system");
                                      }
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
