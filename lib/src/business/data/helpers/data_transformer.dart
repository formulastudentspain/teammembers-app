import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class DataTransformer {

  /// Create a Team entity from FireStore snapshot
  Team createTeamFromSnapshot(DocumentSnapshot doc);

}