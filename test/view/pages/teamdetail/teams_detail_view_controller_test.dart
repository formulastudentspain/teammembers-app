import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository_exception.dart';
import 'package:formulastudent/src/business/domain/usecases/team_member_use_cases.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/teams_details_view_controller.dart';
import 'package:formulastudent/src/view/utils/snackbar_provider.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'teams_detail_view_controller_test.mocks.dart';

@GenerateMocks([TeamMemberUseCases, SnackBarProvider])
void main(){

  //Init mocks
  final mockTeamMemberUseCases = new MockTeamMemberUseCases();
  final mockSnackBarProvider = new MockSnackBarProvider();
  Get.put<TeamMemberUseCases>(mockTeamMemberUseCases);
  Get.put<SnackBarProvider>(mockSnackBarProvider);


  test("retrieveTeamMembers_retrievedEmpty_Ok", () async {
    when(mockTeamMemberUseCases.getTeamMembersByTeam(any))
        .thenAnswer((_) async => List.empty());

    TeamsDetailViewController viewController = TeamsDetailViewController();
    expect(viewController.isLoading.value, true);
    await viewController.retrieveTeamMembers();
    expect(viewController.isLoading.value, false);
    expect(viewController.teamMemberList.length, 0);
    expect(viewController.fatalError.value, false);
    verifyNever(mockSnackBarProvider.provideErrorSnackBack(any));
  });

  test("retrieveTeamMembers_retrievedNotEmpty_Ok", () async {
    when(mockTeamMemberUseCases.getTeamMembersByTeam(any))
        .thenAnswer((_) async => createTeamMemberList(2));

    TeamsDetailViewController viewController = TeamsDetailViewController();
    expect(viewController.isLoading.value, true);
    await viewController.retrieveTeamMembers();
    expect(viewController.isLoading.value, false);
    expect(viewController.teamMemberList.length, 2);
    expect(viewController.fatalError.value, false);
    verifyNever(mockSnackBarProvider.provideErrorSnackBack(any));
  });

  test("retrieveTeamMembers_withError", () async {
    when(mockTeamMemberUseCases.getTeamMembersByTeam(any))
        .thenAnswer((_) async =>  Future.error(TeamMemberRepositoryException('Error retrieving team members'), StackTrace.empty));

    TeamsDetailViewController viewController = TeamsDetailViewController();
    expect(viewController.isLoading.value, true);
    await viewController.retrieveTeamMembers();
    expect(viewController.isLoading.value, false);
    expect(viewController.teamMemberList.length, 0);
    expect(viewController.fatalError.value, true);
    verify(mockSnackBarProvider.provideErrorSnackBack(any));
  });
}

List<TeamMember> createTeamMemberList(int numberOfTeamMembers){
  List<TeamMember> teamMembers = [];
  for(int i=0; i<numberOfTeamMembers; i++){
    teamMembers.add(TeamMember());
  }
  return teamMembers;
}

Team createValidTeam(){
  Team team = new Team();
  team.id = "teamId";
  return team;
}

