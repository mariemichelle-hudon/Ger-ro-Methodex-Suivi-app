import 'package:applicationsuivis/page/Selectedprojet.dart';
import 'package:applicationsuivis/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Nouveausuiviass extends StatefulWidget {
  Nouveausuiviass({super.key, required this.ds, required this.dsutilisateur});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;


  @override
  State<Nouveausuiviass> createState() => _NouveausuiviassState();
}

class _NouveausuiviassState extends State<Nouveausuiviass> {

  final _formKey = GlobalKey<FormState>();
  final nomcontrolleur = TextEditingController();
  final datecontrolleur = TextEditingController();
  String equipementrecControlleur = 'Oui';
  final travauxeffControlleur = TextEditingController();
  final notecontrolleur = TextEditingController();
  final travauxrestantcontrolleur = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
          shape: CircleBorder(),
          onPressed: () async {
          if (_formKey.currentState!.validate()){
    final nom = nomcontrolleur.text;
    final date = datecontrolleur.text;
    final travaueff = travauxeffControlleur.text;
    final note = notecontrolleur.text;
    final travauxrestant = travauxrestantcontrolleur.text;

    FocusScope.of(context).requestFocus(FocusNode());

    CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('Suiviass');
    var result = await ficheclientRef.add({
    'nom':nom,
    'date': date,
    'equipementrec' : equipementrecControlleur,
    'travauxeff':travaueff,
    'note':note,
      'travauxrestant' : travauxrestant,
    });

    await DsMethode(ds: widget.ds).setsubidsuivi(docid: result.id);;


    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Le suivi d'assèchement a été créé"))
    );}
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context)=> Selectedprojet(ds: widget.ds, dsutilisateur: widget.dsutilisateur,)
              )));
          },
        child: const Icon(Icons.check,
        color: Colors.white,),
      ),

      appBar: AppBar(
        title: Text("Suivi d'assèchement",
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
            child: Form(key: _formKey,
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
                            child: Text("Information du suivis",
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),)),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),
                                  hintText: "Date du suivis",
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
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    border:OutlineInputBorder(),
                                    labelText: 'Équipement récupéré'),
                                items: const[
                                  DropdownMenuItem(value: '', child: Text("")),
                                  DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                  DropdownMenuItem(value: 'Non', child: Text("Non"))
                                ],
                                value: equipementrecControlleur,
                                onChanged: (value){
                                  setState(() {
                                    equipementrecControlleur = value!;
                                  });
                                }),
                ),])),
                          Card(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center ,
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
                                  ), ],)
                            ),
                          ),
            
                          Card(child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center ,
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
                                  ), ],)
                            ),
            
                          Card(child: Column(children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center ,
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
                              ), ],)
                            ),
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
        datecontrolleur.text = _picked.toString().split(" ")[0];
      });
    }}
}
