import 'package:flutter/material.dart';
import 'package:local_storage_cloude/condroller/home_screen_controller.dart';
import 'package:local_storage_cloude/utils/color_constants.dart';
import 'package:local_storage_cloude/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HomeScreenController.initDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
