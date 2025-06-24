import 'package:applicationsuivis/service/infodocconstruction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificationdocconstrution extends StatefulWidget {
  const Modificationdocconstrution({super.key, required this.ds, required this.dscons, required this.dsutilisateur});

  final DocumentSnapshot ds;
  final DocumentSnapshot dscons;
  final DocumentSnapshot dsutilisateur;
  

  @override
  State<Modificationdocconstrution> createState() => _ModificationdocconstrutionState();
}

class _ModificationdocconstrutionState extends State<Modificationdocconstrution> {

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
  void initState(){
    super.initState();
    datedebutControlleur.text = widget.dscons["datedebut"];
    nomcontremaitreController.text = widget.dscons["nomcontremaitre"];
    travailleur1Controller.text = widget.dscons["travailleur1"];
    travailleur2Controller.text = widget.dscons["travailleur2"];
    travailleur3Controller.text = widget.dscons["travailleur3"];
    travailleur4Controller.text = widget.dscons["travailleur4"];
    detailController.text = widget.dscons["detailtravaux"];
    noteController.text = widget.dscons["note"];
    travauxrestantController.text = widget.dscons["travauxrestant"];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            shape:const CircleBorder(),
            onPressed: () {DocumentReference<Map<String, dynamic>> ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('Construction').doc(widget.dscons["id"]);
            ficheclientRef.update({
              'datedebut' : datedebutControlleur.text,
              'nomcontremaitre' : nomcontremaitreController.text,
              'travailleur1' : travailleur1Controller.text,
              'travailleur2': travailleur2Controller.text,
              'travailleur3': travailleur3Controller.text,
              'travailleur4': travailleur4Controller.text,
              'detailtravaux': detailController.text,
              'note' : noteController.text,
              'travauxrestant' : travauxrestantController.text,

            });

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Le rapport 24H à été modifié"))
            );

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context)=> Infodocconstruction(ds: widget.ds, dsutilisateur: widget.dsutilisateur,)
                )));

            },

            child:
            const Icon(Icons.check,
              color: Colors.white,)),

      appBar:AppBar(
        title: Text("Documentation reconstruction",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading:true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
      ),

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

                      Form(
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10),
                                child: TextField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.calendar_month),
                                        hintText: "Date de début de travaux",
                                        border: OutlineInputBorder()
                                    ),
                                    onTap: (){selectDate();},
                                    controller: datedebutControlleur,
                                  readOnly: true,
                                ),
                              ),

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
                                      hintText: "Intervenant 1",
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



        ])
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
        datedebutControlleur.text = _picked.toString().split(" ")[0];
      });
    }}


}
