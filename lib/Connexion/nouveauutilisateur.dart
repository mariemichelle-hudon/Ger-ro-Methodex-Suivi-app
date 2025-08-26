import 'package:applicationsuivis/Connexion/listeutilisateur.dart';
import 'package:applicationsuivis/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebaseautservice.dart';

class Nouveauutilisateur extends StatefulWidget {
  const Nouveauutilisateur({super.key, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;


  @override
  State<Nouveauutilisateur> createState() => _NouveauutilisateurState();
}

class _NouveauutilisateurState extends State<Nouveauutilisateur> {

  final Firebaseautservice _auth = Firebaseautservice();

  final _formKey = GlobalKey<FormState>();
  final nomutilisateurController = TextEditingController();
  final numerotelephoneController = TextEditingController();
  String fonctionControlleur = "Apprenti";
  final motdepasseControlleur = TextEditingController();
  final emailControlleur = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information de l'utilisateur",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading:true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape:const CircleBorder(),
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            final nomutilisateur = nomutilisateurController.text;
            final numerotelephone = numerotelephoneController.text;
            final email= emailControlleur.text;
            final motdepasse = motdepasseControlleur.text;

            FocusScope.of(context).requestFocus(FocusNode());

            CollectionReference utilisateurRef = FirebaseFirestore.instance.collection("utilisateur");
            var result = await utilisateurRef.add({
              'nom' : nomutilisateur,
              'numerotelephone' : numerotelephone,
              'fonction' : fonctionControlleur,
              'email' : email,
              'motdepasse' : motdepasse,
              'uid': "uid"

            });

            await emplMethode().setid(id: result.id);
            singUp();


            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("L'utilisateur a été créé"))
            );
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context)=> Listeutilisateur(dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
              )));
        },
        child:
        const Icon(Icons.check,
          color: Colors.white,)
      ),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Form(key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Nom d'utilisateur",
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Le nom d'utilisateur ne peut être vide";
                    }
                    return null;
                  },
                    controller: nomutilisateurController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Numero de téléphone",
                      border: OutlineInputBorder()
                  ),
                  controller: numerotelephoneController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: 'Administrateur', child: Text("Administrateur")),
                    DropdownMenuItem(value: 'Chargé de projet', child: Text("Chargé de projet")),
                    DropdownMenuItem(value: 'Nettoyeur', child: Text("Nettoyeur")),
                    DropdownMenuItem(value: 'Contremaître', child: Text("Contremaître")),
                    DropdownMenuItem(value: 'Apprenti', child: Text("Apprenti")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  value : fonctionControlleur,
                  onChanged: (value){
                    setState(() {
                      fonctionControlleur = value!;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder()
                  ),
                  controller: emailControlleur,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Mot de passe",
                      border: OutlineInputBorder()
                  ),
                  controller: motdepasseControlleur,
                ),
              ),

            ],
          ))
        ],
      ),
    );
  }

  void singUp () async {
    String email = emailControlleur.text;
    String  password = motdepasseControlleur.text;

    User? user = await _auth.singUp(email, password);

    if (user!= null){
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Un erreur c'est produite")));}


  }

  Future<String?> getuserid ({String? uid})async{
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null) {
      user.uid;
    }
    DocumentReference<Map<String, dynamic>> userCollerction =
    FirebaseFirestore.instance.collection("utilisateur").doc();
    userCollerction.update({'userId': user?.uid});
    return null;
  }

}
