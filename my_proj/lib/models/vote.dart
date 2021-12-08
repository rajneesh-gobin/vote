// @dart=2.9
class Vote{
  String voteId;
  String voteTitle;
  List <Map <String, String>>options;

  Vote({ this.voteId, this.voteTitle, this.options});
}

class Voter {
  String uid;
  String voteId;
  int markedVoteOption;
}
