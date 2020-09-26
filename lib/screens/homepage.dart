import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_app/widgets.dart';
import '../database_helper.dart';
import 'package:mytodo_app/screens/taskpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Center(
                      child: Image(
                        image:
                            AssetImage('assets/images/Free_Sample_By_Wix.jpg'),
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Taskpage(
                                      task: snapshot.data[index],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCardwidget(
                                title: snapshot.data[index].title,
                                description: snapshot.data[index].description,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Taskpage(
                          task: null,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      image: AssetImage("assets/images/add_icon.png"),
                    ),
                  ),
                ),
              )
            ],
          ),
          color: Color.fromRGBO(35, 35, 35, 1.0),
        ),
      ),
    );
  }
}
