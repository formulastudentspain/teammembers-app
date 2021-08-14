import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/pages.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formula Student Spain',
      initialRoute: '/timeline',
      getPages: getApplicationPages(),
      theme: ThemeData(
        primaryColorLight: Color.fromRGBO(212,212,212,1),
        primaryColorDark: Color.fromRGBO(43,42,42,1),
        primaryColor: Color.fromRGBO(101,100,100,1),
        accentColor: Color.fromRGBO(251, 81, 92,1),
      ),
    );
  }
}
