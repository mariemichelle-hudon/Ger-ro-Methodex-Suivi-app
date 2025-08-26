
import 'package:applicationsuivis/page/Selectedprojet.dart';
import 'package:applicationsuivis/service/database.dart';
import 'package:applicationsuivis/service/modificationr24.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/splashpage.dart';

class Infor24 extends StatefulWidget {
  Infor24({super.key, required this.ds, required this.dsutilisateur, required this.dsempl,});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;


  @override
  State<Infor24> createState() => _Infor24State();
}

class _Infor24State extends State<Infor24> {
  Stream? datastream;
  final HeureintController = TextEditingController();
  final Personne1 = TextEditingController();
  final Personne2 = TextEditingController();
  final Personne3 = TextEditingController();
  final Personne4 = TextEditingController();
  final MaterielController = TextEditingController();


  String typeController = 'Eau';
  final causesinitreController = TextEditingController();
  String CategorieController = '1';
  String AmianteController = 'Non';
  String GraduelController = 'Non';
  String HabitableController = 'Oui';
  String MeubleController = 'Non';
  String VetementConstroller = 'Non';
  String EletroniqueController = 'Non';

  String TypeassController = 'Préventif';
  final PartietoucherController = TextEditingController();
  final PiecetoucherController = TextEditingController();
  final VentiController = TextEditingController();
  final DHConstroller = TextEditingController();
  final HepaConstroller = TextEditingController();
  final tapisassController = TextEditingController();
  final AutreequipementController = TextEditingController();

  String TravrestController = 'Non';
  String DeplacementConstroller = 'Non';


  final TravauxeffectuerController = TextEditingController();

  getontheload() async {
    var iddoc = widget.ds["id"];
    datastream = await DatabaseMethode().getdocumentr24(id: iddoc);
    setState(() {
      Splashpage(duration: 3);
    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rapport 24H",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        body: StreamBuilder(
            stream: datastream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dsdoc = snapshot.data.docs[index];
                        print(dsdoc.data());

                        return Container(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    children: [
                                  Card(
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.orange),
                                        child: Text(
                                          "Information du projet",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Nom du client : " + widget.ds["nomclient"] ),],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Numero de projet : " + widget.ds["numeroprojet"]),],),),

                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child:
                                                          Text("Adresse : " + widget.ds["adresse"],)),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Row(
                                                      children: [
                                                        Text("Téléphone : " + widget.ds["numerotelephone"]),],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Assurance : " + widget.ds["assurance"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [
                                                  Text("# projet assurance : " + widget.ds["numeroassurance"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Date d'intervention : " + dsdoc["dateintervention"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Intervenant 1 : " + dsdoc["personne1"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Intervenant 2 : " + dsdoc["personne2"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Intervenant 3 : " + dsdoc["personne3"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Intervenant 4 : " + dsdoc["personne4"])],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("Matériaux utilisé : " + dsdoc["materiel"],maxLines: 10),],),)],),),
                        ])),

                                  SizedBox(height: 10,),

                                  Card(
                                      child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.orange),
                                      child: Text(
                                        "Information du sinistre",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),

                                        Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Cause du sinsitre : "),
                                                Text(dsdoc["causesinitre"]),],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                                children: [
                                                  Text("Type de sinistre : "),
                                                  Text(dsdoc["typesinistre"]),]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Meuble touché : "),
                                                Text(dsdoc["meublretouche"]),],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Amiante potentielle : "),
                                                Text(dsdoc["amiante"])],),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Vêtement touché : "),
                                                Text(dsdoc["vetementtouche"])]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Dommage graduel : "),
                                                Text(dsdoc["dommagegraduel"])]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Électronique touché : "),
                                                Text(dsdoc["equipementtouche"])],),
                                          ),],))])),



                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                      child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.orange),
                                      child: Text(
                                        "Assèchement et équipement",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                                children: [
                                                  Text("Type d'assèchement : "),
                                                  Text(dsdoc["typeassechement"]),
                                                ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Nombre de ventilateur : "),
                                                Text(dsdoc["ventilateur"]),],),),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text("Partie touchée: "),
                                                  Text(dsdoc["partietouche"])],),),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Row(
                                                      children: [
                                                        Text("Nombre de déshumidificateur : "),
                                                        Text(dsdoc["dh"])],),),
                                                      Padding(
                                                        padding: const EdgeInsets.all(5),
                                                        child: Row(
                                                          children: [
                                                            Text("Nombre de pièce touchée : "),
                                                            Text(dsdoc["nombrepiece"])],),),
                                                            Padding(
                                                              padding: const EdgeInsets.all(5),
                                                              child: Row(
                                                                  children: [
                                                                  Text("Nombre d'hépa : "),
                                                                  Text(dsdoc["hepa"])]),),
                                                            Padding(
                                                                padding: const EdgeInsets.all(5),
                                                                child: Row(
                                                                    children: [
                                                                      Text("Autre équipement : "),
                                                                      Text(dsdoc["autre"])])),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(5),
                                                                      child: Row(
                                                                          children: [
                                                                            Text("Nombre de tapis d'assèchement : "),
                                                                            Text(dsdoc["tapis"])]),),
                                                                      ],),),])),


                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                      child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.orange),
                                      child: Text(
                                        "À suivre ou en attente",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                                children: [
                                                  Text("Travaux restant : "),
                                                  Text(dsdoc["travauxrestant"]),
                                                ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Text("Déplacement de contenu : "),
                                                Text(dsdoc["contrenu"]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                      child: Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.orange),
                                      child: Text(
                                        "Travaux effectué",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            dsdoc["travauxeff"],
                                            maxLines: 10,
                                          )),
                                    ),
                                  ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [

                                      Container(
                                        margin: EdgeInsets.all(10),
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () async {

                                              await DsMethode(ds: widget.ds).deleter24(docid:dsdoc["id"]);

                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: ((context)=> Selectedprojet(ds: widget.ds, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
                                                  )));
                                            },
                                            child: const Icon(
                                              size: 40,
                                              Icons.delete,
                                              color: Colors.orange,
                                            )),
                                      ),

                                      Container(
                                        margin: EdgeInsets.all(10),
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: ((context)=> Modificationr24(ds: widget.ds,dsdoc: dsdoc, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
                                                  )));
                                              },
                                            child: const Icon(
                                              size: 40,
                                              Icons.edit,
                                              color: Colors.orange,
                                            )),
                                      ),
                                    ],
                                  )
                                ])));
                      })
                  : Container(
                      child: Splashpage(
                        duration: 3,
                      ),
                    );
            }));
  }
}
