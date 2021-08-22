import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository.dart';
import 'package:formulastudent/src/business/domain/usecases/team_use_cases.dart';
import 'package:get/get.dart';

class TeamUseCasesImpl extends GetxController implements TeamUseCases{

  late TeamRepository teamRepository;

  TeamUseCasesImpl(){
    this.teamRepository = Get.find<TeamRepository>();
  }

  @override
  Future<List<Team>> getAllTeamsSortedByCarNumber(){
    return this.teamRepository.getAllTeams();
  }
}