import 'package:qc_collegeandcareer/firebase.dart';

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

void addPollToFirestore(Poll poll) {
  db.collection("Polls").doc(poll.id).set(pollToMap(poll));
}

Map<String, dynamic> pollToMap(Poll poll) {
  Map<String, dynamic> map = {};

  for (Question question in poll.listOfQuestions) {
    map.addAll({
      poll.listOfQuestions.indexOf(question).toString(): questionToMap(question)
    });
  }

  return {
    "id": poll.id,
    "title": poll.title,
    "questions": map,
  };
}

Map<String, dynamic> questionToMap(Question question) {
  Map<String, dynamic> answerChoiceMap = {};
  if (question.answerChoices != null) {
    for (String choice in question.answerChoices!) {
      answerChoiceMap
          .addAll({question.answerChoices!.indexOf(choice).toString(): choice});
    }
    return {
      "question": question.question,
      "answerChoices": answerChoiceMap,
    };
  }
  return {"question": question.question};
}

Poll mapToPoll(Map<String, dynamic> map) {
  List<Question> list = <Question>[];
  Map<String, dynamic> questionsMap = map["listOfQuestions"];
  questionsMap.forEach(
    (key, value) {
      list.add(mapToQuestion(value));
    },
  );

  return Poll(id: map["id"], title: map["title"], listOfQuestions: list);
}

Question mapToQuestion(Map<String, dynamic> map) {
  if (map.containsKey("answerChoices")) {
    List<String> list = <String>[];
    Map<String, dynamic> choiceMap = map["answerChoices"];
    choiceMap.forEach((key, value) {
      list.add(value);
    });
    return Question.multipleChoice(map["question"], list);
  } else {
    return Question.fillInBlank(map["question"]);
  }
}
