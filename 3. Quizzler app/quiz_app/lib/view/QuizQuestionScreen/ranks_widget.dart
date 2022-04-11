import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/view_model/quaiz_question_view_model.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RanksWidget extends StatefulWidget {
  const RanksWidget({Key? key}) : super(key: key);

  @override
  _RanksWidgetState createState() => _RanksWidgetState();
}

class _RanksWidgetState extends State<RanksWidget> {
  static const int _maxScore = 1000;
  bool _isLoading = true;
  int _currentIndex = 0;
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    _handleLoadingData();
    super.initState();
  }

  Future _jumpToCurrentPosition() async {
    final index = _currentIndex - 2 >= 0 ? _currentIndex - 2 : _currentIndex;
    _itemScrollController.jumpTo(index: index);
  }

  Future _scrollToCurrentPosition() async {
    final index = _currentIndex - 2 >= 0 ? _currentIndex - 2 : _currentIndex;
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(seconds: 2),
    );
  }

  Future _handleLoadingData() async {
    final model = Provider.of<QuizQuestionViewModel>(context, listen: false);
    _currentIndex = model.users
        .indexWhere((element) => element.name == model.playerInfo?.name);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _jumpToCurrentPosition();
    });
  }

  _confirmPlayAgain() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Warning!'),
            content: Text('Click continue to play again...'),
            actions: [
              CupertinoDialogAction(
                child: Text("Continue"),
                isDefaultAction: true,
                onPressed: () {
                  Provider.of<QuizQuestionViewModel>(context, listen: false)
                      .resetData();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranks',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: 25,
              ),
        ),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: _confirmPlayAgain,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rank',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Name',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Score',
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildRanksList(),
                ),
              ],
            ),
          ),
          // if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToCurrentPosition,
        child: Icon(
          Icons.pedal_bike,
        ),
      ),
    );
  }

  Widget _buildRanksList() {
    final model = Provider.of<QuizQuestionViewModel>(context);
    return ScrollablePositionedList.separated(
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemBuilder: (context, index) {
        final mainBgColor = Colors.grey.withOpacity(0.2);
        final isMyPosition = _currentIndex == index;
        final user = model.users.elementAt(index);

        return Container(
          color: isMyPosition ? Colors.blue : Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                backgroundColor: isMyPosition ? Colors.green : mainBgColor,
                child: Text(
                  "${index + 1}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: isMyPosition ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: user.points,
                            child: Container(
                              height: 50,
                              color: user.profileColor,
                              padding: EdgeInsets.all(5),
                            ),
                          ),
                          Expanded(
                            flex: _maxScore - user.points,
                            child: Container(
                              height: 50,
                              color: mainBgColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          LimitedBox(
                            maxWidth: 200,
                            child: Text(
                              "${user.avatar} ${user.name}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '${user.points} p',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: isMyPosition ? Colors.white : Colors.black,
                      ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 7,
        );
      },
      itemCount: model.users.length,
    );
  }
}
