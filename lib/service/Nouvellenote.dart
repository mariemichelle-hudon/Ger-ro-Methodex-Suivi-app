import 'package:applicationsuivis/service/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database.dart';


class Nouvellenote extends StatefulWidget {
  Nouvellenote({super.key, required this.ds});

  final DocumentSnapshot ds;

  @override
  State<Nouvellenote> createState() => _NouvellenoteState();
}

class _NouvellenoteState extends State<Nouvellenote> {

  final _formKey = GlobalKey<FormState>();
  final datecontroller = TextEditingController();
  final nomcontrolleur = TextEditingController();
  final notecontrolleur = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape:const CircleBorder(),
      onPressed: () async {

          if(_formKey.currentState!.validate()){
            final date = datecontroller.text;
            final nom = nomcontrolleur.text;
            final note = notecontrolleur.text;

            FocusScope.of(context).requestFocus(FocusNode());

    // ajout d'une base de donnee
    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('Note');
    var result = await ficheclientRef.add({
    'date' : date,
    'nom' : nom,
    'note' : note
    });

    await DsMethode(ds: widget.ds).setsubidnote(docid: result.id);

    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Une nouvelle note a été créé"))
    );
    }

    Navigator.of(context).push(MaterialPageRoute(
    builder: ((context)=> Note(ds: widget.ds)
    )));
    },
    child:
    const Icon(Icons.check,
    color: Colors.white,),

      ),

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Card(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange),
                  child: const Text("Information du projet",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),

                Padding(padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [const Text("Nom du client: "), Text(widget.ds["nomclient"]),],),),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [const Text("Numero de projet "), Text(widget.ds["numeroprojet"]),],),),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(children: [const Text("Adresse: "), Text(widget.ds["adresse"]),],),),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(children: [const Text("Téléphone: "), Text(widget.ds["numerotelephone"]),],),),
                        ],
                      ),
                    ],
                  ),)
              ],),),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: Form(key: _formKey,
                child:
                Column(
                    children: [
                      Card(
                          child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orange),
                                    child: const Text("Note",
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

                                Padding(padding: const EdgeInsets.all(10),
                                  child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Nom de la personne responsable",
                                          border: OutlineInputBorder()
                                      ),
                                      controller: nomcontrolleur),),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                    child: TextField(maxLines: 20,textAlign: TextAlign.left,
                                        decoration: const InputDecoration(
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
