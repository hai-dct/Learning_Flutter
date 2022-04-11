class FunnyQuestion {
  int id;
  String question;
  bool checkImageUrl;
  List<Answer> answer;

  FunnyQuestion(
      {required this.id,
      required this.question,
      required this.answer,
      required this.checkImageUrl});
}

class Answer {
  String anwer;
  bool isAnswer;
  Answer({required this.anwer, required this.isAnswer});
}
