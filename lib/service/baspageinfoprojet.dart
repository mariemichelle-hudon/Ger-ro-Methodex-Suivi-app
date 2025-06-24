import 'package:applicationsuivis/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Baspageinfoprojet extends StatelessWidget {
  const Baspageinfoprojet({super.key, required this.ds, required this.dsutilisateur});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;


  @override
  Widget build(BuildContext context) {
    Widget ifstate;
    if(dsutilisateur["fonction"]=="Administrateur"){
      ifstate = GestureDetector(
          onTap: () {
            DatabaseMethode().deleteprojet(id:ds["id"]);},
    child: Icon(Icons.delete,
      color: Colors.orange,
      size: 40,));
  } else {ifstate = Container();};
  return new Container(child: ifstate);



  }
}
