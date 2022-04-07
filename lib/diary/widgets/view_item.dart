import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/diary/common/get_rate_icon.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../res/custom_colors.dart';

class ViewItem extends StatefulWidget {
  final String documentId;

  ViewItem({
    this.documentId,
  });

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewItem> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DiaryCrud.readOneItem(widget.documentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error = ${snapshot.error}');
          } else if (snapshot.hasData) {
            var noteInfo = snapshot.data.data();
            print(noteInfo['dateTime']);
            String dateTime = noteInfo['dateTime'].toString();
            String title = noteInfo['title'];
            String note = noteInfo['note'];
            double rating = noteInfo['rating'];
            Icon icon = returnIcon(rating);

            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(title),
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
                          children: [
                            const SizedBox(height: 20.0),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: title.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  WidgetSpan(child: icon),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: dateTime,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              width: 350,
                              height: 200,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.firebaseGrey
                                        .withOpacity(0.5)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(note,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Raleway',
                                            fontStyle: FontStyle.italic)),
                                  )),
                            )
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
