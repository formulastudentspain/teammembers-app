import 'package:formulastudent/src/business/domain/entities/team_member.dart';

abstract class TeamMemberUseCases {

  Future<List<TeamMember>> getTeamMembersByTeam(String teamId);

}