import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';
import 'package:formulastudent/src/view/pages/teams/teams_view_controller.dart';
import 'package:get/get.dart';

class TeamListItem extends StatelessWidget {
  final Team team;
  final int index;

  final TeamsViewController viewController = Get.find<TeamsViewController>();

  TeamListItem({required this.team, required this.index});

  @override
  Widget build(BuildContext context) {
    var opcion2 = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'team_detail',
            arguments: TeamDetailArguments(team));
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 95.0,
            width: double.infinity,
            margin: new EdgeInsets.only(left: 18.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(viewController.getListItemBackground(team)),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: team.number.toString() + "logo",
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(team.logo),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 270,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 90.0, top: 30.0, bottom: 8.0),
                    child: Hero(
                      tag: team.number.toString() + "name",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(team.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 270,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 90.0, top: 50.0, bottom: 8.0),
                    child: Hero(
                      tag: team.number.toString() + "university",
                      child: Material(
                        color: Colors.transparent,
                        child: Text("Team university",
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 280.0, top: 35.0, bottom: 8.0),
                  child: Icon(Icons.chevron_right,
                      color: Colors.black26, size: 24.0),
                ),
              ],
            ),
          ),
          Container(
            margin: new EdgeInsets.symmetric(vertical: 29.0),
            alignment: FractionalOffset.centerLeft,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black12,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Hero(
                  tag: team.number.toString() + "number",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(team.number.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
        child: opcion2);
  }
}

class TeamDetailArguments {
  final Team team;
  TeamDetailArguments(this.team);
}