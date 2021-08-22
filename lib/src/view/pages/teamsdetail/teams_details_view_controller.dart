import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:get/get.dart';

class TeamsDetailViewController extends GetxController {

  late Team selectedTeam;
  final fatalError = false.obs;
  final isLoading = true.obs;

  //Paging conf
  late PageController pageController;
  final _currentPage = 0.obs;


  TeamsDetailViewController(){
    //this.teamUseCases = Get.find<TeamUseCases>();
    this.selectedTeam = Get.arguments;
    pageController = new PageController();
  }

  int get currentPage => _currentPage.value;

  void onTabTapped(int valor) {
    this._currentPage.value = valor;
    pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }
}