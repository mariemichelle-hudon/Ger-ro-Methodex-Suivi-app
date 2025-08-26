import 'package:applicationsuivis/service/R24.dart';
import 'package:applicationsuivis/service/autreinfo.dart';
import 'package:applicationsuivis/service/baspageinfoprojet.dart';
import 'package:applicationsuivis/service/informationprojet.dart';
import 'package:applicationsuivis/service/modificationprojet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/informationassurance.dart';

class Selectedprojet extends StatelessWidget {
    Selectedprojet ({super.key, required this.ds, required this.dsutilisateur, required this.dsempl});


    final DocumentSnapshot ds;
    final DocumentSnapshot dsutilisateur;
    final DocumentSnapshot dsempl;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape:const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context)=> Modificationprojet(ds: ds, dsutilisateur: dsutilisateur, dsempl: dsempl,)
                )));
          },
          child:
          const Icon(Icons.edit,
            color: Colors.white,),
        ),
      appBar:
          AppBar(automaticallyImplyLeading: true,
            foregroundColor: Colors.white,
          title: Row(
            children: [const Icon(
                  Icons.construction,
              color: Colors.white,
              size: 30),
              const SizedBox(width: 20,),
              Text(ds["nomclient"],
              style: const TextStyle(
                color: Colors.white
              ),),
            ],
          ),
            backgroundColor: Colors.orange,
          ),
      body: ListView(
        children: [
          Column(
            children: [
              Informationprojet(ds: ds),
              Informationassurance(ds:ds),
              Autreinfo(ds: ds,),
              R24(ds: ds, dsutilisateur: dsutilisateur, dsempl: dsempl,),
              Baspageinfoprojet(ds: ds, dsutilisateur: dsutilisateur, dsempl: dsempl,)
            ],
          ),
        ],
      ),

             );
  }
}



