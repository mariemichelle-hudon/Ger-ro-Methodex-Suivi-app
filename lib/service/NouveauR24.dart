import 'dart:core';
import 'package:applicationsuivis/service/database.dart';
import 'package:applicationsuivis/service/infoR24.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NouveauR24 extends StatefulWidget {
  NouveauR24({super.key, required this.ds, required this.dsutilisateur, });

  final DocumentSnapshot ds;
  final DocumentSnapshot dsutilisateur;


  @override
  State<NouveauR24> createState() => _NouveauR24State();
}

class _NouveauR24State extends State<NouveauR24> {

  final _formKey5 = GlobalKey<FormState>();
  final HeureintController = TextEditingController();
  final Personne1 = TextEditingController();
  final Personne2 = TextEditingController();
  final Personne3 = TextEditingController();
  final Personne4 = TextEditingController();
  final MaterielController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  String typeController = 'Eau';
  final causesinitreController = TextEditingController();
  String CategorieController = '1';
  String AmianteController = 'Non';
  String GraduelController = 'Non';
  String HabitableController = 'Oui';
  String MeubleController = 'Non';
  String VetementConstroller = 'Non';
  String EletroniqueController = 'Non';

  final _formKey2 = GlobalKey<FormState>();
  String TypeassController = 'Préventif';
  final PartietoucherController = TextEditingController();
  final PiecetoucherController = TextEditingController();
  final VentiController = TextEditingController();
  final DHConstroller = TextEditingController();
  final HepaConstroller = TextEditingController();
  final tapisassController = TextEditingController();
  final AutreequipementController = TextEditingController();
  final _formKey3 = GlobalKey<FormState>();
  String TravrestController = 'Non';
  String DeplacementConstroller = 'Non';

  final _formKey4 = GlobalKey<FormState>();
  final TravauxeffectuerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final causesinitre = causesinitreController.text;
              final dateintervention = HeureintController.text;
              final personne1 = Personne1.text;
              final personne2 = Personne2.text;
              final personne3 = Personne3.text;
              final personne4 = Personne4.text;
              final materiel = MaterielController.text;
              final partietouche = PartietoucherController.text;
              final nombrepiece = PiecetoucherController.text;
              final ventilateur = VentiController.text;
              final dh = DHConstroller.text;
              final hepa = HepaConstroller.text;
              final tapis = tapisassController.text;
              final autre = AutreequipementController.text;
              final travauxeffe = TravauxeffectuerController.text;


              FocusScope.of(context).requestFocus(FocusNode());


              // ajout d'une base de donnee
              CollectionReference ficheclientRef = FirebaseFirestore.instance
                  .collection("ficheclient").doc(widget.ds["id"]).collection(
                  'R24');
              var result = await ficheclientRef.add({
                'dateintervention': dateintervention,
                'personne1': personne1,
                'personne2': personne2,
                'personne3': personne3,
                'personne4': personne4,
                'materiel': materiel,

                'typesinistre': typeController,
                'causesinitre': causesinitre,
                'categorieeau': CategorieController,
                'amiante': AmianteController,
                'dommagegraduel': GraduelController,
                'lieuhabitable': HabitableController,
                'meublretouche': MeubleController,
                'vetementtouche': VetementConstroller,
                'equipementtouche': EletroniqueController,

                'typeassechement': TypeassController,
                'partietouche': partietouche,
                'nombrepiece': nombrepiece,
                'ventilateur': ventilateur,
                'dh': dh,
                'hepa': hepa,
                'tapis': tapis,
                'autre': autre,

                'travauxrestant': TravrestController,
                'contrenu': DeplacementConstroller,

                'travauxeff': travauxeffe,

                'titredocument': 'Rapport R24',
              });

