class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShufledAnswers() {
    final shufledList = List.of(answers);
    shufledList.shuffle();
    return shufledList;
  }
}
