import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _recordsCollection = _firestore.collection('DiaryRecords');

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String dateTime,
    required String title,
    required String note,
  }) async {
    DocumentReference documentReferencer =
        _recordsCollection.doc().collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "dateTime": dateTime,
      "title": title,
      "note": note,
    };

    await _recordsCollection
        .add(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String dateTime,
    required String title,
    required String note,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _recordsCollection.doc().collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "dateTime" :dateTime,
      "title": title,
      "note": note,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    // CollectionReference notesItemCollection =
    //     _recordsCollection.doc().collection('items');

    print("records"+_recordsCollection.snapshots().toString());
    return _recordsCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _recordsCollection.doc().collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}