              await DsMethode(ds: widget.ds).setsubidr24(docid: result.id);

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Le rapport 24H à été créé"))
              );
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    Infor24(ds: widget.ds, dsutilisateur: widget.dsutilisateur)
                )));
          },
          child:
          const Icon(Icons.check,
            color: Colors.white,),
        ),
        appBar: AppBar(
          title: Text("Rapport 24H",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          automaticallyImplyLeading: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        body: ListView(
            children: [
              //Information du projet
              Container(
                  margin: EdgeInsets.all(20),
                  child:
                  Card(
                      child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.orange),
                              child: Text("Information du projet",
                                style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(children: [
                                      Text("Nom du client: "),
                                      Text(widget.ds["nomclient"]),
                                    ]),),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(children: [
                                      Text("Adresse: "),
                                      Text(widget.ds["adresse"]),
                                    ],),),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(children: [
                                      Text("Numero de projet: "),
                                      Text(widget.ds["numeroprojet"]),
                                    ],),),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(children: [
                                      Text("# projet assurance: "),
                                      Text(widget.ds["numeroassurance"]),
                                    ],),),


                                  Form(key: _formKey5,
                                    child:
                                    Container(
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
                                              controller: HeureintController,
                                              readOnly: true,
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Intervenant 1",
                                                  border: OutlineInputBorder()
                                              ),
                                              controller: Personne1,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Intervenant 2",
                                                  border: OutlineInputBorder()
                                              ),
                                              controller: Personne2,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Intervenant 3",
                                                  border: OutlineInputBorder()
                                              ),
                                              controller: Personne3,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Intervenant 4",
                                                  border: OutlineInputBorder()
                                              ),
                                              controller: Personne4,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(maxLines: 5,
                                              decoration: InputDecoration(
                                                  hintText: "Matériel utilisé",
                                                  border: OutlineInputBorder()
                                              ),
                                              controller: MaterielController,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]))),


              //Information du sinitre
              Container(
                  margin: EdgeInsets.all(20),
                  child:
                  Card(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              color: Colors.orange
                          ),
                          child: Text("Information du sinitre",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),),
                        Form(key: _formKey,
                          child: Column(
                            children: [
                              //Type de sinitre
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Type de sinistre'),
                                    items: const[
                                      DropdownMenuItem(
                                          value: 'Eau', child: Text("Eau")),
                                      DropdownMenuItem(
                                          value: 'Feu', child: Text("Feu")),
                                      DropdownMenuItem(
                                          value: 'Autre', child: Text("Autre"))
                                    ],
                                    value: typeController,
                                    onChanged: (value) {
                                      setState(() {
                                        typeController = value!;
                                      });
                                    }),
                              ),
                              //Cause du sinitre
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Cause du sinitre',
                                      border: OutlineInputBorder()
                                  ),
                                  controller: causesinitreController,),
                              ),
                              //Catégorie d'eau
                              Container(
                                margin: EdgeInsets.all(10),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: "Catégorie d'eau",
                                        border: OutlineInputBorder()),
                                    items: const[
                                      DropdownMenuItem(
                                          value: '', child: Text("")),
                                      DropdownMenuItem(
                                          value: '1', child: Text("1")),
                                      DropdownMenuItem(
                                          value: '2', child: Text("2")),
                                      DropdownMenuItem(
                                          value: '3', child: Text("3"))
                                    ],
                                    value: CategorieController,
                                    onChanged: (value) {
                                      setState(() {
                                        CategorieController = value!;
                                      });
                                    }),
                              ),
                              //Aminate
                              Padding(padding: EdgeInsets.all(10),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Amiante potentielle',
                                        border: OutlineInputBorder()),
                                    items: [
                                      DropdownMenuItem(
                                          value: 'Oui', child: Text("Oui")),
                                      DropdownMenuItem(
                                          value: 'Non', child: Text("Non")),
                                    ],
                                    value: AmianteController,
                                    onChanged: (value) {
                                      setState(() {
                                        AmianteController = value!;
                                      });
                                    }),
                              ),
                              //Dommage graduelle
                              Padding(padding: EdgeInsets.all(10),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Dommage graduelle',
                                        border: OutlineInputBorder()),
                                    items: [
                                      DropdownMenuItem(
                                          value: 'Oui', child: Text("Oui")),
                                      DropdownMenuItem(
                                          value: 'Non', child: Text("Non")),
                                    ],
                                    value: GraduelController,
                                    onChanged: (value) {
                                      setState(() {
                                        GraduelController = value!;
                                      });
                                    }),
                              ),
                              //Lieu habitable
                              Padding(padding: EdgeInsets.all(10),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Lieu habitable',
                                        border: OutlineInputBorder()),
                                    items: [
                                      DropdownMenuItem(
                                          value: 'Oui', child: Text("Oui")),
                                      DropdownMenuItem(
                                          value: 'Non', child: Text("Non")),
                                    ],
                                    value: HabitableController,
                                    onChanged: (value) {
                                      setState(() {
                                        HabitableController = value!;
                                      });
                                    }),
                              ),
                            ],
                          ),),
                        //Meuble toucher
                        Padding(padding: EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: 'Meuble touché',
                                  border: OutlineInputBorder()),
                              items: [
                                DropdownMenuItem(
                                    value: 'Oui', child: Text("Oui")),
                                DropdownMenuItem(
                                    value: 'Non', child: Text("Non")),
                              ],
                              value: MeubleController,
                              onChanged: (value) {
                                setState(() {
                                  MeubleController = value!;
                                });
                              }),
                        ),
                        //Vêtement touché
                        Padding(padding: EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: 'Vêtement Touché',
                                  border: OutlineInputBorder()),
                              items: [
                                DropdownMenuItem(
                                    value: 'Oui', child: Text("Oui")),
                                DropdownMenuItem(
                                    value: 'Non', child: Text("Non")),
                              ],
                              value: VetementConstroller,
                              onChanged: (value) {
                                setState(() {
                                  VetementConstroller = value!;
                                });
                              }),
                        ),
                        //Électronique touché
                        Padding(padding: EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: 'Électronique touché',
                                  border: OutlineInputBorder()),
                              items: [
                                DropdownMenuItem(
                                    value: 'Oui', child: Text("Oui")),
                                DropdownMenuItem(
                                    value: 'Non', child: Text("Non")),
                              ],
                              value: EletroniqueController,
                              onChanged: (value) {
                                setState(() {
                                  EletroniqueController = value!;
                                });
                              }),
                        ),
                      ],
                    ),
                  )),
              // Assèchement et équipement
              Card(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.orange
                      ),
                      child: Text("Assèchement et équipement",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    Form(key: _formKey2,
                      child:
                      Column(
                        children: [
                          //Type d'assèchement
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "Type d'assèchement",
                                    border: OutlineInputBorder()
                                ),
                                items: [
                                  DropdownMenuItem(value: 'Aucun',
                                      child: Text("Aucun")),
                                  DropdownMenuItem(value: 'Préventif',
                                      child: Text("Préventif")),
                                  DropdownMenuItem(value: 'Restauratif',
                                    child: Text("Restauratif"),),
                                  DropdownMenuItem(value: 'Structural',
                                    child: Text("Structural"),)
                                ],
                                value: TypeassController,
                                onChanged: (value) {
                                  setState(() {
                                    TypeassController = value!;
                                  });
                                }
                            ),
                          ),
                          //Partie Touché
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Parties touchée',
                                  border: OutlineInputBorder()
                              ),
                              controller: PartietoucherController,),
                          ),
                          //Nombre de pièce touchée
                          Padding(padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nombre de pièce touchées'),
                              controller: PiecetoucherController,
                            ),
                          ),
                          //Nombre de ventilateur
                          Padding(padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nombre de ventilateur installé'),
                              controller: VentiController,
                            ),
                          ),
                          //Nombre de DH
                          Padding(padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nombre de désumidificateur installé'),
                              controller: DHConstroller,
                            ),
                          ),
                          // Nombre Hepa
                          Padding(padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nombre d'Hépa installé"),
                              controller: HepaConstroller,
                            ),
                          ),
                          //Tapis d'assèchement
                          Padding(padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nombre de tapis d'assèchement installé"),
                              controller: tapisassController,
                            ),
                          ),
                          //Autre équipement
                          Padding(padding: EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Autre équipement installé"),
                                controller: AutreequipementController,
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.orange
                      ),
                      child: Text("À suivre ou en attente ",
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    Form(key: _formKey3, child:
                    Column(
                      children: [
                        // Travaux restant
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "Travaux restant",
                                  border: OutlineInputBorder()
                              ),
                              items: [
                                DropdownMenuItem(value: 'Oui',
                                    child: Text("Oui")),
                                DropdownMenuItem(value: 'Non',
                                  child: Text("Non"),)
                              ],
                              value: TravrestController,
                              onChanged: (value) {
                                setState(() {
                                  TravrestController = value!;
                                });
                              }
                          ),
                        ),
                        //Déplacement de contenu
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "Déplacement de contenu à prévoir",
                                  border: OutlineInputBorder()
                              ),
                              items: [
                                DropdownMenuItem(value: 'Oui',
                                    child: Text("Oui")),
                                DropdownMenuItem(value: 'Non',
                                  child: Text("Non"),)
                              ],
                              value: DeplacementConstroller,
                              onChanged: (value) {
                                setState(() {
                                  DeplacementConstroller = value!;
                                });
                              }
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Card(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              color: Colors.orange
                          ),
                          child: Text("Travaux effectué",
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),),
                        Form(key: _formKey4,
                          child: //Travaux effectué
                          Padding(padding: EdgeInsets.all(10),
                              child: TextField(maxLines: 20,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Travaux effectués"),
                                controller: TravauxeffectuerController,
                              )
                          )
                          ,)
                      ]))
            ]
        ));
  }

  Future<void> selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2050)
    );
    if (_picked != null) {
      setState(() {
        HeureintController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}


