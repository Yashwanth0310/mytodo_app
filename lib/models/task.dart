class Task {
  final int id;
  final String title;
  final String description;

  Task({this.title, this.description, this.id});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
