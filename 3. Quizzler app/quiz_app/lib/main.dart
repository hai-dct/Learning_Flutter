import 'package:flutter/material.dart';
import 'package:quiz_app/view/QuizQuestionScreen/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/quaiz_question_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuizQuestionViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          backgroundColor: Colors.white,
        ),
        home: StartScreen(),
      ),
    );
  }
}
