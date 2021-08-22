import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository_exception.dart';
import 'package:formulastudent/src/business/domain/usecases/impl/team_member_use_cases_impl.dart';
import 'package:formulastudent/src/business/domain/usecases/team_member_use_cases.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'team_member_use_cases_test.mocks.dart';

@GenerateMocks([TeamMemberRepository])
void main() {

  //Init mocks
  final mockTeamMemberRepository = new MockTeamMemberRepository();
  Get.put<TeamMemberRepository>(mockTeamMemberRepository);

  test("getTeamMembersByTeam_Ok", () async {
    when(mockTeamMemberRepository.getTeamMembersByTeam(any))
        .thenAnswer((_) async => List.empty());

    TeamMemberUseCases teamMemberUseCases = new TeamMemberUseCasesImpl();
    List<TeamMember> teamMembers = await teamMemberUseCases.getTeamMembersByTeam("teamId");
    expect(teamMembers.length, 0);

    when(mockTeamMemberRepository.getTeamMembersByTeam(any))
        .thenAnswer((_) async => createTeamMembers(2));

    teamMembers = await teamMemberUseCases.getTeamMembersByTeam("teamId");
    expect(teamMembers.length, 2);
  });

  test("getTeamMembersByTeam_Exception", () async {
    when(mockTeamMemberRepository.getTeamMembersByTeam(any))
        .thenAnswer((_) async =>  Future.error(TeamMemberRepositoryException('Error retrieving team members'), StackTrace.empty));

    TeamMemberUseCases teamMemberUseCases = new TeamMemberUseCasesImpl();
    await teamMemberUseCases.getTeamMembersByTeam("teamId").catchError((e) {
      FutureOr<List<TeamMember>> failureResponse = [];
      expect(e is TeamMemberRepositoryException, true);
      expect((e as TeamMemberRepositoryException).cause, 'Error retrieving team members');
      return failureResponse;
    });
  });

}

List<TeamMember> createTeamMembers(int numberOfTeamMembers){
  List<TeamMember> teamMembers = [];
  for(int i=0; i<numberOfTeamMembers; i++){
    teamMembers.add(TeamMember());
  }
  return teamMembers;
}


