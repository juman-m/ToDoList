class ToDoList {
  int? id;
  String? title;
  String? category;
  bool? state;

  ToDoList({this.id, this.title, this.category, this.state});

  ToDoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['state'] = state;
    return data;
  }
}
