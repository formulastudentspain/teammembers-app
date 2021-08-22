import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';

abstract class DataTransformer {

  /// Create a Team entity from FireStore snapshot
  Team createTeamFromSnapshot(DocumentSnapshot doc);

  /// Create a TeamMember entity from FireStore snapshot
  TeamMember createTeamMemberFromSnapshot(DocumentSnapshot doc);

}