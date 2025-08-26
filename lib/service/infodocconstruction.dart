import 'package:applicationsuivis/service/modificationdocconstrution.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../page/Selectedprojet.dart';
import '../page/splashpage.dart';
import 'database.dart';

class Infodocconstruction extends StatefulWidget {
  Infodocconstruction({super.key, required this.ds, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;

  @override
  State<Infodocconstruction> createState() => _InfodocconstructionState();
}

class _InfodocconstructionState extends State<Infodocconstruction> {
  Stream? datastream;

  getontheload() async {
    var iddoc  = widget.ds["id"] ;
    datastream = await DatabaseMethode().getdocumentconstruction(id: iddoc);
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Documentation reconstruction",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          automaticallyImplyLeading:true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        body:StreamBuilder(
            stream: datastream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData? ListView.builder(
                  itemCount:snapshot.data.docs.length,
                  itemBuilder : (context, index){
                    DocumentSnapshot dscons = snapshot.data.docs[index];
                    return Container(child:
                    Padding(padding: EdgeInsets.all(10),
                        child: Column(
                            children: [
                              Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center ,
                                        decoration: BoxDecoration(
                                           // border: Border.all(width: 2),
                                            color: Colors.orange,
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [Text("Date d'intervention : "),Text(dscons["datedebut"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [Text("Contremaître : "),Text(dscons["nomcontremaitre"])]),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [Text("Intervenant 1 : "),Text(dscons["travailleur1"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [Text("Intervenant 2 : "),Text(dscons["travailleur2"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [Text("Intervenant 3 : "),Text(dscons["travailleur3"])],)),
                                              Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Row(children: [Text("Intervenant 4 : "),Text(dscons["travailleur4"])],),),

                                          ],),
                                      ),])),

                              SizedBox(height: 10,),

                              Card(
                                  child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center ,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                           // border:Border.all(width: 2)
                                          ),

                                          child: Text("Détail du projet",
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),),),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(dscons["detailtravaux"], maxLines: 20,)
                                          ),
                                        ),])),

                              SizedBox(height: 10,),

                              Card(
                                  child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center ,
                                          decoration: BoxDecoration(
                                              //border: Border.all(width: 2),
                                              color: Colors.orange,
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Text("Note",
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),),),

                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(dscons["note"], maxLines: 20,)
                                          ),
                                        ),])),

                              SizedBox(height: 10,),

                              Card(
                                  child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center ,
                                          decoration: BoxDecoration(
                                              //border: Border.all(width: 2),
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Text("Travaux restant",
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),),),

                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(dscons["travauxrestant"], maxLines: 20,)
                                          ),
                                        )
                                      ])),

                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: () async {

                                          await DsMethode(ds: widget.ds).deletedoccons(docid:dscons["id"]);

                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: ((context)=> Selectedprojet(ds: widget.ds, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
                                              )));
                                        },
                                        child: const Icon(
                                          size: 40,
                                          Icons.delete,
                                          color: Colors.orange,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: ((context)=> Modificationdocconstrution(ds: widget.ds, dscons: dscons, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
                                              )));
                                        },
                                        child: const Icon(
                                          size: 40,
                                          Icons.edit,
                                          color: Colors.orange,
                                        )),
                                  )
                                ],
                              ),



                    ])));}) : Container(child: Splashpage(duration: 3,),);
            }
        ));
  }
}
