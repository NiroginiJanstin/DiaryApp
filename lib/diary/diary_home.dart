import 'package:diary_app/common/home.dart';
import 'package:diary_app/diary/add_record.dart';
import 'package:diary_app/diary/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/res/custom_colors.dart';
// import 'package:diary_app/screens/add_screen.dart';
// import 'package:diary_app/widgets/app_bar_title.dart';
// import 'package:diary_app/widgets/item_list.dart';

class diaryHome extends StatefulWidget {
  @override
  _diaryHomeState createState() => _diaryHomeState();
}

class _diaryHomeState extends State<diaryHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: Text("Diary Records"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor: CustomColors.firebaseOrange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ListItem(),
        ),
      ),
    );
  }
}