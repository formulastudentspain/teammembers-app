import 'package:flutter/widgets.dart';
import 'package:formulastudent/src/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(App());
}