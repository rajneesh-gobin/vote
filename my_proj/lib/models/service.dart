// @dart=2.9
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import "package:my_proj/State/vote.dart";
import "package:my_proj/models/vote.dart";
import 'package:flutter/material.dart';
List<Vote> getVoteList()
{
  List<Vote>voteList =List<Vote>();

  voteList.add(Vote(
    voteId:  Uuid().v4(),
    voteTitle: 'Village Council Election?',
    options: [
      {'Dr Haridow chaw':"zoizo"},
      {'Mr Patapre Alion':"telephone"},
      {'Mr patison':"tamarin"},
    ],
  ),
  );

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Presidential Election?',
    options: [
      {'Mr KashAmm Uthem':"flag"},
      {'Mr KayLesh Jgupal':"piker"}
    ],
  ),
  );


  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'General Election 2024?',
    options: [
      {'Nuvin Ram':"key"},
      {'Nuvin bola':"key"},
      {'kopine Ram':"key"},
      {'Praveen Note':"sun"},
      {'Mr CealMia':"tree"},

    ],
  ),
  );
  return voteList;
}

// firestore collection name
const String kVotes = 'votes';
const String kTitle = 'title';

void getVoteListFromFirestore(BuildContext context) async {/*
  Firestore.instance.collection(kVotes).getDocuments().then((snapshot) {
    List<Vote> voteList = List<Vote>();

    snapshot.documents.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });*/
}

Vote mapFirestoreDocToVote(document) {
  Vote vote = Vote(voteId: document.documentID);
  List<Map<String, String>> options = List();
  document.data.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}
