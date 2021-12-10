import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_proj/models/service.dart';
import 'package:my_proj/widgets/vote_list.dart';
import 'package:provider/provider.dart';
import 'package:my_proj/State/vote.dart';
import 'package:my_proj/models/vote.dart';
import 'package:my_proj/widgets/vote.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({required this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentStep = 0;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;

    super.initState();
    // loading votes
    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList(context);
      checkemailExist(_currentUser.email, context);
      updateNoVotePoll(context);
      updateVotePoll(context);
      Gettotalperdistrict(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
          backgroundColor:Colors.orange
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                if (Provider.of<VoteState>(context, listen: true).voteList !=
                    null)
                  Expanded(
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: _currentStep,
                      steps: [
                        getStep(
                          title: 'Choose',
                          child: VoteListWidget(),
                          isActive: true,
                        ),
                        getStep(
                          title: 'Vote',
                          child: VoteWidget(),
                          isActive: _currentStep >= 1 ? true : false,
                        ),
                      ],
                      onStepCancel: () {
                        if (_currentStep <= 0) {
                          Provider.of<VoteState>(context, listen: false)
                              .activeVote = null;
                        } else if (_currentStep <= 1) {
                          Provider.of<VoteState>(context, listen: false)
                              .selectedOptionInActiveVote = null;
                        }

                        setState(() {
                          _currentStep =
                              (_currentStep - 1) < 0 ? 0 : _currentStep - 1;
                        });
                      },
                      onStepContinue: () {
                        if (_currentStep == 0) {
                          if (Provider.of<VoteState>(context, listen: false)
                                  .voted ==
                              true) {
                            _showDialog('you already voted');
                          } else {
                            if (step2Required()) {
                              setState(() {
                                _currentStep = (_currentStep + 1) > 2
                                    ? 2
                                    : _currentStep + 1;
                              });
                            } else {
                              _showDialog('Please select an option first!');
                            }
                          }
                        } else if (_currentStep == 1) {
                          if (step3Required()) {
                            markMyVote();
                            // Go To Result Screen
                            Navigator.pushReplacementNamed(context, '/result');
                          } else {
                            _showDialog('Please mark your vote!');
                          }
                        }
                      },
                    ),
                  ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LaunchScreen(),
                    //   ),
                    // );
                    Navigator.pushNamed(context, '/map');
                    //Navigator.pop(context);
                  },
                  child: Text("Stats"),
                ),/*
                IconButton(
                  icon: const Icon(Icons.map_outlined),
                  iconSize: 70,
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                    setState(() {
                      //_volume += 10;
                    });
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool step2Required() {
    if (Provider.of<VoteState>(context, listen: false).activeVote == null) {
      return false;
    }

    return true;
  }

  bool step3Required() {
    if (Provider.of<VoteState>(context, listen: false)
            .selectedOptionInActiveVote ==
        null) {
      return false;
    }
    return true;
  }

  void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 22),
      ),
    ));
  }

  Step getStep({
    required String title,
    required Widget child,
    bool isActive = false,
  }) {
    return Step(
      title: Text(title),
      content: child,
      isActive: isActive,
    );
  }

  void markMyVote() {
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote.voteId;
    final option = Provider.of<VoteState>(context, listen: false)
        .selectedOptionInActiveVote;

    markVote(voteId, option, context);
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
