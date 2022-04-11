import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/funny_question_model.dart';
import 'package:quiz_app/view/QuizQuestionScreen/ranks_widget.dart';
import 'package:quiz_app/view_model/quaiz_question_view_model.dart';
import 'package:provider/provider.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({Key? key}) : super(key: key);

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int quizTimeSecond = 30;
  double remainingSecond = 30;
  int _selectedOption = -1;
  bool isFlag = false, isFavourite = false;
  late var viewModelQuizQuest = QuizQuestionViewModel();
  int index = 1;
  int count = 0;
  int scores = 0;
  bool checkResults = false;

  List<String> _simpleChoice = ["Report", "Quit"];

  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void showResults() {
    setState(() {
      checkResults = true;
    });
  }

  void nextData() {
    if (index < viewModelQuizQuest.funnyQuestion.length) {
      setState(() {
        checkResults = false;
        remainingSecond = 30;
        count = count + 1;
        index = index + 1;
        _selectedOption = -1;
      });
    } else {
      remainingSecond = 0;
      _timer?.cancel();
      Provider.of<QuizQuestionViewModel>(context, listen: false)
          .updateRanks(scores);
      var route = MaterialPageRoute(builder: (context) => RanksWidget());
      Navigator.pushAndRemoveUntil(context, route, (route) => route.isFirst);
    }
  }

  void startTimer() {
    _timer = Timer.periodic(
        Duration(milliseconds: 200),
        (Timer timer) => {
              setState(() {
                if (remainingSecond > 0.200) {
                  remainingSecond = remainingSecond - 0.200;
                } else {
                  // remainingSecond = 0;
                  // timer.cancel();
                  nextData();
                }
              })
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    viewModelQuizQuest = Provider.of<QuizQuestionViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: viewModelQuizQuest.funnyQuestion != null &&
              viewModelQuizQuest.title != null
          ? Container(
              child: Column(
                children: <Widget>[
                  showTitleQuestion(
                      title: viewModelQuizQuest.title.toString(),
                      question: "Question " +
                          index.toString() +
                          "/" +
                          viewModelQuizQuest.funnyQuestion.length.toString(),
                      simpleChoice: _simpleChoice),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(48, 0, 48, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text(
                              viewModelQuizQuest.funnyQuestion[count].question,
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 0.2,
                                  wordSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff495057)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: viewModelQuizQuest
                                    .funnyQuestion[count].checkImageUrl
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      questionOption(
                                          option: viewModelQuizQuest
                                              .funnyQuestion[count].answer[0],
                                          index: 0),
                                      questionOption(
                                          option: viewModelQuizQuest
                                              .funnyQuestion[count].answer[1],
                                          index: 1),
                                      questionOption(
                                          option: viewModelQuizQuest
                                              .funnyQuestion[count].answer[2],
                                          index: 2),
                                      questionOption(
                                          option: viewModelQuizQuest
                                              .funnyQuestion[count].answer[3],
                                          index: 3),
                                    ],
                                  )
                                : Wrap(
                                    runSpacing: 30,
                                    spacing: 30,
                                    children: [
                                      imageQuestionOption(
                                          answer: viewModelQuizQuest
                                              .funnyQuestion[count].answer[0],
                                          index: 0),
                                      imageQuestionOption(
                                          answer: viewModelQuizQuest
                                              .funnyQuestion[count].answer[1],
                                          index: 1),
                                      imageQuestionOption(
                                          answer: viewModelQuizQuest
                                              .funnyQuestion[count].answer[2],
                                          index: 2),
                                      imageQuestionOption(
                                          answer: viewModelQuizQuest
                                              .funnyQuestion[count].answer[3],
                                          index: 3)
                                    ],
                                  ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      if (_selectedOption >= 0) {
                                        if (viewModelQuizQuest
                                            .funnyQuestion[count]
                                            .answer[_selectedOption]
                                            .isAnswer) {
                                          scores = scores + 100;
                                          print(scores);
                                        } else {
                                          scores = scores;
                                        }
                                      }
                                      showResults();
                                      Timer(Duration(seconds: 1), () {
                                        nextData();
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "SUBMIT",
                                          style: TextStyle(
                                            color: Color(0xff3d63ff),
                                            letterSpacing: 0.5,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: Color(0xff3d63ff),
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFlag = !isFlag;
                            });
                          },
                          child: Container(
                            child: Icon(
                              isFlag ? Icons.flag : Icons.flag_outlined,
                              color: isFlag
                                  ? Color(0xff3d63ff)
                                  : Color(0xff495057),
                              size: 26,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: buildTimer(),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          },
                          child: Container(
                            child: Icon(
                              isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavourite
                                  ? Color(0xff3d63ff)
                                  : Color(0xff495057),
                              size: 26,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              color: Theme.of(context).backgroundColor,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget questionOption({
    required Answer option,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
            color: _selectedOption == index
                ? Color(0xff3d63ff)
                : Colors.transparent,
            border: Border.all(
                color: _selectedOption == index
                    ? Color(0xff3d63ff)
                    : Color(0xff495057)),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                option.anwer,
                style: TextStyle(
                    color: _selectedOption == index
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 16),
              ),
            ),
            checkResults
                ? Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      option.isAnswer ? Icons.add_task : Icons.clear_outlined,
                      color: option.isAnswer ? Colors.green[400] : Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget imageQuestionOption({
    required Answer answer,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedOption = index;
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(answer.anwer),
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            checkResults
                ? Icon(
                    answer.isAnswer ? Icons.add_task : Icons.clear_outlined,
                    size: 30,
                    color: answer.isAnswer ? Colors.green[400] : Colors.red,
                  )
                : Icon(
                    _selectedOption == index ? Icons.album : Icons.adjust,
                    size: 30,
                    color: _selectedOption == index
                        ? Color(0xff3d63ff)
                        : Color(0xff495057),
                  )
          ],
        ),
      ),
    );
  }

  Widget buildTimer() {
    return Container(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            child: CircularProgressIndicator(
              valueColor: remainingSecond > 5
                  ? AlwaysStoppedAnimation<Color>(
                      Color(0xff3d63ff),
                    )
                  : AlwaysStoppedAnimation<Color>(
                      Color(0xfff0323c),
                    ),
              value: (quizTimeSecond - remainingSecond) / quizTimeSecond,
            ),
          ),
          Container(
            child: Text(
              remainingSecond.ceil().toString(),
              style: TextStyle(color: Color(0xff495057), fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}

Widget showTitleQuestion({
  required String title,
  required String question,
  required List<String> simpleChoice,
  Function()? onTap,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 44, 16, 0),
    child: Row(
      children: <Widget>[
        // Container(
        //   child: InkWell(
        //     onTap: onTap,
        //     child: Icon(
        //       Icons.chevron_left,
        //       size: 36,
        //       color: Color(0xff495057),
        //     ),
        //   ),
        // ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff495057)),
              ),
              Text(
                question,
                style: TextStyle(fontSize: 14, color: Color(0xff495057)),
              ),
            ],
          ),
        ),
        Container(
          child: PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return simpleChoice.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice,
                      style: TextStyle(letterSpacing: 0.15).merge(
                          TextStyle(color: Colors.grey[760], letterSpacing: 0.2)
                              .merge(TextStyle(
                                  color: Colors.grey[760],
                                  letterSpacing: 0.2)))),
                );
              }).toList();
            },
            color: Colors.white,
            icon: Icon(Icons.add_road, color: Colors.grey[760]),
          ),
        ),
      ],
    ),
  );
}
