import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Informationassurance extends StatelessWidget {
  const Informationassurance({super.key, required this.ds});

  final DocumentSnapshot ds;

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text("Information d'assurance",
                style: TextStyle(fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
            ),


            Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  SizedBox(width: 200,
                                      child: Text("Assurance : ", style: TextStyle(fontSize: 16),)),
                                  Text(ds["assurance"], style: TextStyle(fontSize: 16),),])),

                            Padding(
                              padding: const EdgeInsets.all(5),
                              child:
                                  Row(
                                    children: [
                                      SizedBox(width: 200,
                                          child: Text("Nom de l'expert : ", style: TextStyle(fontSize: 16),)),
                                      Text(ds["nomexpert"], style: TextStyle(fontSize: 16),),])),

                            Padding(
                              padding: const EdgeInsets.all(5),
                              child:
                                  Row(
                                    children: [
                                      SizedBox(width: 200,
                                          child: Text("Numero de dossier : ",style: TextStyle(fontSize: 16))),
                                      Text(ds["numeroassurance"], style: TextStyle(fontSize: 16),),])),
                                    ],
                                  ),
                            )

                )]
                    )
    ]));
  }
}
