class Todo {
  final int id;
  final String title;
  final int isDone;
  final int taskId;

  Todo({this.title, this.id, this.isDone, this.taskId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isDone': isDone, 'taskId': taskId};
  }
}
