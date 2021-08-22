import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/teams_details_view_controller.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/widgets/team_member_list_item.dart';
import 'package:get/get.dart';

class TeamsDetailMembers extends StatelessWidget {
  final Team team;

  TeamsDetailMembers(this.team);

  @override
  Widget build(BuildContext context) {
    final TeamsDetailViewController viewController = Get.find<TeamsDetailViewController>();
    viewController.retrieveTeamMembers();

    return Obx(() => SafeArea(
          child: Scaffold(
              body: Column(
                children: <Widget>[
                  Visibility(
                      visible: viewController.isLoading.isFalse &&
                          viewController.fatalError.isFalse,
                      child:
                      Expanded(child: TeamMemberList(viewController.teamMemberList))),
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


class TeamMemberList extends StatelessWidget {
  final List<TeamMember> teamMembers;
  const TeamMemberList(this.teamMembers);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.teamMembers.length,
        itemBuilder: (BuildContext context, int index) {
          return TeamMemberListItem(
              teamMember: this.teamMembers[index], index: index);
        });
  }
}
