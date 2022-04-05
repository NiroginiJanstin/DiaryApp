import 'package:diary_app/diary/add_record.dart';
import 'package:diary_app/diary/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/res/custom_colors.dart';

class diaryHome extends StatefulWidget {
  @override
  _diaryHomeState createState() => _diaryHomeState();
}

class _diaryHomeState extends State<diaryHome> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor: CustomColors.firebaseOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {},
                controller: _searchController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              )),
          const Expanded(
            child: ListItem(),
          )
        ],
      ),
    );
  }
}
