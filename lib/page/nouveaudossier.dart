import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/database.dart';

class nouveaudossier extends StatefulWidget {
  const nouveaudossier({super.key});


  @override
  State<nouveaudossier> createState() => _nouveaudossierState();
}

class _nouveaudossierState extends State<nouveaudossier> {

  final _formKey =GlobalKey<FormState>();
  final clientNameController = TextEditingController();
  final numeroNameController = TextEditingController();
  String selectedTypeSinitre ='Nettoyeur et entrepreneur';
  DateTime selectedDate = DateTime.now();
  final adresseConstroller =TextEditingController();
  final numerotelephone =TextEditingController();
  final assuranceControleur = TextEditingController();
  final nomexpertControleur = TextEditingController();
  final numeroassuranceControleur = TextEditingController();
  String chargerprojetControleur = 'Yannick Milliard';
  String statutControleur = 'Urgence';

  @override
  void dispose() {
    super.dispose();
    clientNameController.dispose();
    numeroNameController.dispose();
    adresseConstroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
         title:  const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.center,
        child:
        Icon(Icons.construction,
            color: Colors.white,
            size: 60),
      ),
    ),
    backgroundColor: Colors.orange
    ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children : [ Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nom du client',
                    hintText: 'Entrée le nom du client',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Le nom du client ne peut être vide";
                  }
                  return null;
                },
                controller: clientNameController,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Numero de projet',
                      hintText: 'Entrée le numero de projet',
                      border: OutlineInputBorder()
                  ),
                  controller: numeroNameController
                  ,),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Numero de téléphone',
                      hintText: 'Entrée le numero de téléphone',
                      border: OutlineInputBorder()
                  ),
                  controller: numerotelephone
                  ,),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Adresse',
                      hintText: 'Entré le adresse complete',
                      border: OutlineInputBorder()
                  ),
                  controller: adresseConstroller,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'Nettoyeur', child: Text("Nettoyeur")),
                    DropdownMenuItem(value: 'Entrepreneur', child: Text("Entrepreneur")),
                    DropdownMenuItem(value: 'Nettoyeur et entrepreneur', child: Text("Nettoyeur et entrepreneur")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  value : selectedTypeSinitre,
                  onChanged: (value){
                    setState(() {
                      selectedTypeSinitre = value!;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Assurance',
                      hintText: 'Assurance',
                      border: OutlineInputBorder()
                  ),
                  controller: assuranceControleur,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nom de l'expert",
                      hintText: "Entrer le nom de l'expert en sinsitre au dossier",
                      border: OutlineInputBorder()
                  ),
                  controller: nomexpertControleur,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Numéro de dossier d'assurance",
                      hintText: "Entrer le numéro de dossier d'assurance",
                      border: OutlineInputBorder()
                  ),
                  controller: numeroassuranceControleur,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'Yannick Milliard', child: Text("Yannick Milliard")),
                    DropdownMenuItem(value: 'Partick Gilbert', child: Text("Patrick Gilbert")),
                    DropdownMenuItem(value: 'Richard Tremblay', child: Text("Richard Tremblay")),
                    DropdownMenuItem(value: 'Jonathan Riverain', child: Text("Jonathan Riverain")),
                    DropdownMenuItem(value: 'Marie-Michèlle Hudon', child: Text("Marie-Michèlle Hudon")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  value : chargerprojetControleur,
                  onChanged: (value){
                    setState(() {
                      chargerprojetControleur = value!;
                    });
                  },
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'Urgence', child: Text("Urgence")),
                    DropdownMenuItem(value: 'Soumission', child: Text("Soumission")),
                    DropdownMenuItem(value: 'En Attente', child: Text("En attente")),
                    DropdownMenuItem(value: 'À planifier', child: Text("À planifier")),
                    DropdownMenuItem(value: 'En cours', child: Text("En cours")),
                    DropdownMenuItem(value: 'À facturer', child: Text("À facturer")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  value : statutControleur,
                  onChanged: (value){
                    setState(() {
                      statutControleur = value!;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: WidgetStatePropertyAll(Colors.orange)
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      final nomClient = clientNameController.text;
                      final numero = numeroNameController.text;
                      final adresse = adresseConstroller.text;
                      final telephone = numerotelephone.text;
                      final assurance = assuranceControleur.text;
                      final nomexpert = nomexpertControleur.text;
                      final numeroassurance = numeroassuranceControleur.text;

                      FocusScope.of(context).requestFocus(FocusNode());

                      // ajout d'une base de donnee
                      CollectionReference ficheclientRef = FirebaseFirestore.instance.collection("ficheclient");
                      var result = await ficheclientRef.add({
                        'nomclient' : nomClient,
                        'numeroprojet':numero,
                        'adresse' : adresse,
                        'numerotelephone': telephone,
                        'sinistre':selectedTypeSinitre,
                        'assurance': assurance,
                        'nomexpert': nomexpert,
                        'numeroassurance':numeroassurance,
                        'chargerprojet':chargerprojetControleur,
                        'statut':statutControleur,

                      });
                      await DatabaseMethode().setid(id:result.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Le projet a été créé"))
                      );
                    }
                    //Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> const data())))
                    ;
                  },
                  child: const Text("Enregistrer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                ),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}
