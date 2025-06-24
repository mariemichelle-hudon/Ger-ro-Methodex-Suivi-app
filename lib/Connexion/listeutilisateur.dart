import 'package:applicationsuivis/Connexion/infoutilisateur.dart';
import 'package:applicationsuivis/Connexion/nouveauutilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widget/data.dart';
import '../page/splashpage.dart';
import '../service/database.dart';

class Listeutilisateur extends StatefulWidget {
   Listeutilisateur({super.key, required this.dsutilisateur});

   final DocumentSnapshot dsutilisateur;
   

  @override
  State<Listeutilisateur> createState() => _ListeutilisateurState();
}

class _ListeutilisateurState extends State<Listeutilisateur> {
  Stream? Datastream;

  getontheload() async {
    Datastream = await emplMethode().getutilisateurDetail();
    setState(() {Splashpage(duration: 3);
    });
    }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget ifstate;
    if (widget.dsutilisateur["fonction"]=="Administrateur" ||  widget.dsutilisateur["fonction"]=="Chargé de projet")
    { ifstate = FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context)=> Nouveauutilisateur(dsutilisateur: widget.dsutilisateur)
            )));
      },
      child:
      const Icon(Icons.add,
        color: Colors.white,),
    );} else {ifstate= Container();}

    return Scaffold(
        floatingActionButton: ifstate,

      appBar:AppBar(automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          title:const Center(
            child: Icon(
                Icons.construction,
                color: Colors.white,
                size: 40),
          ),

          backgroundColor: Colors.orange,

          leading: Builder
            (builder: (context) {
            return IconButton(
                icon: const Icon(Icons.menu),
                onPressed:Scaffold.of(context).openDrawer);
          },)
      ),
      drawer: Drawer(
          child:ListView(
            children: [
              ListTile(
                title: const Text("Liste de projet"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> data(dsutilisateur: widget.dsutilisateur,))));
                },
              ),
              ListTile(
                title: const Text("Liste d'employé"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context)=> Listeutilisateur(dsutilisateur: widget.dsutilisateur,)
                      )));
                },
              )
            ],
          )
      ),

      body: StreamBuilder(
        stream: Datastream,
        builder: (context, AsyncSnapshot snapshot){
            return snapshot.hasData? ListView.builder(
            itemCount:snapshot.data.docs.length,
            itemBuilder : (context, index){
            DocumentSnapshot dsempl = snapshot.data.docs[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                  shadowColor: Colors.grey,
                  elevation: 4,
                  child: SizedBox(
                  height: 75,
                child: Row(children: [
                  const SizedBox(
                    width: 75,
                    child: Icon(Icons.person,
                      color: Colors.orange,size: 75,)
                    ,),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dsempl["nom"], style: const TextStyle(fontSize: 20),),
                          GestureDetector(
                              onTap: () async {

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Infoutilisateur(dsutilisateur: widget.dsutilisateur, dsempl: dsempl,)));
                              },
                              child: const Icon(
                                Icons.arrow_forward_rounded, color: Colors.orangeAccent,)
                          ),
                        ],
                      ),
                      Text(dsempl["numerotelephone"]),
                      Text(dsempl['fonction']),
                    ],
                  ),
                  //Container(child: GestureDetector(onTap: () {},child: const Icon(Icons.delete, color: Colors.orange,)),),
                ],))),
            );



        }): Splashpage(duration: 3,);
        }
      )

    );
  }


}
