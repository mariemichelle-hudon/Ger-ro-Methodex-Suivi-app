import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethode {

  Future ajoutnouveaudossier(Map<String, dynamic>ficheclientMap,
      String id) async {
    return await FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .set(ficheclientMap);
  }

  Future<Stream<QuerySnapshot>> getficheclientDetail() async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .orderBy("numeroprojet", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getficheclientsoumission() async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .where("statut",isEqualTo: "Soumission" )
        .orderBy("numeroprojet", descending: true)
        .snapshots();
  }

  Future <String?> deleteprojet({String? id}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(id)
        .delete();
    return null;
  }

  Future <String?> addDocument({String? id}) async{
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient");
    ficheclientRef.doc(id).collection('Document').add({'id':id});
    return ficheclientRef.id;

  }

  Future <String?> setid({String? id}) async{
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient");
    ficheclientRef.doc(id).update({'id':id});
    return null;

  }

  Future<Stream<QuerySnapshot>> getdocumentr24({String? id}) async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .collection("R24")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getdocumentconstruction({String? id}) async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .collection("Construction")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getdocumentass({String? id}) async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .collection("Suiviass")
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getnote({String? id}) async {
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .collection("Note")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future updateinformation ({String? id, required Map<String, dynamic> updateinfo}) async{
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .update(updateinfo);
  }

  Future editr24({String? id, }) async{
    return FirebaseFirestore.instance
        .collection("ficheclient")
        .doc(id)
        .snapshots();
  }

}

class DsMethode {

  final DocumentSnapshot ds;

  DsMethode({required this.ds});


  Future <String?> setsubidr24({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("R24")
        .doc(docid)
        .update({'id': docid});
    return null;
  }

  Future <String?> setsubidsuivi({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("Suiviass")
        .doc(docid)
        .update({'id': docid});
    return null;
  }

  Future <String?> setsubidcons({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("Construction")
        .doc(docid)
        .update({'id': docid});
    return null;
  }

  Future <String?> setsubidnote({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("Note")
        .doc(docid)
        .update({'id': docid});
    return null;
  }

  Future <String?> deleter24({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("R24")
        .doc(docid)
        .delete();
    return null;
  }

  Future <String?> deletedoccons({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("Construction")
        .doc(docid)
        .delete();
    return null;
  }

  Future <String?> deletenote({String? id, String? docid}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "ficheclient");
    ficheclientRef
        .doc(ds["id"])
        .collection("Note")
        .doc(docid)
        .delete();
    return null;
  }

 

}

class emplMethode {

  Future<Stream<QuerySnapshot>> getutilisateurDetail() async {
    return FirebaseFirestore.instance
        .collection("utilisateur")
        .orderBy('nom',descending: false)
        .snapshots();
  }

  Future <String?> setid({String? id}) async{
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("utilisateur");
    ficheclientRef.doc(id).update({'id':id});
    return null;

  }

  Future<Future<QuerySnapshot<Map<String, dynamic>>>> getutilisateur() async {
    return FirebaseFirestore.instance
        .collection("utilisateur")
        .get();
  }

  Future <String?> deleteutilisateur({String? id}) async {
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection(
        "utilisateur");
    ficheclientRef
        .doc(id)
        .delete();
    return null;
  }

}

