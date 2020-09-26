import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_app/database_helper.dart';
import 'package:mytodo_app/models/task.dart';
import 'package:mytodo_app/models/todo.dart';
import 'package:mytodo_app/widgets.dart';

class Taskpage extends StatefulWidget {
  final Task task;

  Taskpage({@required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  String _taskTitle = "";
  int _taskId = 0;
  String _taskDescription = "";
  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;
  bool _contentVisible = false;
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 6,
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              color: Color.fromRGBO(66, 75, 230, 1.0),
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                //check if the task is null
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  _taskId =
                                      await _dbHelper.insertTask(_newTask);
                                  print("New taskId : $_taskId");
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbHelper.updateTaskTitle(
                                      _taskId, value);
                                  print('Task Updated');
                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: "Enter Your Task Title...",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(66, 75, 230, 1.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value)async {
                          if (value != "") {
                            if (_taskId != 0) {
                             await _dbHelper.updateTaskDescription(_taskId, value);
                             _taskDescription = value;
                            }
                          }
                          _todoFocus.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        decoration: InputDecoration(
                          hintText: 'Enter the Description for the Task',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        style: TextStyle(
                          color: Color.fromRGBO(66, 75, 230, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  // switch the ToDoo completion state
                                  if (snapshot.data[index].isDone == 0) {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 1);
                                  } else {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 0);
                                  }
                                  setState(() {});
                                },
                                child: ToDowidget(
                                  text: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            },
                            itemCount: snapshot.data.length,
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 12,
                            ),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Color.fromRGBO(66, 75, 230, 1.0),
                              ),
                            ),
                            child: Image(
                              color: Color.fromRGBO(35, 35, 35, 1.0),
                              image: AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                if (value != "") {
                                  //check if the task is null
                                  if (_taskId != 0) {
                                    DatabaseHelper _dbHelper = DatabaseHelper();
                                    Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: _taskId);
                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                    _todoFocus.requestFocus();
                                  } else {
                                    print("Task Does not exist");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter First ToDo Item",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color:Color.fromRGBO(66, 75, 230, 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if(_taskId != 0){
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(66, 75, 230, 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage("assets/images/delete_icon.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
