import 'package:applicationsuivis/service/NouveauR24.dart';
import 'package:applicationsuivis/service/Nouvellenote.dart';
import 'package:applicationsuivis/service/documentconstruction.dart';
import 'package:applicationsuivis/service/infodocconstruction.dart';
import 'package:applicationsuivis/service/note.dart';
import 'package:applicationsuivis/service/nouveausuiviass.dart';
import 'package:applicationsuivis/service/suiviass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'infoR24.dart';

class R24 extends StatelessWidget {
  R24({super.key, required this.ds, required this.dsutilisateur});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(4))),
            child :Row(
              children: [
                Text("Documentation",
                    style: TextStyle(fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Spacer(),
          ])),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Rapport 24H",
                        style: TextStyle(fontSize: 18,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    Infor24(ds:ds, dsutilisateur: dsutilisateur,)));
                          },
                          child: const Icon(
                            Icons.arrow_forward_rounded, color: Colors.orange,)
                                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      NouveauR24(ds:ds, dsutilisateur: dsutilisateur,)));
                            },
                            child: const Icon(
                              Icons.add, color: Colors.orange,)
                        ),
                      ),],)
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Suivis d'assèchement",
                        style: TextStyle(fontSize: 18,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Suiviass(ds:ds, dssuivi: ds,)));
                            },
                            child: const Icon(
                              Icons.arrow_forward_rounded, color: Colors.orange,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Nouveausuiviass(ds:ds, dsutilisateur: dsutilisateur,)));
                            },
                            child: const Icon(
                              Icons.add, color: Colors.orange,)
                        ),
                      ),
                    ],)
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Documentation construction",
                        style: TextStyle(fontSize: 18,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Infodocconstruction(ds:ds, dsutilisateur: dsutilisateur,)));
                            },
                            child: const Icon(
                              Icons.arrow_forward_rounded, color: Colors.orange,)
                                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Documentconstruction(ds:ds, dsutilisateur: dsutilisateur,)));
                              },
                              child: const Icon(
                                Icons.add, color: Colors.orange,)
                          ),
                        ),],
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Note",
                        style: TextStyle(fontSize: 18,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Note(ds:ds )));
                              },
                              child: const Icon(
                                Icons.arrow_forward_rounded, color: Colors.orange,)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Nouvellenote(ds:ds)));
                              },
                              child: const Icon(
                                Icons.add, color: Colors.orange,)
                          ),
                        ),],
                    )
                  ],
                ),
              ),

            ],
          ),


        ]
      ),
    );
  }
}











