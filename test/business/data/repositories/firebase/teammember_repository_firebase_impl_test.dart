import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/data/repositories/firebase/team_member_repository_firebase_impl.dart';
import 'package:formulastudent/src/business/data/repositories/firebase/team_repository_firebase_impl.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/business/domain/repositories/team/team_repository_exception.dart';
import 'package:formulastudent/src/business/domain/repositories/teammember/team_member_repository_exception.dart';

import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'custom_mock_behaviours.dart';
import 'team_repository_firebase_impl_test.mocks.dart';


/// Constants
const String TEAM_MEMBER_NAME = "name";
const String TEAM_MEMBER_MAIL = "mail@fss.com";
const String TEAM_MEMBER_PROFILE = "profile";

@GenerateMocks([FirebaseFirestore, DataTransformer, QuerySnapshot, CollectionReference, Query],
    customMocks: [
      MockSpec<QueryDocumentSnapshot>(fallbackGenerators: {#data: queryDocumentSnapshotDataMockBehaviour})
    ]
)
void main() {

  //Init mocks for dependencies
  final mockFirebaseFirestore = new MockFirebaseFirestore();
  final mockDataTransformer = new MockDataTransformer();
  Get.put<FirebaseFirestore>(mockFirebaseFirestore);
  Get.put<DataTransformer>(mockDataTransformer);

  test("getTeamMembersByTeam_Ok", () async {

    var mockQuerySnapshot = new MockQuerySnapshot<Map<String,dynamic>>();
    var mockQuery = new MockQuery<Map<String,dynamic>>();
    var mockCollectionReference = new MockCollectionReference<Map<String,dynamic>>();
    var listOfDocuments = [
      new MockQueryDocumentSnapshot<Map<String,dynamic>>(),
      new MockQueryDocumentSnapshot<Map<String,dynamic>>()
    ];

    when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.where(any, isEqualTo: anyNamed("isEqualTo"))).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn(listOfDocuments);
    when(mockDataTransformer.createTeamMemberFromSnapshot(any)).thenReturn(createTeamMember());

    var teamMemberRepository = new TeamMemberRepositoryFirebaseImpl();
    var teamMembers = await teamMemberRepository.getTeamMembersByTeam("teamId");

    expect(teamMembers.length, 2);
    expect(teamMembers[0].name, TEAM_MEMBER_NAME);
    expect(teamMembers[0].mail, TEAM_MEMBER_MAIL);
    expect(teamMembers[0].profileImage, TEAM_MEMBER_PROFILE);

  });

  test("getTeamMembersByTeam_throwError", () async {

    var mockQuerySnapshot = new MockQuerySnapshot<Map<String,dynamic>>();
    var mockQuery = new MockQuery<Map<String,dynamic>>();
    var mockCollectionReference = new MockCollectionReference<Map<String,dynamic>>();

    when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.orderBy(any)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenThrow(Exception());
    when(mockDataTransformer.createTeamMemberFromSnapshot(any)).thenReturn(createTeamMember());

    var teamMemberRepository = new TeamMemberRepositoryFirebaseImpl();
    await teamMemberRepository.getTeamMembersByTeam("teamId").catchError((e) {
      FutureOr<List<TeamMember>> failureResponse = [];
      expect(e is TeamMemberRepositoryException, true);
      expect((e as TeamMemberRepositoryException).cause, 'Error retrieving team members');
      return failureResponse;
    });
  });
}

/// Create a new fake team member
TeamMember createTeamMember(){
  TeamMember teamMember = new TeamMember();
  teamMember.name = TEAM_MEMBER_NAME;
  teamMember.mail = TEAM_MEMBER_MAIL;
  teamMember.profileImage = TEAM_MEMBER_PROFILE;
  return teamMember;
}
