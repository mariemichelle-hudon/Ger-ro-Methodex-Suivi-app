import 'package:applicationsuivis/service/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificationnote extends StatefulWidget {
  const Modificationnote({super.key, required this.ds, required this.dsnote});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsnote;


  @override
  State<Modificationnote> createState() => _ModificationnoteState();
}

class _ModificationnoteState extends State<Modificationnote> {

  final datecontroller = TextEditingController();
  final nomcontrolleur = TextEditingController();
  final notecontrolleur = TextEditingController();

  @override
  void initState(){
    super.initState();
    datecontroller.text = widget.dsnote["date"];
    nomcontrolleur.text = widget.dsnote["nom"];
    notecontrolleur.text = widget.dsnote["note"];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape:const CircleBorder(),
          onPressed: () {DocumentReference<Map<String, dynamic>> ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('Note').doc(widget.dsnote["id"]);
          ficheclientRef.update({
           'date' : datecontroller.text,
            'nom' : nomcontrolleur.text,
            'note': notecontrolleur.text
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("La note a été mise à jours"))
          );
          print(widget.dsnote.id);

          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context)=> Note(ds: widget.ds)
              )));

          },
          child:
          const Icon(Icons.check,
            color: Colors.white,)),

        appBar: AppBar(
          title: Text("Note",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          automaticallyImplyLeading:true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),

        body :  ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Card(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Text("Information du projet",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),
                  ),

                  Padding(padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(children: [Text("Nom du client: "), Text(widget.ds["nomclient"]),],),),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(children: [Text("Numero de projet "), Text(widget.ds["numeroprojet"]),],),),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(children: [Text("Adresse: "), Text(widget.ds["adresse"]),],),),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(children: [Text("Téléphone: "), Text(widget.ds["numerotelephone"]),],),),
                          ],
                        ),
                      ],
                    ),)
                ],),),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Form(
                  child:
                  Column(
                      children: [
                        Card(
                            child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center ,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.orange),
                                      child: Text("Note",
                                        style: TextStyle(fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),)),

                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.calendar_month),
                                          hintText: "Date de création",
                                          border: OutlineInputBorder()),
                                      onTap: () {
                                        selectDate();
                                      },
                                      controller: datecontroller,
                                      readOnly: true,
                                    ),
                                  ),

                                  Padding(padding: EdgeInsets.all(10),
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Nom de la personne responsable",
                                            border: OutlineInputBorder()
                                        ),
                                        controller: nomcontrolleur),),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextField(maxLines: 20,textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            hintText: "Note",
                                            border: OutlineInputBorder()
                                        ),
                                        controller: notecontrolleur),),
                                ])),
                      ])),
            )],
        ),

    );
  }

  Future<void>selectDate() async{
    DateTime? _picked = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2050)
    );
    if (_picked!= null){
      setState(() {
        datecontroller.text = _picked.toString().split(" ")[0];
      });
    }}

}
