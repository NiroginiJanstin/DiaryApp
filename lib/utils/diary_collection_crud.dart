import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _recordsCollection =
    _firestore.collection('DiaryRecords');

class DiaryCrud {
  static String userUid;

  static Future<void> addItem(
      {String dateTime, String title, String note, double rating}) async {
    Map<String, dynamic> data = <String, dynamic>{
      "dateTime": DateTime.parse(dateTime),
      "title": title,
      "note": note,
      "rating": rating
    };

    await _recordsCollection
        .add(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    String dateTime,
    String title,
    String note,
    double rating,
    String docId,
  }) async {
    Map<String, dynamic> data = <String, dynamic>{
      "docId": docId,
      "dateTime": DateTime.parse(dateTime),
      "title": title,
      "rating": rating,
      "note": note,
    };

    await _recordsCollection
        .doc(docId)
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    return _recordsCollection.orderBy('dateTime', descending: true).
    snapshots();
  }

  static Stream<DocumentSnapshot> readOneItem(docId) {
    return _recordsCollection.doc(docId).snapshots();
  }

  static Stream<QuerySnapshot> searchItems(keyWord) {
    return _recordsCollection
        .where("title", arrayContains: keyWord)
        .snapshots();
  }

  static Future<void> deleteItem({
    String docId,
  }) async {
    await _recordsCollection
        .doc(docId)
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
