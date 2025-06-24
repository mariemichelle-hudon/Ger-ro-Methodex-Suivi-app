import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Autreinfo extends StatelessWidget {
  const Autreinfo({super.key, required this.ds});

  final DocumentSnapshot ds;

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              children: [
                Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                margin:EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),child:
                Text("Autre information",
                    style: TextStyle(fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            SizedBox(width: 200,
                            child: Text("Charger de projet : ",style: TextStyle(fontSize: 16)),),
                            Text(ds["chargerprojet"],style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            SizedBox(width: 200 ,child: Text("Statut du projet : ",style: TextStyle(fontSize: 16)),),
                            Text(ds["statut"],style: TextStyle(fontSize: 16)),],),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            SizedBox(width: 200 ,child: Text("Type d'affectation : ",style: TextStyle(fontSize: 16)),),
                            Text(ds["sinistre"],style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      )
                                ],
                              ),
                ),
                SizedBox(height: 10,),
          ]),
        );
  }
}
