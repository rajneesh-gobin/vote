// @dart=2.9
import 'package:my_proj/models/vote.dart';
import 'package:uuid/uuid.dart';


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
      {'Sir Nuvin Ram':"key"},
      {'Sir Nuvin bola':"key"},
      {'Sir kopine Ram':"key"},
      {'Mr Praveen Note':"sun"},
      {'Mr CealMia':"tree"},

    ],
  ),
  );
  return voteList;
}