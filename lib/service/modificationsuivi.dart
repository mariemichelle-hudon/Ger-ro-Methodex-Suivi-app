import 'package:applicationsuivis/service/suiviass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificationsuivi extends StatefulWidget {
  const Modificationsuivi({super.key, required this.ds, required this.dssuivi});

  final DocumentSnapshot ds;
  final DocumentSnapshot dssuivi;

  @override
  State<Modificationsuivi> createState() => _ModificationsuiviState();
}

class _ModificationsuiviState extends State<Modificationsuivi> {

  final nomcontrolleur = TextEditingController();
  final datecontrolleur = TextEditingController();
  final equipementrecControlleur = TextEditingController();
  final travauxeffControlleur = TextEditingController();
  final notecontrolleur = TextEditingController();
  final travauxrestantcontrolleur = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomcontrolleur.text = widget.dssuivi["nom"];
    datecontrolleur.text = widget.dssuivi["date"];
    equipementrecControlleur.text = widget.dssuivi["equipementrec"];
    travauxeffControlleur.text = widget.dssuivi["travauxeff"];
    notecontrolleur.text = widget.dssuivi["note"];
    travauxrestantcontrolleur.text = widget.dssuivi["travauxrestant"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          onPressed: () {
            DocumentReference<
                Map<String, dynamic>> ficheclientRef = FirebaseFirestore
                .instance.collection("ficheclient")
                .doc(widget.ds["id"])
                .collection('Suiviass')
                .doc(widget.dssuivi["id"]);
            ficheclientRef.update({
              'nom': nomcontrolleur.text,
              'date': datecontrolleur.text,
              'equipementrec': equipementrecControlleur.text,
              'travauxeff': travauxeffControlleur.text,
              'note': notecontrolleur.text,
              'travauxrestant': travauxrestantcontrolleur.text
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Le suivi d'assèchement a été mis a jours"))
            );

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    Suiviass(ds: widget.ds, dssuivi: widget.dssuivi)
                )));
          },
          child:
          const Icon(Icons.check,
            color: Colors.white,)),

      appBar: AppBar(
        title: Text("Suivi d'assèchement",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading: true,
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
                            child: Row(children: [
                              Text("Nom du client: "),
                              Text(widget.ds["nomclient"]),
                            ],),),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [
                              Text("Numero de projet "),
                              Text(widget.ds["numeroprojet"]),
                            ],),),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [
                              Text("Adresse: "),
                              Text(widget.ds["adresse"]),
                            ],),),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [
                              Text("Téléphone: "),
                              Text(widget.ds["numerotelephone"]),
                            ],),),
                        ],),
                    ],
                  ),)
              ],),),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
                child:
                Column(
                    children: [
                      Card(
                          child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orange),
                                    child: Text("Information du suivis",
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
                                    controller: datecontrolleur,
                                    readOnly: true,
                                  ),
                                ),

                                Padding(padding: EdgeInsets.all(10),
                                  child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Intervenant",
                                          border: OutlineInputBorder()
                                      ),
                                      controller: nomcontrolleur),),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Équipement récupété",
                                          border: OutlineInputBorder()
                                      ),
                                      controller: equipementrecControlleur),
                                ),
                              ])),
                      Card(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange),
                                child: Text("Travaux effectués",
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(maxLines: 20,
                                    decoration: InputDecoration(
                                        hintText: "Travaux effectué",
                                        border: OutlineInputBorder()
                                    ),
                                    controller: travauxeffControlleur),
                              ),
                            ],)
                        ),
                      ),

                      Card(child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange),
                          child: Text("Note",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(maxLines: 20,
                              decoration: InputDecoration(
                                  hintText: "Note",
                                  border: OutlineInputBorder()
                              ),
                              controller: notecontrolleur),
                        ),
                      ],)
                      ),

                      Card(child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange),
                          child: Text("Travaux restant",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(maxLines: 20,
                              decoration: InputDecoration(
                                  hintText: "Travaux restant",
                                  border: OutlineInputBorder()
                              ),
                              controller: travauxrestantcontrolleur),
                        ),
                      ],)
                      ),
                    ])),
          )
        ],
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2050)
    );
    if (_picked != null) {
      setState(() {
        datecontrolleur.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
