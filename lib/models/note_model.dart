class NoteModel {
  String title;
  String content;
  int? id;

  NoteModel({
    required this.title,
    required this.content,
    this.id,
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
