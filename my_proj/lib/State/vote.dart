// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_proj/models/service.dart';
import 'package:my_proj/models/vote.dart';

class VoteState with ChangeNotifier {
  List<Vote> _voteList = List<Vote>();
  Vote _activeVote;
  String _selectedOptionInActiveVote;
  bool _selected = false;

  bool get selected => _selected;

  set selected(bool value) {
    _selected = value;
  }

  void loadVoteList() async {
    _voteList = getVoteList();
    notifyListeners();
  }

  void clearState() {
    _activeVote = null;
    _selectedOptionInActiveVote = null;
  }

  List<Vote> get voteList => _voteList;

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
}
