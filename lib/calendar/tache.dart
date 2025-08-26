import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Connexion/firebaseautservice.dart';
import '../page/splashpage.dart';
import '../service/database.dart';

class Tache extends StatefulWidget {
  const Tache({super.key});

  @override
  State<Tache> createState() => _TacheState();
}

String Projetemploye = "0";

class _TacheState extends State<Tache> {
  Stream? UtilisateurStream;

  getontheload() async {
    UtilisateurStream= await FirebaseFirestore.instance.collection('utilisateur').snapshots();
    setState(() {Splashpage(duration: 3);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("employe").snapshots(),
            builder: (context, snapshot) {
              List<DropdownMenuItem> utilisateurItem= [];

              if(!snapshot.hasData)
              {const CircularProgressIndicator();}
              else{
                final employes = snapshot.data?.docs.reversed.toList();
                utilisateurItem.add(const DropdownMenuItem(
                    value:"0",
                    child: Text('Selectionner employé'))
                );
                for(var employe in employes!){
                  utilisateurItem.add(DropdownMenuItem(
                      value: employe.id,
                      child: Text(employe['nom']))
                      );
                }
              }


              return DropdownButton(
                items:utilisateurItem ,
                onChanged: (employevalue){
                  setState(() {
                    Projetemploye = employevalue;
                  });
                  print(employevalue);
                },
              );
            }
        ),
      ),
    );
  }

}
