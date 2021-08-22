import 'package:formulastudent/src/business/domain/entities/team_member.dart';

abstract class TeamMemberRepository{

  /// Get team members by team
  Future<List<TeamMember>> getTeamMembersByTeam(String teamId);

}