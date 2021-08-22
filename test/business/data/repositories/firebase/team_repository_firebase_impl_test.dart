import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/data/repositories/firebase/team_repository_firebase_impl.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository_exception.dart';

import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'custom_mock_behaviours.dart';
import 'team_repository_firebase_impl_test.mocks.dart';


/// Constants
const String TEAM_NAME = "teamName";
const String TEAM_TYPE = "combustion";
const String TEAM_ID = "0";
const String TEAM_LOGO = "logo";

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

  test("getAllTeams_Ok", () async {

    var mockQuerySnapshot = new MockQuerySnapshot<Map<String,dynamic>>();
    var mockQuery = new MockQuery<Map<String,dynamic>>();
    var mockCollectionReference = new MockCollectionReference<Map<String,dynamic>>();
    var listOfDocuments = [
      new MockQueryDocumentSnapshot<Map<String,dynamic>>(),
      new MockQueryDocumentSnapshot<Map<String,dynamic>>()
    ];

    when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.orderBy(any)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn(listOfDocuments);
    when(mockDataTransformer.createTeamFromSnapshot(any)).thenReturn(createTeam());

    var teamRepository = new TeamRepositoryFirebaseImpl();
    var teams = await teamRepository.getAllTeams();

    expect(teams.length, 2);
    expect(teams[0].name, TEAM_NAME);
    expect(teams[0].type, TEAM_TYPE);
    expect(teams[0].id, TEAM_ID);
    expect(teams[0].logo, TEAM_LOGO);
    expect(teams[1].name, TEAM_NAME);
    expect(teams[1].type, TEAM_TYPE);
    expect(teams[1].id, TEAM_ID);
    expect(teams[1].logo, TEAM_LOGO);
  });

  test("getAllTeams_throwError", () async {

    var mockQuerySnapshot = new MockQuerySnapshot<Map<String,dynamic>>();
    var mockQuery = new MockQuery<Map<String,dynamic>>();
    var mockCollectionReference = new MockCollectionReference<Map<String,dynamic>>();

    when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.orderBy(any)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenThrow(Exception());
    when(mockDataTransformer.createTeamFromSnapshot(any)).thenReturn(createTeam());

    var teamRepository = new TeamRepositoryFirebaseImpl();
    await teamRepository.getAllTeams().catchError((e) {
      FutureOr<List<Team>> failureResponse = [];
      expect(e is TeamRepositoryException, true);
      expect((e as TeamRepositoryException).cause, 'Error retrieving all teams');
      return failureResponse;
    });
  });
}

/// Create a new fake team
Team createTeam(){
  Team team = new Team();
  team.name = TEAM_NAME;
  team.type = TEAM_TYPE;
  team.id = TEAM_ID;
  team.logo = TEAM_LOGO;
  return team;
}
