// @dart=2.9
import 'package:flutter/material.dart';
import 'package:my_proj/State/vote.dart';
import 'package:my_proj/models/vote.dart';
import 'package:provider/provider.dart';

class VoteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function alternateColor = getAlternate(start: 0);
String activeVoteId=Provider.of<VoteState>(context).activeVote?.voteId ?? '';
    Provider.of<VoteState>(context, listen: false);
    return Consumer<VoteState>(
      builder: (context, voteState, child) {
        return Column(
          children: <Widget>[
            for (Vote vote in voteState.voteList)
              Card(
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      vote.voteTitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: activeVoteId == vote.voteId ? Colors.white : Colors.black,
                        fontWeight: activeVoteId == vote.voteId ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  selected:activeVoteId ==vote.voteId ? true : false,
                    onTap: () {
                      voteState.activeVote = vote;
                    },
                ),
                color: activeVoteId == vote.voteId ? Colors.amber : alternateColor(),
              ),
          ],
        );
      },
    );
  }

  Function getAlternate({int start = 0}) {
    int indexNum = start;
    Color getColor() {
      Color color = Colors.deepOrangeAccent;

      if (indexNum % 2 == 0) {
        color = Colors.orangeAccent;
      }

      ++indexNum;
      return color;
    }

    return getColor;
  }
}
