// @dart=2.9
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import "package:my_proj/State/vote.dart";
import "package:my_proj/models/vote.dart";
import 'package:flutter/material.dart';

List<Vote> getVoteList() {
  List<Vote> voteList = List<Vote>();

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Village Council Election?',
      options: [
        {'Dr Haridow chaw': 1},
        {'Mr Patapre Alion': 2},
        {'Mr patison': 3},
      ],
    ),
  );

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'Presidential Election?',
      options: [
        {'Mr KashAmm Uthem': 5},
        {'Mr KayLesh Jgupal': 7}
      ],
    ),
  );

  voteList.add(
    Vote(
      voteId: Uuid().v4(),
      voteTitle: 'General Election 2024?',
      options: [
        {'Nuvin Ram': 4},
        {'Nuvin bola': 2},
        {'kopine Ram': 3},
        {'Praveen Note': 1},
        {'Mr CealMia': 3},
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

    allData.forEach((document) {
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
  List<Map<String, int>> options = List();
  document.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String voteId, String option, BuildContext context) async {
  // increment value

  FirebaseFirestore.instance.collection(kVotes).doc(voteId).update({
    option: FieldValue.increment(1),
  });
  String district =Provider.of<VoteState>(context, listen: false).district;
  FirebaseFirestore.instance.collection('districtinformation').doc('bYHNVpPKmOmhEQpBl6xB').update({
    district: FieldValue.increment(1),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  FirebaseFirestore.instance
      .collection(kVotes)
      .doc(voteId)
      .get()
      .then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });
}

void checkNicExist (String nic,BuildContext context)  {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('userinformation');

  Future<void> getNicData( context) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.where("nic", isEqualTo: nic).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();


    Provider.of<VoteState>(context, listen: false).nicVerified = true;
    Provider.of<VoteState>(context, listen: false).numofnic = allData.length;
    if(allData.length>0){
      var dJson = jsonEncode(allData[0]);
      allData.forEach((document) {
        print(document);
      });
      final parsedJson = jsonDecode(dJson);
      print('${parsedJson.runtimeType} : $parsedJson');
      //print(parsedJson.nic);
      parsedJson.forEach((key, value) {
        print(value);
        print(key);
        if(key=="nic"){
          Provider.of<VoteState>(context, listen: false).nic = value;
        }
        if(key=="voted"){
          Provider.of<VoteState>(context, listen: false).voted = value;
          print(Provider.of<VoteState>(context, listen: false).voted);
          print('value');
          print(value);
          //Provider.of<VoteState>(context, listen: false).voted = value;
        }
      });
    }
  }
  getNicData(context);

}

void saveUerDetails(String nic,String name,String email,String address) {
  // Retrieve updated doc from server

  CollectionReference users = FirebaseFirestore.instance.collection('userinformation');
  users.add({
    'nic': nic,
    'name': name,
    'district': address,
    'email': email,
    'voted': false
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

}

void getdatabyemail (String email,BuildContext context )  {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('userinformation');

  Future<void> getemailData( context) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.where("email", isEqualTo: email).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    print(allData.length);

    if(allData.length>0){
      var dJson = jsonEncode(allData[0]);
      allData.forEach((document) {
        print(document);
      });
      final parsedJson = jsonDecode(dJson);
      print('${parsedJson.runtimeType} : $parsedJson');
      //print(parsedJson.nic);
      parsedJson.forEach((key, value) {
        print(value);
        print(key);
        if(key=="voted"){
          Provider.of<VoteState>(context, listen: false).voted = value;
          print(Provider.of<VoteState>(context, listen: false).voted);
          print('value');
          print(value);
          //Provider.of<VoteState>(context, listen: false).voted = value;
        }
      });
    }
  }
  getemailData(context);

}

void checkemailExist (String email,BuildContext context)  {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('userinformation');

  Future<void> getNicData( context) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.where("email", isEqualTo: email).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    print(allData.length);
    if(allData.length>0){
      var dJson = jsonEncode(allData[0]);
      allData.forEach((document) {
        print(document);
      });
      final parsedJson = jsonDecode(dJson);
      print('${parsedJson.runtimeType} : $parsedJson');
      //print(parsedJson.nic);
      parsedJson.forEach((key, value) {
        print(value);
        print(key);
        if(key=="nic"){
          Provider.of<VoteState>(context, listen: false).nic = value;
        }
        if(key=="voted"){
          Provider.of<VoteState>(context, listen: false).voted = value;
        }
        if(key=="district"){
          Provider.of<VoteState>(context, listen: false).district = value;
        }
      });
    }
  }
  getNicData(context);

}
void updateVotePoll (BuildContext context) {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('districtinformation');

  Future<void> getNicData(context) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    print(allData.length);
    if (allData.length > 0) {
      var dJson = jsonEncode(allData[0]);
      allData.forEach((document) {
        print(document);
      });
      final parsedJson = jsonDecode(dJson);
      print('${parsedJson.runtimeType} : $parsedJson');
      //print(parsedJson.nic);
      parsedJson.forEach((key, value) {
        print(value);
        print(key);
        if (key == "BlackRiver") {
          Provider
              .of<VoteState>(context, listen: false)
              .BlackRiverVoted = value;
        }
        if (key == "Flacq") {
          Provider
              .of<VoteState>(context, listen: false)
              .FlacqVoted = value;
        }
        if (key == "GrandPort") {
          Provider
              .of<VoteState>(context, listen: false)
              .GrandPortVoted = value;
        }
        if (key == "Moka") {
          Provider
              .of<VoteState>(context, listen: false)
              .MokaVoted = value;
        }
        if (key == "Pamplemousses") {
          Provider
              .of<VoteState>(context, listen: false)
              .PamplemoussesVoted = value;
        }
        if (key == "PlainesWilhems") {
          Provider
              .of<VoteState>(context, listen: false)
              .PlainesWilhemsVoted = value;
        }
        if (key == "PortLouis") {
          Provider
              .of<VoteState>(context, listen: false)
              .PortLouisVoted = value;
        }
        if (key == "RiviereduRempart") {
          Provider
              .of<VoteState>(context, listen: false)
              .RiviereduRempartVoted = value;
        }
        if (key == "Savanne") {
          Provider
              .of<VoteState>(context, listen: false)
              .SavanneVoted = value;
        }
      });
    }
  }
  getNicData(context);
}
void updateNoVotePoll (BuildContext context)  {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('userinformation');

  Future<void> getNicData( context) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'BlackRiver').get();
    final BlackRiver = querySnapshot.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).BlackRiverNoVoted = BlackRiver.length;


    QuerySnapshot querySnapshotFlacq =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'Flacq').get();
    final Flacq = querySnapshotFlacq.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).FlacqNoVoted = Flacq.length;


    QuerySnapshot querySnapshotGrandPort =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'GrandPort').get();
    final GrandPort = querySnapshotGrandPort.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).GrandPortNoVoted = GrandPort.length;



    QuerySnapshot querySnapshotMoka =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'Moka').get();
    final Moka = querySnapshotMoka.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).MokaNoVoted = Moka.length;


    QuerySnapshot querySnapshotPamplemousses =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'BlackRiver').get();
    final Pamplemousses = querySnapshotPamplemousses.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).PamplemoussesNoVoted = Pamplemousses.length;


    QuerySnapshot querySnapshotPlainesWilhems =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'BlackRiver').get();
    final PlainesWilhems = querySnapshotPlainesWilhems.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).PlainesWilhemsNoVoted = PlainesWilhems.length;


    QuerySnapshot querySnapshotPortLouis =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'BlackRiver').get();
    final PortLouis = querySnapshotPortLouis.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).PortLouisNoVoted = PortLouis.length;


    QuerySnapshot querySnapshotRiviereduRempart =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'RiviereduRempart').get();
    final RiviereduRempart = querySnapshotRiviereduRempart.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).RiviereduRempartNoVoted = RiviereduRempart.length;


    QuerySnapshot querySnapshotSavanne =  await _collectionRef.where("voted", isEqualTo: false).where("district", isEqualTo: 'Savanne').get();
    final Savanne = querySnapshotSavanne.docs.map((doc) => doc.data()).toList();
    Provider.of<VoteState>(context, listen: false).SavanneNoVoted = Savanne.length;

  };
  getNicData(context);
  }



