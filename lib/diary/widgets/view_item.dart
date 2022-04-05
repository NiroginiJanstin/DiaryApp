// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/diary/common/get_rate_icon.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';

import '../../res/custom_colors.dart';

class ViewItem extends StatefulWidget {
  final String documentId;

  ViewItem({
    required this.documentId,
  });

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewItem> {
  final _viewItemFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DiaryCrud.readOneItem(widget.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error = ${snapshot.error}');
          } else if (snapshot.hasData) {
            var noteInfo = snapshot.data!.data()! as Map<String, dynamic>;
            String dateTime = noteInfo['dateTime'];
            String title = noteInfo['title'];
            String note = noteInfo['note'];
            double rating = noteInfo['rating'];
            Icon icon = returnIcon(rating);

            return Scaffold(
                backgroundColor: CustomColors.firebaseNavy,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: CustomColors.firebaseNavy,
                  title: Text("Add New Record"),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          bottom: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            icon,
                            Container(
                              width: 300,
                              height: 100,
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border:
                                    Border.all(color: Colors.red, width: 4.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Container(
                              width: 300,
                              height: 100,
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border:
                                    Border.all(color: Colors.red, width: 4.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      dateTime,
                                      style: const TextStyle(
                                          fontSize: 32, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Container(
                              width: 300,
                              height: 200,
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border:
                                    Border.all(color: Colors.red, width: 4.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      note,
                                      style: const TextStyle(
                                          fontSize: 32, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )
                            // const SizedBox(height: 2.0),
                            // Text(dateTime),
                            // const SizedBox(height: 10.0),
                            // Text(title),
                            // const SizedBox(height: 4.0),
                            // Text(note),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.firebaseOrange,
              ),
            ),
          );
        });
  }
}
