import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formulastudent/src/view/pages/drawer/drawer_widget.dart';

class TimelinePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Timeline')
        ),
        drawer: DrawerWidget(this),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
        )
    );
  }
}