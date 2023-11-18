import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_list/models/todolist_model.dart';

addToDo(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from('ToDoList').insert(body);
}

Future<List<ToDoList>> getToDoList() async {
  final supabase = Supabase.instance.client;
  final List data = await supabase.from('ToDoList').select('*');
  print(data);
  List<ToDoList> toDoList = [];
  for (var element in data) {
    toDoList.add(ToDoList.fromJson(element));
  }
  return toDoList;
}

deleteToDoList({required int id}) async {
  final supabase = Supabase.instance.client;
  await supabase.from('ToDoList').delete().eq("id", id);
}

updateToDoList({required bool newStatus, required int id}) async {
  final supabase = Supabase.instance.client;
  await supabase.from('ToDoList').update({"state": newStatus}).eq("id", id);
}
