import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/teams_details_view_controller.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/widgets/teams_detail_tab_info.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/widgets/teams_detail_tab_members.dart';
import 'package:get/get.dart';


class TeamsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final TeamsDetailViewController viewController = Get.find<TeamsDetailViewController>();

    return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: Text(viewController.selectedTeam.name),
              ),
              bottomNavigationBar: BottomNavigation(),
              body: Pages(viewController.selectedTeam)),
        );
  }
}

class BottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TeamsDetailViewController viewController = Get.find<TeamsDetailViewController>();

    return Obx(() => BottomNavigationBar(
        currentIndex: viewController.currentPage,
        selectedItemColor: Colors.red,
        onTap: (i) => viewController.onTabTapped(i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Members'),
        ]));
  }
}

class Pages extends StatelessWidget {
  final Team team;

  Pages(this.team);

  @override
  Widget build(BuildContext context) {
    final TeamsDetailViewController viewController = Get.find<TeamsDetailViewController>();

    return PageView(
      controller: viewController.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        TeamsDetailInfo(team),
        TeamsDetailMembers(team),
      ],
    );
  }
}
