import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/polls/firebase.dart';

List<String> answers = <String>[];

class PollWidget extends StatefulWidget {
  Poll poll;

  PollWidget({Key? key, required this.poll}) : super(key: key);

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  @override
  Widget build(BuildContext context) {
    if (answers.isEmpty) {
      answers = List.generate(widget.poll.listOfQuestions.length, ((index) {
        return "${index}";
      }));
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: colorSecond),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.poll.title,
                style: styleTitle,
              ),
            ),
            Questions(listOfQuestions: widget.poll.listOfQuestions),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colorThird),
                    onPressed: () {
                      print(answers);
                    },
                    child: Text(
                      "Submit",
                      style: styleSubtitle,
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class Questions extends StatefulWidget {
  List<Question> listOfQuestions;
  Questions({Key? key, required this.listOfQuestions}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[];
    for (Question question in widget.listOfQuestions) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: colorThird),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Q${widget.listOfQuestions.indexOf(question) + 1}: ${question.question}",
                    style: styleSubtitle,
                  ),
                ),
                (question.answerChoices == null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: colorSecond)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorSecond.withOpacity(.5)))),
                          cursorColor: colorFirst,
                          controller: controller,
                          style: styleBody,
                          onChanged: (value) {
                            answers.removeAt(
                                widget.listOfQuestions.indexOf(question));
                            answers.insert(
                                widget.listOfQuestions.indexOf(question),
                                controller.text);
                          },
                        ),
                      )
                    : AnswerChoices(
                        answerChoices: question.answerChoices!,
                        questionIndex: widget.listOfQuestions.indexOf(question),
                      ),
              ],
            ),
          ),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }
}

class AnswerChoices extends StatefulWidget {
  List<String> answerChoices;
  int questionIndex;
  AnswerChoices(
      {Key? key, required this.answerChoices, required this.questionIndex})
      : super(key: key);

  @override
  State<AnswerChoices> createState() => _AnswerChoicesState();
}

class _AnswerChoicesState extends State<AnswerChoices> {
  String? newChoice;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];

    for (var string in widget.answerChoices) {
      widgetList.add(Container(
        child: Theme(
          data: ThemeData(unselectedWidgetColor: colorThird),
          child: Row(
            children: [
              Radio<String>(
                value: string,
                groupValue: newChoice,
                activeColor: colorSecond,
                focusColor: colorSecond,
                hoverColor: colorSecond,
                onChanged: (value) {
                  setState(() {
                    newChoice = value;
                    answers.removeAt(widget.questionIndex);
                    answers.insert(widget.questionIndex, value!);
                  });
                },
              ),
              Flexible(
                child: Text(
                  string,
                  style: styleBody,
                  softWrap: true,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: widgetList,
    );
  }
}
