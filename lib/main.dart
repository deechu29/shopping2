import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping2/controller/home_screen_controller.dart';

import 'package:shopping2/view/home_screen/homescreen.dart';


void main() {
  runApp(MYApp());
}

class MYApp extends StatelessWidget {
  const MYApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeScreenController(),
          )
        ],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
  }
}
