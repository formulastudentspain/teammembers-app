import 'package:flutter/material.dart';
import 'package:formulastudent/src/business/domain/entities/team_member.dart';

class TeamMemberListItem extends StatelessWidget {
  final TeamMember teamMember;
  final int index;

  const TeamMemberListItem({required this.teamMember, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
      child: listItem(context),
    );
  }

  Widget listItem(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 95.0,
          width: double.infinity,
          decoration: new BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/teams_neutral_background.png"),
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
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(teamMember.profileImage),
                  ),
                ),
              ),
              Container(
                width: 270,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 90.0, top: 25.0, bottom: 8.0),
                  child: Text(teamMember.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                width: 270,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 90.0, top: 40.0, bottom: 8.0),
                  child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0,
                    children: getRoles(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getRoles(){
    List<Widget> roleList = [];

    if(teamMember.isTeamLeader){
      roleList.add(createRoleChip("Leader", Colors.orange));
    }
    if(teamMember.isAsr){
      roleList.add(createRoleChip("ASR", Colors.blue));
    }
    if(teamMember.isDriver){
      roleList.add(createRoleChip("Driver", Colors.red));
    }
    if(teamMember.isEso){
      roleList.add(createRoleChip("ESO", Colors.green));
    }
    return roleList;
  }

  Chip createRoleChip(String role, MaterialColor color){
    return Chip(
      backgroundColor: color.shade50,
      label: Text(role,
          style: TextStyle(fontSize: 12)),
    );
  }
}