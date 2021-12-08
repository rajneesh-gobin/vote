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
const String docID = '84O1gxRdv19ID4ThjdgX';

void getVoteListFromFirestore(BuildContext context) async {
  List<Vote> voteList = List<Vote>();

/*
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection(kVotes);


    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();


    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    voteList.add(mapFirestoreDocToVote(allData));

    print(allData);*/

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection(kVotes);

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
    print(allData);

    allData.forEach(( document) {
      voteList.add(mapFirestoreDocToVote(document));
    });
    Provider.of<VoteState>(context, listen: false).voteList = voteList;

  }
/*
  FirebaseFirestore.instance.collection(kVotes).get().then((snapshot) {

    List<Vote> voteList = List<Vote>();

    snapshot.docs.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });

  */

  getData();
/*
  FirebaseFirestore.instance
      .collection(kVotes)
      .doc()
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      voteList.add(mapFirestoreDocToVote(documentSnapshot));
      Provider.of<VoteState>(context, listen: false).voteList = voteList;

      print('Document data: ${documentSnapshot.data()}');
    } else {
      print('Document does not exist on the database');
    }
  });


  Firestore.instance.collection(kVotes).getDocuments().then((snapshot) {
    List<Vote> voteList = List<Vote>();

    snapshot.documents.forEach((DocumentSnapshot document) {
      voteList.add(mapFirestoreDocToVote(document));
    });

    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });
  */
}

Vote mapFirestoreDocToVote(document) {
  print(document);
  //Vote vote = Vote(voteId: document.reference.documentID);
  Vote vote = Vote(voteId: docID);
  List<Map<String, String>> options = List();
  document.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key:value.toString() });
    }
  });

  vote.options = options;
  return vote;
}
void markVote(String voteId, String option) async {
  // increment value

  FirebaseFirestore.instance.collection(kVotes).doc(voteId).update({
    option: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  FirebaseFirestore.instance.collection(kVotes).doc(voteId).get().then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });
}