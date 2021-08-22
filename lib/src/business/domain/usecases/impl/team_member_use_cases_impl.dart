import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository.dart';
import 'package:formulastudent/src/business/domain/usecases/team_member_use_cases.dart';
import 'package:get/get.dart';

class TeamMemberUseCasesImpl extends GetxController implements TeamMemberUseCases{

  late TeamMemberRepository teamMemberRepository;

  TeamMemberUseCasesImpl(){
    this.teamMemberRepository = Get.find<TeamMemberRepository>();
  }

  @override
  Future<List<TeamMember>> getTeamMembersByTeam(String teamId) {
    return this.teamMemberRepository.getTeamMembersByTeam(teamId);
  }
}