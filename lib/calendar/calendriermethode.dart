import 'package:cloud_firestore/cloud_firestore.dart';

class Calendriermethode {

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> evenement() async {
    return FirebaseFirestore.instance
        .collection("calendrier")
        .snapshots();
  }
}

