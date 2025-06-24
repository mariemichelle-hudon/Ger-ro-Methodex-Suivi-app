import 'package:applicationsuivis/page/HomePage.dart';
import 'package:applicationsuivis/page/nouveaudossier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';



Future<void> main()  async {

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
     MaterialApp(
       theme: ThemeData(textTheme:GoogleFonts.poppinsTextTheme(),
       ),
      debugShowCheckedModeBanner: false,
      home: HomePage()
     )
 // )
  //)
  );
}