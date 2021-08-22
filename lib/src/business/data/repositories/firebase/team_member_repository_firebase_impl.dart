import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/data/constants.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository_exception.dart';
import 'package:get/get.dart';


class TeamMemberRepositoryFirebaseImpl implements TeamMemberRepository{

  late FirebaseFirestore fireStore;
  late DataTransformer dataTransformer;

  TeamMemberRepositoryFirebaseImpl() {
    this.fireStore = Get.find<FirebaseFirestore>();
    this.dataTransformer = Get.find<DataTransformer>();
  }

  @override
  Future<List<TeamMember>> getTeamMembersByTeam(String teamId) async{
    try {

      QuerySnapshot teamMembersSnapshot = await this.fireStore
          .collection(FIREBASE_TABLE_TEAM_MEMBER)
          .where("teamID", isEqualTo: teamId)
          .get();

      List<TeamMember> teamMembers = [];
      for(DocumentSnapshot doc in teamMembersSnapshot.docs){
        teamMembers.add(this.dataTransformer.createTeamMemberFromSnapshot(doc));
      }

      return teamMembers;

    } catch(exception, stackTrace){
      return Future.error(TeamMemberRepositoryException('Error retrieving team members'), stackTrace);
    }
  }
}