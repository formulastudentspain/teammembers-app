import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/data/constants.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository_exception.dart';
import 'package:get/get.dart';


class TeamRepositoryFirebaseImpl implements TeamRepository{

  late FirebaseFirestore fireStore;
  late DataTransformer dataTransformer;

  TeamRepositoryFirebaseImpl() {
    this.fireStore = Get.find<FirebaseFirestore>();
    this.dataTransformer = Get.find<DataTransformer>();
  }

  @override
  Future<List<Team>> getAllTeams() async{
    try {
      QuerySnapshot teamsSnapshot = await this.fireStore
          .collection(FIREBASE_TABLE_TEAM)
          .orderBy('car.number')
          .get();

      List<Team> teams = [];
      for (DocumentSnapshot doc in teamsSnapshot.docs) {
        teams.add(this.dataTransformer.createTeamFromSnapshot(doc));
      }
      return teams;

    } catch(exception, stackTrace){
      return Future.error(TeamRepositoryException('Error retrieving all teams'), stackTrace);
    }
  }
}