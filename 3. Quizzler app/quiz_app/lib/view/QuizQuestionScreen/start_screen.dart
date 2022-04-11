import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/etx/strings.dart';
import 'package:quiz_app/model/user.dart';
import 'package:quiz_app/view/QuizQuestionScreen/textcountdown.dart';
import 'package:quiz_app/view/QuizQuestionScreen/quiz_question.dart';
import 'package:quiz_app/view_model/quaiz_question_view_model.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController _controller = TextEditingController();
  bool _ignoringButton = true;

  @override
  Widget build(BuildContext context) {
    double widthButtonStart = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 90),
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Text('Start game...',
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CupertinoTextField(
                  padding: EdgeInsets.all(15),
                  controller: _controller,
                  placeholder: 'Enter your name...',
                  onChanged: (text) {
                    setState(() => _ignoringButton = text.isEmpty);
                  },
                ),
              ),
              IgnorePointer(
                ignoring: _ignoringButton,
                child: SizedBox(
                  width: widthButtonStart - 60,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final model = Provider.of<QuizQuestionViewModel>(context,
                          listen: false);
                      final user = User(_controller.text, emojis.last);
                      model.initData(user: user);
                      var route = MaterialPageRoute(
                        builder: (context) => TextCountDown(
                          callback: () {
                            var route = MaterialPageRoute(
                                builder: (context) => QuizQuestionScreen());
                            Navigator.pushAndRemoveUntil(
                                context, route, (route) => route.isFirst);
                          },
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      primary: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(Icons.play_arrow),
                    label: Text(
                      'Start',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
