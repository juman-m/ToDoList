import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/models/todolist_model.dart';
import 'package:to_do_list/services/services.dart';
import 'package:to_do_list/widgets/text_filde.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool comleteFilter = false;
  bool inComleteFilter = false;
  @override
  Widget build(BuildContext context) {
    var task = TextEditingController();
    var category = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffFFDBAA),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              elevation: 0,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffFFDBAA),
                  ),
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AddTextField(
                          label: 'Task',
                          hint: 'Enter task',
                          isPassword: false,
                          controller: task,
                          icon: Icons.task,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        AddTextField(
                          label: 'Category',
                          hint: 'Enter task category',
                          isPassword: false,
                          controller: category,
                          icon: Icons.category,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        InkWell(
                          onTap: () async {
                            addToDo({
                              "title": task.text,
                              "category": category.text,
                              "state": false
                            });
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 330,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff89B9AD)),
                            child: const Center(
                              child: Text(
                                "Add Task",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).then((value) {
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {});
              });
            });
          },
          child: const Icon(
            Icons.add,
          )),
      backgroundColor: const Color(0xff89B9AD),
      body: FutureBuilder(
          future: getToDoList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool tasksDone = true;
              for (var element in snapshot.data!) {
                if (element.state == false) {
                  tasksDone = false;
                  break;
                }
              }
              List<ToDoList> tasksList = [];
              if (comleteFilter && inComleteFilter) {
                tasksList = snapshot.data!;
              } else if (comleteFilter) {
                tasksList =
                    snapshot.data!.where((e) => e.state == true).toList();
              } else if (inComleteFilter) {
                tasksList =
                    snapshot.data!.where((e) => e.state == false).toList();
              } else {
                tasksList = snapshot.data!;
              }
              return snapshot.data!.isNotEmpty
                  ? Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, top: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    FilterChip(
                                        backgroundColor:
                                            const Color(0xffFFB7B7),
                                        selectedColor: const Color(0xffFFDBAA),
                                        selected: comleteFilter,
                                        label: const Text(
                                          'Comleted',
                                          style: TextStyle(
                                              color: Color(0xffF4EEEE)),
                                        ),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            comleteFilter = !comleteFilter;
                                          });
                                        }),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    FilterChip(
                                        backgroundColor:
                                            const Color(0xffFFB7B7),
                                        selectedColor: const Color(0xffFFDBAA),
                                        selected: inComleteFilter,
                                        label: const Text(
                                          'Incomleted',
                                          style: TextStyle(
                                              color: Color(0xffF4EEEE)),
                                        ),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            inComleteFilter = !inComleteFilter;
                                          });
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                const Text(
                                  "Tasks",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.separated(
                                    itemCount: tasksList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        height: 60,
                                        child: ListTile(
                                          title: Text(
                                            tasksList[index].title ?? "",
                                          ),
                                          subtitle: Text(
                                            tasksList[index].category!,
                                          ),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  deleteToDoList(
                                                      id: tasksList[index].id!);
                                                  setState(() {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2));
                                                  });
                                                },
                                                icon: const Icon(
                                                  HeroIcons.trash,
                                                  color: Color(0xff96C291),
                                                )),
                                          ),
                                          leading: InkWell(
                                            onTap: () {
                                              updateToDoList(
                                                  id: tasksList[index].id!,
                                                  newStatus:
                                                      !tasksList[index].state!);
                                              setState(() {});
                                            },
                                            child: Container(
                                              child: tasksList[index].state!
                                                  ? const Icon(
                                                      HeroIcons.check_circle,
                                                      color: Color(0xffFFDBAA),
                                                    )
                                                  //Iconsax.tick_circle
                                                  : const Icon(
                                                      Icons.circle,
                                                      color: Color(0xffFFDBAA),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        tasksDone
                            ? Center(
                                child: Lottie.asset(
                                    "assets/Animation - 1700325434590.json",
                                    height: 220,
                                    width: 220))
                            : const Center(child: Text("")),
                      ],
                    )
                  : Center(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Add your fisrt task !",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Lottie.asset("assets/Animation - 1700324540496-2.json",
                            height: 50, width: 50),
                        // Lottie.network(
                        //     "https://app.lottiefiles.com/share/19612d75-2da2-416e-a373-2f4b6a761442")
                      ],
                    ));
            } else if (snapshot.hasError) {
              return const Center(child: Text("error"));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
