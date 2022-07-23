class Poll {
  String id;
  String title;
  List<Question> listOfQuestions;

  Poll({required this.id, required this.title, required this.listOfQuestions});
}

class Question {
  String question;
  List<String>? answerChoices;

  Question.fillInBlank(this.question);
  Question.multipleChoice(this.question, this.answerChoices);
}
