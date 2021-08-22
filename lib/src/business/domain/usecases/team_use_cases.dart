import 'package:formulastudent/src/business/domain/entities/team.dart';

abstract class TeamUseCases {

  Future<List<Team>> getAllTeamsSortedByCarNumber();

}