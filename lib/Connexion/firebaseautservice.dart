import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseautservice {

  FirebaseAuth _auth = FirebaseAuth.instance;


  Future <User?> singIn(String email, String password) async{
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } catch (e) {}
    return null;
  }

  Future <User?> singUp(String email, String password) async{
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } catch (e) {}
    return null;
  }

  Future<String?> getuserid ({String? uid})async{
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null) {
      user.uid;
    }
    Future <String?> adduserid() async{
      CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("utilisateur");
      ficheclientRef.add({'id':uid});
      return null;

    }
    return null;
  }
  Future<Stream<QuerySnapshot>> getutilisateurDetail() async {
    return FirebaseFirestore.instance
        .collection("utilisateur").where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getchecklist({String? id}) async {
    return FirebaseFirestore.instance
        .collection("utilisateur")
        .doc(id)
        .collection("note")
        .orderBy("date", descending: true)
        .snapshots();
  }

}

class DSutilisateur{

  final DocumentSnapshot dsutilisateur;

  DSutilisateur({required this.dsutilisateur});

  Future <String?> setsubidnote({String? id, String? docid}) async {
    CollectionReference utilisateurRef = FirebaseFirestore.instance.collection(
        "utilisateur");
    utilisateurRef
        .doc(dsutilisateur["id"])
        .collection("note")
        .doc(docid)
        .update({'id': docid});
    return null;
  }


  Future <String?> deletesubidnote({String? id, String? docid}) async {
    CollectionReference utilisateurRef = FirebaseFirestore.instance.collection(
        "utilisateur");
    utilisateurRef
        .doc(dsutilisateur["id"])
        .collection("note")
        .doc(docid)
        .delete();
    return null;
  }

  Future <String?> idsubidnote({String? id, String? docid}) async {
    CollectionReference utilisateurRef = FirebaseFirestore.instance.collection(
        "utilisateur");
    utilisateurRef
        .doc(dsutilisateur["id"])
        .collection("note")
        .doc(docid)
        .update({"docid" : docid});
    return null;
  }

}



