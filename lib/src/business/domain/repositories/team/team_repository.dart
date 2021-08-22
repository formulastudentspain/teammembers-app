import 'package:formulastudent/src/business/domain/entities/team.dart';

abstract class TeamRepository{

  /// Get all teams
  Future<List<Team>> getAllTeams();

}