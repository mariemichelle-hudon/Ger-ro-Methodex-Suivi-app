import 'package:applicationsuivis/Connexion/utilisateuracceuil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Connexion/firebaseautservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  var obscuretext = true;
  final Firebaseautservice _auth = Firebaseautservice();

  TextEditingController nomutilisateurControlleur = TextEditingController();
  TextEditingController motpasseControlleur = TextEditingController();

  @override
  void dispose() {
    motpasseControlleur.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.orange,
        body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       // const Icon(Icons.construction, size: 200, color: Colors.white,),
                       SizedBox(height: 300,
                           child: const Image(image: AssetImage('assets/logo-removebg-preview.png'))),
                        const Text("Bienvenue",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text("sur l'aplication Ger-Ro Methodex",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                            ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Nom d'utilisateur",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            controller: nomutilisateurControlleur,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 50),
                          child: TextField(
                            obscureText: obscuretext,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: "Mot de passe",
                                labelStyle: const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility, color: Colors.white,),
                                  onPressed: () {
                                    setState(() {
                                      obscuretext = !obscuretext;
                                    });
                                  },)
                            ),
                            controller: motpasseControlleur,
                          ),
                        ),

                        SizedBox(
                            width: 300,
                            height: 75,
                            child: ElevatedButton(style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                            ),
                                child: const Text("Connexion",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 20)),
                                onPressed: () {
                                  singIn();
                                },
                              )

                        )])),
        );

  }

  void getutilisateurDetail() async {
    return FirebaseFirestore.instance
        .collection("utilisateur")
        .get().then((value) {
      value.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  void singIn() async {
    String email = nomutilisateurControlleur.text;
    String password = motpasseControlleur.text;

    User? user = await _auth.singIn(email, password);
    User ? userID = FirebaseAuth.instance.currentUser;
    if (userID != null) {
      userID.uid;
    }



    if (user != null) {
      Navigator.push(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) =>  UtilisateurAcceuil()));
      print(user.uid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email ou nom d'utilisateur incorecte")));
    }
  }

getid() async {var result = await FirebaseFirestore.instance
     .collection('utilisateur')
     .where("uid", isEqualTo: User)
     .get().then((value) {
  value.docs.forEach((result) {
    print(result.data());});
  });}

  Getutilisateur() async {
    var collection = FirebaseFirestore.instance;
    try{
      var result =
          await collection.collection('utilisateur')
              .where('email', isEqualTo: nomutilisateurControlleur.text)
              .get();
      print(result);

    } catch(e){print("erreur");}
  }



}