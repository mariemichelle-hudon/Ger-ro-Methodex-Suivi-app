import 'package:applicationsuivis/Connexion/firebaseautservice.dart';
import 'package:applicationsuivis/Widget/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../page/splashpage.dart';

class UtilisateurAcceuil extends StatefulWidget {
  UtilisateurAcceuil({super.key, required this.dsutilisateur, required this.dsempl});
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;


  @override
  State<UtilisateurAcceuil> createState() => _UtilisateurAcceuilState();
}

class _UtilisateurAcceuilState extends State<UtilisateurAcceuil> {

  Stream? UtilisateurStream;

  getontheload() async {
    UtilisateurStream= await Firebaseautservice().getutilisateurDetail();
    setState(() {Splashpage(duration: 3);
    });
  }

  String user= FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
          color: Colors.orange,
          child: Align(
            alignment: Alignment.center,
            child: StreamBuilder(
                  stream: UtilisateurStream,
                  builder: (context, AsyncSnapshot snapshot){
                    return snapshot.hasData? ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          DocumentSnapshot dsutilisateur = snapshot.data
                              .docs[index];
                          return Center(
                            child: Column(children: [
                              SizedBox(height: 300,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.construction, size: 200, color: Colors.white,),
                            Text("Bienvenue", style: TextStyle(
                            color: Colors.white, fontSize: 20),),
                            Text(dsutilisateur["nom"], style: TextStyle(
                            color: Colors.white, fontSize: 20),),
                              SizedBox(height: 10),
                              GestureDetector(onTap: () {
                                Navigator.push(
                                    context, PageRouteBuilder(pageBuilder: (_, __, ___) =>  data(dsutilisateur: dsutilisateur, dsempl: widget.dsempl,)));
                              }, child: Icon(Icons.arrow_forward_rounded, color: Colors.white,size: 50,),
                              )
                            ])]),
                          );


                        }):Splashpage(duration: null,);
                  }

            ))));



  }


}
