import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardwidget extends StatelessWidget {
  final String title;
  final String description;
  TaskCardwidget({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Color.fromRGBO(66, 75, 230, 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color.fromRGBO(35, 35, 35, 1.0),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              description ?? "(No Description Available)",
              style: TextStyle(
                  color: Color.fromRGBO(35, 35, 35, 1.0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}

class ToDowidget extends StatelessWidget {
  final String text;
  final bool isDone;

  ToDowidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 12,
            ),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: isDone
                    ? Color.fromRGBO(66, 75, 230, 1.0)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: isDone
                    ? null
                    : Border.all(
                        color: Color.fromRGBO(66, 75, 230, 1.0),
                      )),
            child: Image(
              color:
                  isDone ? Color.fromRGBO(35, 35, 35, 1.0) : Colors.transparent,
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? "(Unnamed Widget)",
              style: TextStyle(
                color: Color.fromRGBO(66, 75, 230, 1.0) ,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}