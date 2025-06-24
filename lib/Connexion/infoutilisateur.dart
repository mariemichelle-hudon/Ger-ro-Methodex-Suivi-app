import 'package:applicationsuivis/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'listeutilisateur.dart';

class Infoutilisateur extends StatefulWidget {
   Infoutilisateur({super.key, required this.dsempl, required this.dsutilisateur});

   final DocumentSnapshot dsempl;
   final DocumentSnapshot dsutilisateur;


  @override
  State<Infoutilisateur> createState() => _InfoutilisateurState();
}

class _InfoutilisateurState extends State<Infoutilisateur> {
  @override
  Widget build(BuildContext context) {

    Widget ifstate;
    if (widget.dsutilisateur["fonction"]=="Administrateur" ||  widget.dsutilisateur["fonction"]=="Chargé de projet")
    { ifstate = GestureDetector(
        onTap: (){emplMethode().deleteutilisateur(id: widget.dsempl["id"]);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("L'utilisateur a été suprimé")));

        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context)=> Listeutilisateur(dsutilisateur: widget.dsutilisateur,)
            )));},
        child: Icon(Icons.delete,
          color: Colors.orange,
          size: 40,));
      } else {ifstate= Container();}

    return Scaffold(
      appBar: AppBar(
        title: const Text("Information de l'utilisateur",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading:true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
      ),

      body: ListView(children: [
         Column(
           children: [
             Card(
                shadowColor: Colors.grey,
                elevation: 4,
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Icon(Icons.person,
                          color: Colors.orange,size: 100,)
                        ,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.dsempl["nom"],
                            style: const TextStyle(
                                fontSize: 20),),
                          Text(widget.dsempl["numerotelephone"]),
                          Text(widget.dsempl['fonction']),
                        ],
                      ),
                    ],
                  ),
                )),
             Container(child: ifstate)
           ],
         ),
      ]),

    );
  }
}
