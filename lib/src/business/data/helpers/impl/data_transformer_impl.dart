import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataTransformerImpl extends GetxController implements DataTransformer{

  @override
  Team createTeamFromSnapshot(DocumentSnapshot doc){
    String emptyLogo = "https://www.andeditions.org/wp-content/uploads/2015/11/grey-square.jpg";
    Team team = Team();
    team.id = doc.id;
    team.name = doc.get('name');
    team.number = doc.get('car')['number'];
    team.type = doc.get('car')['type'];
    //team.logo = doc.get('logo') ?? emptyLogo;
    team.logo = emptyLogo;
    return team;
  }

  @override
  TeamMember createTeamMemberFromSnapshot(DocumentSnapshot doc) {
      TeamMember teamMember = new TeamMember();
      teamMember.name = doc.get('name');
      teamMember.mail = doc.get('mail');
      teamMember.profileImage = doc.get('imageURL');
      teamMember.isDriver = doc.get('isDriver');
      teamMember.isAsr = doc.get('isAsr');
      teamMember.isEso = doc.get('isEso');
      //this._isTeamLeader = documentSnapshot.data['isTeamLeader'];
      return teamMember;
  }

}