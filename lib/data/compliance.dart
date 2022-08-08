class Compliance {
  final String ? content;
  bool ? isChecked;

  Compliance({
    this.content,
    this.isChecked,
  });

  @override
  String toString() {
    return 'Compliance{content: $content, isChecked: $isChecked}';
  }
}