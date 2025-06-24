import 'package:applicationsuivis/Connexion/listeutilisateur.dart';
import 'package:applicationsuivis/Connexion/user.dart';
import 'package:applicationsuivis/calendar/calendrier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../page/Selectedprojet.dart';
import '../page/nouveaudossier.dart';
import '../page/splashpage.dart';
import '../service/database.dart';

class data extends StatefulWidget {
  const data({super.key, required this.dsutilisateur,});
  
  final DocumentSnapshot dsutilisateur;


  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  Stream? DataStream;


  getontheload() async {
    DataStream = await DatabaseMethode().getficheclientDetail();
    setState(() {Splashpage(duration: 3);
    });
  }

  String nom = "";
  String? user= FirebaseAuth.instance.currentUser?.uid;





  @override
  void initState() {
    getontheload();
    super.initState();
  }


  Widget Allficheclient() {
    return StreamBuilder(
        stream: DataStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                if(nom.isEmpty){

                  Widget ifstate;
                  if (ds["sinistre"]=="Nettoyeur"){
                    ifstate = Icon(Icons.cleaning_services,
                      color: Colors.orange);
                  }else {
                    ifstate = Icon(Icons.construction,
                      color: Colors.orange);
                  }

                return Card(
                    child: ListTile(
                      leading: ifstate ,
                        title:  Row(
                              children: [
                                    Text(ds["nomclient"],
                                      style: const TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.bold),),
                                Spacer(),
                                GestureDetector(
                                    onTap: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              Selectedprojet(ds:ds, dsutilisateur: widget.dsutilisateur,)));
                                    },
                                    child: const Icon(
                                      Icons.edit, color: Colors.orangeAccent,)
                                ),
                              ],
                            ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(ds["numeroprojet"],),
                        Text(ds["adresse"])
                      ],),
                      ));
              }

                Widget ifstate;
                if (ds["sinistre"]=="Nettoyeur"){
                  ifstate = Icon(Icons.cleaning_services,
                      color: Colors.orange);
                }else {
                  ifstate = Icon(Icons.construction,
                      color: Colors.orange);
                }

                if (ds['numeroprojet'].toString().toLowerCase().startsWith(nom.toLowerCase())){
                  return Card(
                      child: ListTile(
                        leading: ifstate ,
                        title:  Row(
                          children: [
                            Text(ds["nomclient"],
                              style: const TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.bold),),
                            Spacer(),
                            GestureDetector(
                                onTap: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          Selectedprojet(ds:ds, dsutilisateur: widget.dsutilisateur,)));
                                },
                                child: const Icon(
                                  Icons.edit, color: Colors.orangeAccent,)
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ds["numeroprojet"],),
                            Text(ds["adresse"])
                          ],),
                      ));
                }
                return null;

              });
          } else {
            return Center(child:
          Text("Aucun dossier à afficher", style: TextStyle(fontSize: 20),));
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape:const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const nouveaudossier())));
        },
        child:
        Container(
          child: const Icon(Icons.add,
            color: Colors.white,),
        ),
      ),
      appBar: AppBar(automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              const Icon(
                Icons.construction,
                color: Colors.white,
                size: 40),
              GestureDetector(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Utilisateur(dsutilisateur: widget.dsutilisateur,)));

                },
                child: Icon(Icons.person,
                color: Colors.white,
                size: 40),
              )
            ],
          ),

          backgroundColor: Colors.orange,

          leading: Builder
            (builder: (context) {
            return IconButton(
                icon: Icon(Icons.menu),
                onPressed:Scaffold.of(context).openDrawer);
          },)
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
             onChanged: (value){
               setState(() {
                 nom = value;
               });
             },
            decoration: InputDecoration(
              labelText: "Recherche", suffixIcon: Icon(Icons.search_outlined)
            ),
                  ),
          ),
          Expanded(child: Allficheclient()),
        ],
      ),
      drawer: Drawer(
          child:ListView(
            children: [
              ListTile(
                title: Text("Liste de projet"),
                onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> data())));
                },
              ),
              ListTile(
                title: Text("Liste d'utilisateur"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context)=> Listeutilisateur(dsutilisateur: widget.dsutilisateur)
                      )));
                },
              ),

              ListTile(
                leading: Icon(Icons.calendar_month, color: Colors.black,),
                title: Text("Calendrier"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context)=> Calendrier()
                      )));
                },
              )

            ],
          )
      ),
    );
  }
}



