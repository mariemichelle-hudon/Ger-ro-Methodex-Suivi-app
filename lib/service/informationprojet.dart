import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Informationprojet extends StatelessWidget {
  const Informationprojet({super.key, required this.ds});

  final DocumentSnapshot ds;



  @override
  Widget build(BuildContext context) {
    Widget ifstate;
    if (ds["sinistre"]=="Nettoyeur"){
      ifstate = Icon(Icons.cleaning_services,
        color: Colors.orange,size: 100,);
    }else {
      ifstate = Icon(Icons.construction,
        color: Colors.orange,size: 100,);
    }

    return new Container(
      child: Card(
        shadowColor: Colors.grey,
        elevation: 4,
        child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: ifstate
          ,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ds["nomclient"],
                  style: const TextStyle(
                      fontSize: 20),),
                Text(ds["numerotelephone"]),
                Text(ds['adresse']),
                Text(ds["numeroprojet"])
              ],
            ),
            //Container(child: GestureDetector(onTap: () {},child: const Icon(Icons.delete, color: Colors.orange,)),),
          ],
        ),
      )),
    );
  }
}

