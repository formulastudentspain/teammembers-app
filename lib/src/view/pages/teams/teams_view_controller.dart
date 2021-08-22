import 'dart:async';

import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/repositories/app_exception.dart';
import 'package:formulastudent/src/business/domain/usecases/team_use_cases.dart';
import 'package:formulastudent/src/view/utils/snackbar_provider.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class TeamsViewController extends GetxController {

  late TeamUseCases teamUseCases;
  late SnackBarProvider snackBarProvider;

  final fatalError = false.obs;
  final isLoading = true.obs;
  final teamsList = List<Team>.empty().obs;

  TeamsViewController(){
    this.teamUseCases = Get.find<TeamUseCases>();
    this.snackBarProvider = Get.find<SnackBarProvider>();
  }

  retrieveTeams() async {
    isLoading.value = true;
    teamsList.value = await teamUseCases.getAllTeamsSortedByCarNumber().catchError((e) {
          FutureOr<List<Team>> failureResponse = [];
          snackBarProvider.provideErrorSnackBack((e as AppException).cause);
          fatalError.value = true;
          return failureResponse;
    });
    isLoading.value = false;
  }

  String getListItemBackground(Team team){
    if(team.type == "Combustion"){
      return "assets/images/teams_combustion_background.png";
    }else if(team.type == "Electric"){
      return "assets/images/teams_electric_background.png";
    }else{
      return "assets/images/teams_driverless_background.png";
    }
  }
}