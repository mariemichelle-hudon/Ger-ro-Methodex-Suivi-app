// custom_drawer.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Connexion/infoutilisateur.dart';
import '../Connexion/listeutilisateur.dart';
import '../Widget/data.dart';
import '../calendar/calendrier.dart';
import '../equipement/equipement.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text(
              'Mon Application',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Projet'),
            onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> data(dsutilisateur: dsutilisateur, dsempl: dsempl,))));},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendrier'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context)=> CalendrierEmployes(dsutilisateur: dsutilisateur, dsempl: dsempl,)
                  )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.mode_fan_off),
            title: const Text('Équipement'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context)=> InventaireEquipementPro(dsutilisateur: dsutilisateur, dsempl: dsempl,)
                  )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Utilisateur'),
           onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> Listeutilisateur(dsempl: dsempl, dsutilisateur: dsutilisateur,))));},
          ),
        ],
      ),
    );
  }
}