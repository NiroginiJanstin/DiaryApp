import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/diary/widgets/view_item.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../common/get_rate_icon.dart';
import '../edit_record.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DiaryCrud.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var noteInfo =
                  snapshot.data.docs[index].data();
              String docID = snapshot.data.docs[index].id;

              final Timestamp timestamp = noteInfo['dateTime'] as Timestamp;
              final DateTime val = timestamp.toDate();
              final dateString = DateFormat('yyyy-MM-dd hh:mm a').format(val);

              String dateTime = dateString;
              String title = noteInfo['title'];
              String note = noteInfo['note'];
              double rate = noteInfo['rating'];
              Icon icon = returnIcon(rate);
              return Ink(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewItem(
                            documentId: docID,
                          ),
                        ),
                      ),
                      leading: icon,
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        color: const Color.fromARGB(255, 106, 101, 101),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                currentDateTime: dateTime,
                                actTime : noteInfo['dateTime'].toDate(),
                                currentTitle: title,
                                currentDescription: note,
                                currentRating: rate.toString(),
                                documentId: docID,
                              ),
                            ),
                          );
                        },
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                dateTime,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 138, 138, 138),
                                    fontStyle: FontStyle.italic
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          Text(
                            title.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF4285F4),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          //   ],
                          // ),
                        ],
                      ),
                      subtitle: Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ));
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
