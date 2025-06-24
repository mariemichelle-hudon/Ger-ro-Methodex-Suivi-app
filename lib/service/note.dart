import 'package:applicationsuivis/service/modificationnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/splashpage.dart';
import 'database.dart';

class Note extends StatefulWidget {
   const Note({super.key, required this.ds,});

   final DocumentSnapshot ds;

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {


  Stream? Datastream;

  getontheload() async {
    var iddoc  = widget.ds["id"] ;
    Datastream = await DatabaseMethode().getnote(id: iddoc);
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
          title: const Text("Note",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          automaticallyImplyLeading:true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        body: StreamBuilder(
          stream: Datastream,
          builder: (context, AsyncSnapshot snapshot){
            return snapshot.hasData? ListView.builder(

                itemCount:snapshot.data.docs.length,
                itemBuilder : (context, index){
                  DocumentSnapshot dsnote = snapshot.data.docs[index];
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Card(
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center ,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.orange),
                                child: const Text("Information du projet",
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),),

                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Nom du client : "), Text(widget.ds["nomclient"]),],),),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Numero de projet : "),Text(widget.ds["numeroprojet"]),],),),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Adresse : "), Text(widget.ds["adresse"]),]),),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Téléphone : "), Text(widget.ds["numerotelephone"]),],),)

                                  ],),
                              ),],
                            ),),

                          SizedBox(height: 10,),

                          Card(
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center ,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.orange),
                                child: const Text("Note",
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),),

                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Date : "), Text(dsnote["date"]),],),),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: [const Text("Responsable : "),Text(dsnote["nom"]),],),)
                                  ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9,bottom: 9),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dsnote["note"], maxLines: 20,)
                                ),
                              )
                            ]),),

                          Row(
                            children: [

                              Container(
                                margin: const EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () async {

                                      await DsMethode(ds: widget.ds).deletenote(docid: dsnote["id"]);

                                    },
                                    child: const Icon(
                                      size: 40,
                                      Icons.delete,
                                      color: Colors.orange,
                                    )),
                              ),

                              Container(
                                margin: const EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: ((context)=> Modificationnote(ds: widget.ds, dsnote: dsnote)
                                          )));
                                    },
                                    child: const Icon(
                                      size: 30,
                                      Icons.edit,
                                      color: Colors.orange,
                                    )),
                              ),
                            ],
                          )

                        ],
                      )
                  );

                }): Splashpage(duration: 3,);
          },
        ));
  }
}
