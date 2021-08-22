import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/app_exception.dart';
import 'package:formulastudent/src/business/domain/usecases/team_member_use_cases.dart';
import 'package:formulastudent/src/view/utils/snackbar_provider.dart';
import 'package:get/get.dart';

class TeamsDetailViewController extends GetxController {

  late Team selectedTeam;
  final fatalError = false.obs;
  final isLoading = true.obs;
  final teamMemberList = List<TeamMember>.empty().obs;
  late TeamMemberUseCases teamMemberUseCases;
  late SnackBarProvider snackBarProvider;

  //Paging conf
  late PageController pageController;
  final _currentPage = 0.obs;


  TeamsDetailViewController(){
    this.teamMemberUseCases = Get.find<TeamMemberUseCases>();
    this.snackBarProvider = Get.find<SnackBarProvider>();
    this.selectedTeam = Get.arguments ?? defaultTeamAsArgument();
    pageController = new PageController();
  }

  retrieveTeamMembers() async {
    if(teamMemberList.isEmpty) {
      isLoading.value = true;
      teamMemberList.value = await teamMemberUseCases.getTeamMembersByTeam(selectedTeam.id).catchError((e) {
        FutureOr<List<TeamMember>> failureResponse = [];
        snackBarProvider.provideErrorSnackBack((e as AppException).cause);
        fatalError.value = true;
        return failureResponse;
      });
      isLoading.value = false;
    }
  }

  void onTabTapped(int valor) {
    this._currentPage.value = valor;
    pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  /// Testing purpose, hard to mock arguments by now...
  Team defaultTeamAsArgument(){
    Team team = new Team();
    team.id = "teamId";
    return team;
  }

  int get currentPage => _currentPage.value;
}