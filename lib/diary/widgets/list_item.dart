import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../edit_record.dart';
import 'package:google_fonts/google_fonts.dart';

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
              double rate = noteInfo['rating'];
              Icon icon = returnIcon(rate);
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
                        currentRating : rate.toString(),
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title.toUpperCase(),
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        WidgetSpan(
                            child: icon, style: const TextStyle(fontSize: 15)),
                        TextSpan(
                          text: dateTime,
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline3,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
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

Icon returnIcon(rate) {
  switch (rate) {
    case 0:
      return const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
      );
    case 1:
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.redAccent,
      );
    case 2:
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.amber,
      );
    case 3:
      return const Icon(
        Icons.sentiment_satisfied,
        color: Colors.lightGreen,
      );
    case 4:
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
    default:
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
  }
}
