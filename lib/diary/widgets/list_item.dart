import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/diary/widgets/view_item.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../common/get_rate_icon.dart';
import '../edit_record.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);

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
                        color: const Color.fromARGB(255, 228, 119, 119),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                currentDateTime: dateTime,
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
                                style: GoogleFonts.lato(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
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
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          //   ],
                          // ),
                        ],
                      ),
                      //const Spacer(), // use Spacer
                      // Text(
                      //   dateTime,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: GoogleFonts.lato(
                      //     textStyle: Theme.of(context).textTheme.headline3,
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w400,
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      //),
                      //],
                      //),
                      subtitle: Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
