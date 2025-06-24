import 'package:applicationsuivis/service/database.dart';
import 'package:applicationsuivis/service/modificationsuivi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/splashpage.dart';

class Suiviass extends StatefulWidget {
  const Suiviass({super.key, required this.ds, required this.dssuivi,});

  final DocumentSnapshot ds;
  final DocumentSnapshot dssuivi;

  @override
  State<Suiviass> createState() => _SuiviassState();
}

class _SuiviassState extends State<Suiviass> {

  Stream? datastream;

  getontheload() async {
    var iddoc  = widget.ds["id"] ;
    datastream = await DatabaseMethode().getdocumentass(id: iddoc);
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
    return  Scaffold(
      appBar: AppBar(
        title: Text("Suivis d'assèchement",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading:true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: datastream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData? ListView.builder(
              itemCount:snapshot.data.docs.length,
    itemBuilder : (context, index){
    DocumentSnapshot dssuivi = snapshot.data.docs[index];
        return Container(child:
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange),
                    child: Text("Information du projet",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Nom du client : "), Text(widget.ds["nomclient"]),],),),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Numero de projet : "),Text(widget.ds["numeroprojet"]),],),),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Adresse : "), Text(widget.ds["adresse"]),]),),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Téléphone : "), Text(widget.ds["numerotelephone"]),],),),
                      ],),),],
                ),),

              SizedBox(height: 10,),

              Card(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange),
                    child: Text("Information du suivi",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Date du suivi : "), Text(dssuivi["date"]),],),),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Nom du responsable : "),Text(dssuivi["nom"]),],),),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [Text("Équipement récupéré : "), Text(dssuivi["equipementrec"]),]),),
                      ],),
                  ),],
                ),),

              SizedBox(height: 10,),

              Card(
                  child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center ,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Text("Travaux effectués",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(dssuivi["travauxeff"], maxLines: 20,)
                          ),
                        )
                      ])),

              SizedBox(height: 10,),

              Card(
                  child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center ,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Text("Note",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(dssuivi["note"], maxLines: 20,)
                          ),
                        )
                      ])),

              SizedBox(height: 10,),

              Card(
                  child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center ,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.orange),
                          child: Text("Travaux restants",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(dssuivi["travauxrestant"], maxLines: 20,)
                          ),
                        )
                      ])),

              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context)=> Modificationsuivi(ds: widget.ds, dssuivi: dssuivi,)
                          )));
                    },
                    child: const Icon(
                      size: 40,
                      Icons.edit,
                      color: Colors.orange,
                    )),
              )

            ],
          )
          ),
        );

    }): Container(child: Splashpage(duration: 3,),);
        },
      ));
  }
}
