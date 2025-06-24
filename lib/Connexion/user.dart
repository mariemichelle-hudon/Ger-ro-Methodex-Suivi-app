
import 'package:applicationsuivis/Connexion/checklist.dart';
import 'package:applicationsuivis/Connexion/firebaseautservice.dart';
import 'package:applicationsuivis/page/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur extends StatefulWidget {
  const Utilisateur({super.key, required this.dsutilisateur});

  final DocumentSnapshot dsutilisateur;

  @override
  State<Utilisateur> createState() => _UtilisateurState();
}

class _UtilisateurState extends State<Utilisateur> {

  final _formKey = GlobalKey<FormState>();
  final datecontroller = TextEditingController();
  final tacheController = TextEditingController();
  final noteController = TextEditingController();
  final datemaxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => HomePage())));
          },
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
          shape: CircleBorder(),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: ListView(children: [
                Card(
                    shadowColor: Colors.grey,
                    elevation: 4,
                    child: Container(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 75,
                            child: Icon(
                              Icons.person,
                              color: Colors.orange,
                              size: 75,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.dsutilisateur["nom"],
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(widget.dsutilisateur["numerotelephone"]),
                              Text(widget.dsutilisateur['fonction']),
                            ],
                          ),
                        ],
                      ),
                    )),
              ]),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Check-liste",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context)=>
                            AlertDialog(
                              title: Text('Nouvelle tâche'),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  children: [

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

                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextField(
                                        decoration: InputDecoration(hintText: "Titre de la tâche",
                                        border: OutlineInputBorder()),
                                        controller: tacheController,),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextField(
                                        maxLines: 20,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(hintText: "Note",
                                            border: OutlineInputBorder()),
                                        controller: noteController,),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.calendar_month),
                                            hintText: "Date d'échéance",
                                            border: OutlineInputBorder()),
                                        onTap: () {
                                          selectDatemax();
                                        },
                                        controller: datemaxController,
                                        readOnly: true,
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () async {

                                        if(_formKey.currentState!.validate()){
                                          final date = datecontroller.text;
                                          final titre = tacheController.text;
                                          final note = noteController.text;
                                          final datemax = datemaxController.text;

                                          FocusScope.of(context).requestFocus(FocusNode());

                                          CollectionReference utilisateurtRef = FirebaseFirestore.instance.collection("utilisateur").doc(widget.dsutilisateur["id"]).collection('note');
                                          var result = await utilisateurtRef.add({
                                            'date' : date,
                                            'Titre' : titre,
                                            'note' : note,
                                            'datemax' : datemax,
                                          });

                                          //await DSutilisateur(dsutilisateur: widget.dsutilisateur).setsubidnote(id:result.id);
                                          await DSutilisateur(dsutilisateur: widget.dsutilisateur).idsubidnote(docid: result.id);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Une nouvelle tâche a été créé"))
                                          );

                                          Navigator.pop(context);

                                        }

                                      },
                                      child: Icon(Icons.check,),
                                    )
                                  ],
                                ),
                              )

                              ),
                            ), child: Icon(Icons.add, color: Colors.white,),

                    )
                  ],
                )),
            Expanded(child: Checklist(dsutilisateur: widget.dsutilisateur),)
          ],
        ));
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

   Future<void>selectDatemax() async{
     DateTime? _picked = await showDatePicker(
         context: context,
         currentDate: DateTime.now(),
         firstDate: DateTime(2024),
         lastDate: DateTime(2050)
     );
     if (_picked!= null){
       setState(() {
         datemaxController.text = _picked.toString().split(" ")[0];
       });
     }
  }

  }
