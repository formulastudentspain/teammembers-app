import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/view/pages/drawer/drawer_widget.dart';
import 'package:formulastudent/src/view/pages/teams/teams_view_controller.dart';
import 'package:formulastudent/src/view/pages/teams/widgets/team_list_item.dart';
import 'package:get/get.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TeamsViewController viewController = Get.find<TeamsViewController>();
    viewController.retrieveTeams();

    return Obx(() => SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Teams'),
              ),
              drawer: DrawerWidget(this),
              body: Column(
                children: <Widget>[
                  Visibility(
                      visible: viewController.isLoading.isFalse &&
                          viewController.fatalError.isFalse,
                      child:
                          Expanded(child: TeamList(viewController.teamsList))),
                  Visibility(
                      visible: viewController.isLoading.isTrue,
                      child: Expanded(
                          child: Center(child: CircularProgressIndicator(color: Colors.red),
                      ))),
                  Visibility(
                      visible: viewController.fatalError.isTrue &&
                          viewController.fatalError.isTrue,
                      child: Expanded(child: Center(child: Text("Error"))))
                ],
              )),
        ));
  }
}

class TeamList extends StatelessWidget {
  final List<Team> teams;
  const TeamList(this.teams);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.teams.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TeamListItem(team: this.teams[index], index: index),
          );
        });
  }
}
