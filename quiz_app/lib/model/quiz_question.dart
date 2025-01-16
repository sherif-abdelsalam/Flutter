class QuizQuestion {
  const QuizQuestion(this.question, this.answer);
  final String question;
  final List<String> answer;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(answer);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}
