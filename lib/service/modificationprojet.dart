import 'package:applicationsuivis/Widget/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificationprojet extends StatefulWidget {
   Modificationprojet({super.key, required this.ds, required this.dsutilisateur});


   final DocumentSnapshot ds;
   final DocumentSnapshot dsutilisateur;


  @override
  State<Modificationprojet> createState() => _ModificationprojetState();
}

class _ModificationprojetState extends State<Modificationprojet> {

  final clientNameController = TextEditingController();
  final numeroNameController = TextEditingController();
  String selectedTypeSinitre = 'Nettoyeur et entrepreneur';
  final adresseConstroller =TextEditingController();
  final numerotelephone =TextEditingController();
  final assuranceControleur = TextEditingController();
  final nomexpertControleur = TextEditingController();
  final numeroassuranceControleur = TextEditingController();
  String chargerprojetControleur = 'Yannick Milliard';
  String statutControleur = 'Urgence';

  @override
  void initState(){
    super.initState();
    clientNameController.text = widget.ds["nomclient"];
    numeroNameController.text = widget.ds["numeroprojet"];
    selectedTypeSinitre = widget.ds["sinistre"];
    adresseConstroller.text = widget.ds["adresse"];
    numerotelephone.text = widget.ds["numerotelephone"];
    assuranceControleur.text = widget.ds["numeroassurance"];
    nomexpertControleur.text = widget.ds["nomexpert"];
    chargerprojetControleur = widget.ds["chargerprojet"];
    statutControleur = widget.ds["statut"];


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape:const CircleBorder(),
          onPressed: () {DocumentReference<Map<String, dynamic>> ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]);
          ficheclientRef.update({
            'nomclient' : clientNameController.text,
            'numeroprojet' : numeroNameController.text,
            'sinistre' : selectedTypeSinitre,
            'adresse' : adresseConstroller.text,
            'numerotelephone' : numerotelephone.text,
            'numeroassurance' : assuranceControleur.text,
            'nomexpert' : nomexpertControleur.text,
            'chargerprojet' : chargerprojetControleur,
            'statut' : statutControleur,

          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("La note a été mise à jours"))
          );
          print(widget.ds.id);

          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context)=> data(dsutilisateur: widget.dsutilisateur ,)
              )));

          },
          child:
          const Icon(Icons.check,
            color: Colors.white,)),

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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
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

            ],
          ),
        ),
      ),
    );
  }
}
