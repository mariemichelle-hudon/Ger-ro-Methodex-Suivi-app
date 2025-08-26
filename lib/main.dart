import 'package:applicationsuivis/page/HomePage.dart';
import 'package:applicationsuivis/page/nouveaudossier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar/calendrier.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Récupérer les documents depuis Firestore
  final dsutilisateur = await FirebaseFirestore.instance
      .collection('utilisateurs')
      .doc('id_utilisateur') // Remplace par l'ID réel
      .get();

  final dsempl = await FirebaseFirestore.instance
      .collection('employes')
      .doc('id_employe') // Remplace par l'ID réel
      .get();

  runApp(
    MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: HomePage(dsutilisateur: dsutilisateur, dsempl: dsempl),
    ),
  );
}
