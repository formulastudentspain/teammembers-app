import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formulastudent/src/view/pages/drawer/drawer_widget.dart';
import 'package:formulastudent/src/view/pages/myteam/my_team_view_controller.dart';
import 'package:get/get.dart';

class MyTeamPage extends StatelessWidget {
  final MyTeamViewController viewController = Get.find<MyTeamViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('My team')
        ),
        drawer: DrawerWidget(this),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
        )
    );
  }
}