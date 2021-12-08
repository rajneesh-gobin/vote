// @dart=2.9
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:my_proj/State/vote.dart';
import 'package:my_proj/models/vote.dart';

class VoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Vote activeVote = Provider.of<VoteState>(context).activeVote;
    List<String> options = List<String>();
    Map<String, String> Logo = {};

    for (Map<String, String> option in activeVote.options) {
      option.forEach((title, value) {
        options.add(title);
        Logo[title] = option[title];
        //print(option[title]);
      });
    }

    return Column(
      children: <Widget>[
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text(
              activeVote.voteTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        ),
        for (String option in options)
          Card(
            child: InkWell(
              onTap: () {
                Provider.of<VoteState>(context, listen: false)
                    .selectedOptionInActiveVote = option;
                Provider.of<VoteState>(context, listen: false).selected =
                    !Provider.of<VoteState>(context, listen: false).selected;
              },
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minHeight: 60),
                      width: 8,
                      color: Colors.red,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 60),
                      width: 9,
                      color: Colors.blue,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 60),
                      width: 9,
                      color: Colors.yellow,
                    ),Container(
                      constraints: BoxConstraints(minHeight: 60),
                      width: 9,
                      color: Colors.green,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/" + Logo[option] + ".jpg"),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                              child: (Text(
                            option,
                            maxLines: 5,
                            style: TextStyle(fontSize: 22),
                          ))),
                        ]),
                        color: Provider.of<VoteState>(context)
                                    .selectedOptionInActiveVote ==
                                option
                            ? Colors.green
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color testFunction() {
    return Colors.green;
  }
}
