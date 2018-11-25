import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreUtils{
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Todos')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Todos')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addData(carData) async {
    Firestore.instance.collection('Todos').add(carData).catchError((e) {
      print(e);
    });
  }
}