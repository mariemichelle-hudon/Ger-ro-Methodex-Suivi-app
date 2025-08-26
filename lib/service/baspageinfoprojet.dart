import 'package:applicationsuivis/Widget/data.dart';
import 'package:applicationsuivis/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Baspageinfoprojet extends StatelessWidget {
  const Baspageinfoprojet({super.key, required this.ds, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;


  @override
  Widget build(BuildContext context) {
    Widget ifstate;
    if(dsutilisateur["fonction"]=="Administrateur"){
      ifstate = GestureDetector(
          onTap: () {
            DatabaseMethode().deleteprojet(id:ds["id"]);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Le projet a été supprimer"))
            );
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
               data(dsutilisateur: dsutilisateur, dsempl: dsutilisateur,))));},
    child: Icon(Icons.delete,
      color: Colors.orange,
      size: 40,));
  } else {ifstate = Container();};
  return new Container(child: ifstate);



  }
}
