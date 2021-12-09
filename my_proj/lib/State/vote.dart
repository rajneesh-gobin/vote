// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_proj/models/service.dart';
import 'package:my_proj/models/vote.dart';

class VoteState with ChangeNotifier {
  List<Vote> _voteList = List<Vote>();
  Vote _activeVote;
  String _selectedOptionInActiveVote;
  String _district;

  int _BlackRiverVoted;
  int _FlacqVoted;
  int _GrandPortVoted;

  int get BlackRiverVoted => _BlackRiverVoted;

  set BlackRiverVoted(int value) {
    _BlackRiverVoted = value;
  }

  int _MokaVoted;
  int _PamplemoussesVoted;
  int _PlainesWilhemsVoted;
  int _PortLouisVoted;
  int _RiviereduRempartVoted;
  int _SavanneVoted;

  int _BlackRiverNoVoted;
  int _FlacqNoVoted;
  int _GrandPortNoVoted;
  int _MokaNoVoted;
  int _PamplemoussesNoVoted;
  int _PlainesWilhemsNoVoted;
  int _PortLouisNoVoted;
  int _RiviereduRempartNoVoted;
  int _SavanneNoVoted;

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  bool _selected = false;
  bool _voted = false;

  bool get voted => _voted;

  set voted(bool value) {
    _voted = value;
  }

  int _numofnic=0;
  String _nic ="";

  String get nic => _nic;

  set nic(String value) {
    _nic = value;
  }

  int get numofnic => _numofnic;

  set numofnic(int value) {
    _numofnic = value;
  }

  bool _nicVerified=false;


  bool get selected => _selected;

  set selected(bool value) {
    _selected = value;
  }

  void loadVoteList(BuildContext context) async {
    //_voteList = getVoteList();
    //notifyListeners();
    getVoteListFromFirestore(context);
  }

  void clearState() {
    _voteList =null;
    _activeVote = null;
    _selectedOptionInActiveVote = null;
  }

  List<Vote> get voteList => _voteList;

  set voteList(newValue){
    _voteList=newValue;
    notifyListeners();
  }

  Vote get activeVote => _activeVote;

  String get selectedOptionInActiveVote => _selectedOptionInActiveVote;

  set activeVote(newValue) {
    _activeVote = newValue;
    notifyListeners();
  }

  void set selectedOptionInActiveVote(String newValue) {
    _selectedOptionInActiveVote = newValue;
    notifyListeners();
  }

  bool get nicVerified => _nicVerified;

  set nicVerified(bool value) {
    _nicVerified = value;
  }

  int get FlacqVoted => _FlacqVoted;

  set FlacqVoted(int value) {
    _FlacqVoted = value;
  }

  int get GrandPortVoted => _GrandPortVoted;

  set GrandPortVoted(int value) {
    _GrandPortVoted = value;
  }

  int get MokaVoted => _MokaVoted;

  set MokaVoted(int value) {
    _MokaVoted = value;
  }

  int get PamplemoussesVoted => _PamplemoussesVoted;

  set PamplemoussesVoted(int value) {
    _PamplemoussesVoted = value;
  }

  int get PlainesWilhemsVoted => _PlainesWilhemsVoted;

  set PlainesWilhemsVoted(int value) {
    _PlainesWilhemsVoted = value;
  }

  int get PortLouisVoted => _PortLouisVoted;

  set PortLouisVoted(int value) {
    _PortLouisVoted = value;
  }

  int get RiviereduRempartVoted => _RiviereduRempartVoted;

  set RiviereduRempartVoted(int value) {
    _RiviereduRempartVoted = value;
  }

  int get SavanneVoted => _SavanneVoted;

  set SavanneVoted(int value) {
    _SavanneVoted = value;
  }

  int get BlackRiverNoVoted => _BlackRiverNoVoted;

  set BlackRiverNoVoted(int value) {
    _BlackRiverNoVoted = value;
  }

  int get FlacqNoVoted => _FlacqNoVoted;

  set FlacqNoVoted(int value) {
    _FlacqNoVoted = value;
  }

  int get GrandPortNoVoted => _GrandPortNoVoted;

  set GrandPortNoVoted(int value) {
    _GrandPortNoVoted = value;
  }

  int get MokaNoVoted => _MokaNoVoted;

  set MokaNoVoted(int value) {
    _MokaNoVoted = value;
  }

  int get PamplemoussesNoVoted => _PamplemoussesNoVoted;

  set PamplemoussesNoVoted(int value) {
    _PamplemoussesNoVoted = value;
  }

  int get PlainesWilhemsNoVoted => _PlainesWilhemsNoVoted;

  set PlainesWilhemsNoVoted(int value) {
    _PlainesWilhemsNoVoted = value;
  }

  int get PortLouisNoVoted => _PortLouisNoVoted;

  set PortLouisNoVoted(int value) {
    _PortLouisNoVoted = value;
  }

  int get RiviereduRempartNoVoted => _RiviereduRempartNoVoted;

  set RiviereduRempartNoVoted(int value) {
    _RiviereduRempartNoVoted = value;
  }

  int get SavanneNoVoted => _SavanneNoVoted;

  set SavanneNoVoted(int value) {
    _SavanneNoVoted = value;
  }
}
