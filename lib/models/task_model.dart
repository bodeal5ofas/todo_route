class TaskModel {
  String? id;
  String title;
  String description;
  DateTime time;
  bool isDone;
  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.time,
    this.isDone = false,
  });

  factory TaskModel.fromJson(json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
      isDone: json['isDone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
