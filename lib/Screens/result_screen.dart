// @dart=2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:my_proj/models/service.dart';
import 'package:provider/provider.dart';
import 'package:my_proj/models/vote.dart';
import 'package:my_proj/State/vote.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultScreen extends StatelessWidget {
  int currentVote = 5;

  @override
  Widget build(BuildContext context) {
    retrieveActiveVoteData(context);
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height / 2,
      child: createChart(context),
    );
  }

  Widget createChart(BuildContext context) {
    return Consumer<VoteState>(

      builder: (context, voteState, child) {

        return charts.BarChart(
          retrieveVoteResult(context),
          animate: true,
        );
      },
    );
  }
/*
    return charts.BarChart(
      retrieveVoteResult(context),
      animate: true,
    );
    */




List<charts.Series<VoteData, String>> retrieveVoteResult(BuildContext context) {
  Vote activeVote = Provider
      .of<VoteState>(context, listen: false)
      .activeVote;

  List<VoteData> data = List<VoteData>();
  for (var option in activeVote.options) {
    option.forEach((Key, value) {
      data.add(VoteData(Key, value));
    });
  }

  return [
    charts.Series<VoteData, String>(
      id: 'VoteResult',
      colorFn: (_, pos) {
        if (pos % 2 == 0) {
          return charts.MaterialPalette.green.shadeDefault;
        }
        return charts.MaterialPalette.blue.shadeDefault;
      },
      domainFn: (VoteData vote, _) => vote.option,
      measureFn: (VoteData vote, _) => vote.total,
      //measureFn: (VoteData vote, _) => currentVote,
      data: data,
    )
  ];
}

void retrieveActiveVoteData(BuildContext context) {
  final voteId =
      Provider.of<VoteState>(context, listen: false).activeVote?.voteId;
  retrieveMarkedVoteFromFirestore(voteId: voteId, context: context);
}
}

class VoteData {
  final String option;
  final int total;

  //final int  dbtotal;

  VoteData(this.option, this.total);
}
