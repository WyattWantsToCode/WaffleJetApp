import 'package:qc_collegeandcareer/firebase.dart';

class Poll {
  String id;
  String eventId;
  String title;
  List<Question> listOfQuestions;

  Poll(
      {required this.id,
      required this.title,
      required this.listOfQuestions,
      required this.eventId});
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

  return Poll(
      id: map["id"],
      title: map["title"],
      listOfQuestions: list,
      eventId: map["eventId"]);
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

class PollAnswer {
  String id;
  String eventId;
  List<String> answers;

  PollAnswer({required this.id, required this.eventId, required this.answers});
}

Map<String, dynamic> pollAnswerToMap(PollAnswer pollAnswer) {
  Map<String, dynamic> map = {};
  int index = 0;
  for (String answer in pollAnswer.answers) {
    map.addAll({index.toString(): answer});
    index++;
  }

  return {"id": pollAnswer.id, "eventId": pollAnswer.eventId, "answers": map};
}

void addPollAnswerToDB(PollAnswer pollAnswer) {
  db
      .collection("Poll Answers")
      .doc(pollAnswer.eventId)
      .collection("Poll Answers")
      .doc(pollAnswer.id)
      .set(pollAnswerToMap(pollAnswer));
}
