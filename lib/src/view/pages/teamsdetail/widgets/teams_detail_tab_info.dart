import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team.dart';

class TeamsDetailInfo extends StatelessWidget {

  final Team team;

  TeamsDetailInfo(this.team);

  @override
  Widget build(BuildContext context) {
    Widget carHeader() {
      return Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("http://www.tufast.de/nb.jpg"),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            width: double.infinity,
            height: 4,
            decoration:
                BoxDecoration(color: Color.fromRGBO(255, 179, 175, 1.0)),
          ),
        ],
      );
    }

    Widget basicInfo() {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Hero(
              tag: team.number.toString() + "logo",
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(team.logo),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: team.number.toString() + "number",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        team.number.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 17.0),
                      ),
                    ),
                  ),
                  Hero(
                    tag: team.number.toString() + "name",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        team.name,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  Hero(
                    tag: team.number.toString() + "university",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "Team university",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget description() {
      return Text(
          "We are the best Formula Student team, well... that is what our grandma says.");
    }

    Widget separator(top) {
      return Padding(
        padding: EdgeInsets.only(top: top, bottom: 16.0),
        child: Container(
          width: 50,
          height: 2,
          decoration: BoxDecoration(color: Color.fromRGBO(255, 179, 175, 1.0)),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          carHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 160, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                basicInfo(),
                separator(16.0),
                description(),
                separator(16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
