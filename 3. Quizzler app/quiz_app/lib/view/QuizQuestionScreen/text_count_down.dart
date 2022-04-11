import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/view_model/quaiz_question_view_model.dart';
import 'package:provider/provider.dart';

class TextCountDown extends StatefulWidget {
  int countDown;
  bool isStart = true;
  final VoidCallback callback;

  TextCountDown({
    Key? key,
    this.countDown = 3,
    required this.callback,
  }) : super(key: key);

  @override
  _TextCountDownState createState() => _TextCountDownState();
}

class _TextCountDownState extends State<TextCountDown>
    with TickerProviderStateMixin {
  late AnimationController animCountDown;
  late Animation zoomCountDown;
  int _countDown = 3;

  late AudioPlayer audioPlayer;
  final List<Color> colors = const [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
  ];

  Stream? _stream;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _countDown = widget.countDown;
    initAnimationIconWhenDrag();
    _handleStart();
    Provider.of<QuizQuestionViewModel>(context, listen: false)
        .getQuizQuestion();
  }

  initAnimationIconWhenDrag() {
    animCountDown =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    zoomCountDown = Tween(begin: 1.0, end: 2.0).animate(animCountDown);

    zoomCountDown.addListener(() {
      setState(() {});
    });
  }

  _handleStart() {
    if (widget.isStart) {
      animCountDown.reset();
      animCountDown.forward();
      _autoRun();

      audioPlayer = AudioPlayer();
      _playSound('countdown.wav');
    }
  }

  @override
  void dispose() {
    super.dispose();
    animCountDown.dispose();
    _stopStream();
  }

  void setupStream() {
    _stream = Stream<int>.periodic(Duration(seconds: 1), (x) {
      return x;
    });
  }

  void _startStream() {
    _subscription = _stream?.listen((value) {
      if (_countDown == 0) {
        _stopStream();
        widget.callback.call();
      } else {
        animCountDown.reset();
        animCountDown.forward();

        setState(() {
          _countDown--;
        });
      }
    });
  }

  void _stopStream() {
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final color = colors[_countDown];
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Transform.scale(
            scale: zoomCountDown.value,
            child: Text(
              '${_countDown}',
              style: TextStyle(color: color, fontSize: 80),
            ),
          ),
        ),
      ),
    );
  }

  void _autoRun() {
    _countDown = widget.countDown;
    setupStream();
    _startStream();
  }

  Future _playSound(String nameSound) async {
    // Sometimes multiple sound will play the same time, so we'll stop all before play the
    await audioPlayer.stop();
    final file = File('${(await getTemporaryDirectory()).path}/$nameSound');
    await file.writeAsBytes((await _loadAsset(nameSound)).buffer.asUint8List());
    await audioPlayer.play(file.path, isLocal: true);
  }

  Future _loadAsset(String nameSound) async {
    return await rootBundle.load('assets/sounds/$nameSound');
  }
}
