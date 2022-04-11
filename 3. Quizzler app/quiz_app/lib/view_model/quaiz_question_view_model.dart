import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_app/etx/strings.dart';
import 'package:quiz_app/model/funny_question_model.dart';
import 'package:quiz_app/model/user.dart';

class QuizQuestionViewModel with ChangeNotifier {
  List<FunnyQuestion> funnyQuestion = [];
  String? title;
  List<User> users = [];
  User? playerInfo;

  QuizQuestionViewModel() {
    initData();
  }

  void initData({User? user = null}) {
    playerInfo = user;
    final Faker faker = Faker();
    users = List.generate(99, (index) {
      final avatar = emojis[Random().nextInt(emojis.length)];
      return User(faker.person.name(), avatar);
    });
  }

  void updatePlayerInfo(User user) {
    playerInfo = user;
    notifyListeners();
    print('Player info: ${playerInfo?.name}');
  }

  void updateRanks(int points) {
    playerInfo?.points = points;
    if (playerInfo != null && !users.contains(playerInfo)) {
      users.add(playerInfo!);
    }
    users.sort((user1, user2) => user1.points > user2.points ? -1 : 1);
    notifyListeners();
  }

  void resetData() {
    funnyQuestion = [];
    title = null;
    users = [];
    playerInfo = null;
  }

  getQuizQuestion() async {
    this.title = await CAUDOVUI;
    this.funnyQuestion = await [
      FunnyQuestion(
          id: 01,
          question: "Nơi nào con trai có thể sinh con?",
          answer: [
            Answer(anwer: "Trong Nhà", isAnswer: false),
            Answer(anwer: "Dưới Nước", isAnswer: true),
            Answer(anwer: "Rừng Rậm", isAnswer: false),
            Answer(anwer: "Đáp Án Khác", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 02,
          question:
              "2 con vịt đi trước 2 con vịt, 2 con vịt đi sau 2 con vịt, 2 con vịt đi giữa 2 con vịt. Hỏi có mấy con vịt?",
          answer: [
            Answer(anwer: "12 con vịt", isAnswer: false),
            Answer(anwer: "6 con vịt", isAnswer: false),
            Answer(anwer: "4 con vịt", isAnswer: true),
            Answer(anwer: "7 con vịt", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 03,
          question: "Cái gì bạn không mượn mà trả?",
          answer: [
            Answer(anwer: "Tiền", isAnswer: false),
            Answer(anwer: "Đồ ăn", isAnswer: false),
            Answer(anwer: "Xe", isAnswer: false),
            Answer(anwer: "Lời cảm ơn", isAnswer: true)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 04,
          question:
              "Làm thế nào để không đụng phải ngón tay khi bạn đập búa vào một cái móng tay?",
          answer: [
            Answer(anwer: "Cầm búa bằng cả 2 tay", isAnswer: true),
            Answer(anwer: "Cầm búa bằng tay trái", isAnswer: false),
            Answer(anwer: "Cầm búa bằng tay phải", isAnswer: false),
            Answer(anwer: "Cầm báu bằng chân", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 05,
          question:
              "Bố mẹ có 6 người con trai, mỗi người con trai có một đứa em gái. Vậy gia đình đó có mấy người?",
          answer: [
            Answer(anwer: "8", isAnswer: false),
            Answer(anwer: "9", isAnswer: true),
            Answer(anwer: "10", isAnswer: false),
            Answer(anwer: "11", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 06,
          question: "Bệnh gì bác sỹ bó tay?",
          answer: [
            Answer(anwer: "assets/images/image1.jpeg", isAnswer: false),
            Answer(anwer: "assets/images/image2.png", isAnswer: true),
            Answer(anwer: "assets/images/image3.jpeg", isAnswer: false),
            Answer(anwer: "assets/images/image4.jpeg", isAnswer: false)
          ],
          checkImageUrl: false),
      FunnyQuestion(
          id: 07,
          question: "Con đường dài nhất là đường nào?",
          answer: [
            Answer(anwer: "Đường Đi", isAnswer: false),
            Answer(anwer: "Đường Đèo", isAnswer: false),
            Answer(anwer: "Đường Đời", isAnswer: true),
            Answer(anwer: "Đường Đi Nước Ngoài", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 08,
          question: "Làm sao để cái cân tự cân chính nó?",
          answer: [
            Answer(anwer: "Xem trên bao bì", isAnswer: false),
            Answer(anwer: "Cân trên cái cân khác", isAnswer: false),
            Answer(anwer: "Không thể", isAnswer: false),
            Answer(anwer: "Lật ngược cái cân lại", isAnswer: true)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 09,
          question: "Từ nào trong tiếng việt có chín chữ H?",
          answer: [
            Answer(anwer: "Chinh", isAnswer: false),
            Answer(anwer: "Chính", isAnswer: true),
            Answer(anwer: "Chích", isAnswer: false),
            Answer(anwer: "Hình", isAnswer: false)
          ],
          checkImageUrl: true),
      FunnyQuestion(
          id: 10,
          question:
              "Một ly thuỷ tinh đựng đầy nước, làm thế nào để lấy nước dưới đáy ly mà không đổ nước ra ngoài?",
          answer: [
            Answer(anwer: "Đổ sang cốc khác", isAnswer: false),
            Answer(anwer: "Uống hết", isAnswer: false),
            Answer(anwer: "Dùng ống hút", isAnswer: true),
            Answer(anwer: "Đợi bốc hơi", isAnswer: false)
          ],
          checkImageUrl: true),
    ];
    notifyListeners();
  }
}
