import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository_exception.dart';
import 'package:formulastudent/src/business/domain/usecases/impl/team_use_cases_impl.dart';
import 'package:formulastudent/src/business/domain/usecases/team_use_cases.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'team_use_cases_test.mocks.dart';

@GenerateMocks([TeamRepository])
void main() {

  //Init mocks
  final mockTeamRepository = new MockTeamRepository();
  Get.put<TeamRepository>(mockTeamRepository);

  test("getAllTeamsSortedByCarNumber_Ok", () async {
    when(mockTeamRepository.getAllTeams())
        .thenAnswer((_) async => List.empty());

    TeamUseCases teamUseCases = TeamUseCasesImpl();
    List<Team> teams = await teamUseCases.getAllTeamsSortedByCarNumber();
    expect(teams.length, 0);

    when(mockTeamRepository.getAllTeams())
        .thenAnswer((_) async => createTeamList(2));

    teams = await teamUseCases.getAllTeamsSortedByCarNumber();
    expect(teams.length, 2);
  });

  test("getAllTeamsSortedByCarNumber_Exception", () async {
    when(mockTeamRepository.getAllTeams())
        .thenAnswer((_) async =>  Future.error(TeamRepositoryException('Error retrieving all teams'), StackTrace.empty));

    TeamUseCases teamUseCases = TeamUseCasesImpl();
    await teamUseCases.getAllTeamsSortedByCarNumber().catchError((e) {
      FutureOr<List<Team>> failureResponse = [];
      expect(e is TeamRepositoryException, true);
      expect((e as TeamRepositoryException).cause, 'Error retrieving all teams');
      return failureResponse;
    });
  });

}

List<Team> createTeamList(int numberOfTeams){
  List<Team> teams = [];
  for(int i=0; i<numberOfTeams; i++){
    teams.add(Team());
  }
  return teams;
}


