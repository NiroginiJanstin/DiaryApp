import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../edit_record.dart';

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DiaryCrud.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo =
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>;
              String docID = snapshot.data!.docs[index].id;
              String dateTime = noteInfo['dateTime'];
              String title = noteInfo['title'];
              String note = noteInfo['note'];
              print(dateTime);
              return Ink(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        currentDateTime: dateTime,
                        currentTitle: title,
                        currentDescription: note,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    dateTime + "   " + title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.firebaseOrange,
            ),
          ),
        );
      },
    );
  }
}
