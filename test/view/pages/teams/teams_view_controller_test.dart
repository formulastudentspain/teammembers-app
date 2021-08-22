import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/usecases/team_use_cases.dart';
import 'package:formulastudent/src/view/pages/teams/teams_view_controller.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'teams_view_controller_test.mocks.dart';

@GenerateMocks([TeamUseCases])
void main(){

  //Init mocks
  final mockTeamUseCases = new MockTeamUseCases();
  Get.put<TeamUseCases>(mockTeamUseCases);


  test("retrieveTeams_retrievedEmpty_Ok", () async {
    when(mockTeamUseCases.getAllTeamsSortedByCarNumber())
        .thenAnswer((_) async => List.empty());

    TeamsViewController viewController = TeamsViewController();
    expect(viewController.isLoading.value, true);
    await viewController.retrieveTeams();
    expect(viewController.isLoading.value, false);
    expect(viewController.teamsList.length, 0);
  });

  test("retrieveTeams_retrievedNotEmpty_Ok", () async {
    when(mockTeamUseCases.getAllTeamsSortedByCarNumber())
        .thenAnswer((_) async => createTeamList(2));

    TeamsViewController viewController = TeamsViewController();
    expect(viewController.isLoading.value, true);
    await viewController.retrieveTeams();
    expect(viewController.isLoading.value, false);
    expect(viewController.teamsList.length, 2);
  });

  test("getListItemBackground_Ok", () async {

    TeamsViewController viewController = TeamsViewController();
    Team team = Team();

    //Combustion
    team.type = 'Combustion';
    String assetPath = viewController.getListItemBackground(team);
    expect(assetPath, 'assets/images/teams_combustion_background.png');

    //Electric
    team.type = 'Electric';
    assetPath = viewController.getListItemBackground(team);
    expect(assetPath, 'assets/images/teams_electric_background.png');

    //Combustion
    team.type = 'Driverless';
    assetPath = viewController.getListItemBackground(team);
    expect(assetPath, 'assets/images/teams_driverless_background.png');
  });

}

List<Team> createTeamList(int numberOfTeams){
  List<Team> teams = [];
  for(int i=0; i<numberOfTeams; i++){
    teams.add(Team());
  }
  return teams;
}

