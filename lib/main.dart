import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workoutapp/pages/home_page.dart';

import 'data/workout_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkOutData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter workout App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: const HomePage(),
        ));
  }
}
