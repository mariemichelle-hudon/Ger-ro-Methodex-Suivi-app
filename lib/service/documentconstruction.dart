import 'package:applicationsuivis/service/database.dart';
import 'package:applicationsuivis/service/infodocconstruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Documentconstruction extends StatefulWidget {
  const Documentconstruction({super.key, required this.ds, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;
  

  @override
  State<Documentconstruction> createState() => _DocumentconstructionState();
}

class _DocumentconstructionState extends State<Documentconstruction> {

  final _formKey = GlobalKey<FormState>();
  final datedebutControlleur = TextEditingController();
  final nomcontremaitreController = TextEditingController();
  final travailleur1Controller = TextEditingController();
  final travailleur2Controller = TextEditingController();
  final travailleur3Controller= TextEditingController();
  final travailleur4Controller = TextEditingController();
  final detailController = TextEditingController();
  final noteController = TextEditingController();
  final travauxrestantController= TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape:const CircleBorder(),
        onPressed: () async{
          if (_formKey.currentState!.validate()){
            final datedebut = datedebutControlleur.text;
            final nomcontremaitre = nomcontremaitreController.text;
            final travailleur1 = travailleur1Controller.text;
            final travailler2 = travailleur2Controller.text;
            final travailler3 = travailleur3Controller.text;
            final travailleur4 = travailleur4Controller.text;
            final detailtravaux = detailController.text;
            final note = noteController.text;
            final travauxrestant = travauxrestantController.text;

            FocusScope.of(context).requestFocus(FocusNode());

            CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('Construction');
            var result = await ficheclientRef.add({
              'datedebut' : datedebut,
              'nomcontremaitre' : nomcontremaitre,
              'travailleur1' : travailleur1,
              'travailleur2':travailler2,
              'travailleur3' : travailler3,
              'travailleur4': travailleur4,
              'detailtravaux':detailtravaux,
              'note':note,
              'travauxrestant':travauxrestant
            });

            await DsMethode(ds: widget.ds).setsubidcons(docid: result.id);

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Le document construction à été créé"))
            );}

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context)=> Infodocconstruction(ds: widget.ds, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
                )));
          },

          child: const Icon(Icons.check,
            color: Colors.white,),
          ),
      
      appBar: AppBar(
      title: Text("Reconstruction",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),),
    automaticallyImplyLeading:true,
    foregroundColor: Colors.white,
    backgroundColor: Colors.orange,
    ) ,

      body: ListView(children: [
      Card(
        margin: EdgeInsets.all(20),
      child:
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange),
            child: Text("Information du projet",
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),),
        Padding(
          padding: const EdgeInsets.all(10),
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
        ),
      ),]),
    ),),


        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Text("Détail du projet",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    Padding(padding: EdgeInsets.all(10),
                      child: TextField(maxLines: 20,
                          decoration: InputDecoration(
                              hintText: "Détails du projet",
                              border: OutlineInputBorder()
                          ),
                          controller: detailController),),

        Form(key: _formKey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "Date de début de travaux",
                            border: OutlineInputBorder()
                        ),
                        controller: datedebutControlleur),),

                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Contremaitre",
                          border: OutlineInputBorder()
                      ),
                      controller: nomcontremaitreController,),
                  ),
                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Intervenant 1",
                          border: OutlineInputBorder()
                      ),
                      controller: travailleur1Controller,),),

                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Intervenant 2",
                          border: OutlineInputBorder()
                      ),
                      controller: travailleur2Controller,),),

                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Intervenant 3",
                          border: OutlineInputBorder()
                      ),
                      controller: travailleur3Controller,),),

                  Padding(padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Intervenant 4",
                          border: OutlineInputBorder()
                      ),
                      controller: travailleur4Controller,),),
                ],
              )),
                  ]))),),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Text("Note",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    Padding(padding: EdgeInsets.all(10),
                      child: TextField(maxLines: 20,
                          decoration: InputDecoration(
                              hintText: "Note",
                              border: OutlineInputBorder()
                          ),
                          controller: noteController),),
                  ]))),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Text("Travaux restant",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    Padding(padding: EdgeInsets.all(10),
                      child: TextField(maxLines: 20,
                          decoration: InputDecoration(
                              hintText: "Travaux restant",
                              border: OutlineInputBorder()
                          ),
                          controller: travauxrestantController),),
                  ]))),
        ),



      ]));
  }
}
