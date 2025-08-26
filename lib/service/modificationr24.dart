import 'package:applicationsuivis/service/infoR24.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificationr24 extends StatefulWidget {
  Modificationr24({super.key, required this.ds, required this.dsdoc, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot ds;
  final DocumentSnapshot dsdoc;
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;
  

  @override
  State<Modificationr24> createState() => _Modificationr24State();
}

class _Modificationr24State extends State<Modificationr24> {

  final Heureintervention = TextEditingController();
  final Personne1 = TextEditingController();
  final Personne2 = TextEditingController();
  final Personne3 = TextEditingController();
  final Personne4 = TextEditingController();
  final MaterielController = TextEditingController();

  String typeController = 'Eau';
  String CategorieController = '1';
  String AmianteController = 'Non';
  String GraduelController = 'Non';
  String HabitableController = 'Oui';
  String MeubleController = 'Non';
  String VetementConstroller = 'Non';
  String EletroniqueController = 'Non';

  String TypeassController = 'Préventif';
  final causesinitreController = TextEditingController();
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

  @override
  void initState(){
    super.initState();

    Heureintervention.text = widget.dsdoc["dateintervention"];
    Personne1.text = widget.dsdoc["personne1"];
    Personne2.text = widget.dsdoc["personne2"];
    Personne3.text = widget.dsdoc["personne3"];
    Personne4.text = widget.dsdoc["personne4"];
    MaterielController.text = widget.dsdoc["materiel"];

    typeController = widget.dsdoc["typesinistre"];
    causesinitreController.text = widget.dsdoc["causesinitre"];
    CategorieController = widget.dsdoc["categorieeau"];
    AmianteController= widget.dsdoc["amiante"];
    GraduelController = widget.dsdoc["dommagegraduel"];
    HabitableController = widget.dsdoc["lieuhabitable"];
    MeubleController = widget.dsdoc["meublretouche"];
    VetementConstroller = widget.dsdoc["ventilateur"];
    EletroniqueController = widget.dsdoc["equipementtouche"];

    TypeassController = widget.dsdoc["typeassechement"];
    PartietoucherController.text = widget.dsdoc["partietouche"];
    VentiController.text = widget.dsdoc["ventilateur"];
    DHConstroller.text = widget.dsdoc["dh"];
    HepaConstroller.text = widget.dsdoc["hepa"];
    tapisassController.text = widget.dsdoc["tapis"];
    AutreequipementController.text = widget.dsdoc["autre"];

    TravrestController = widget.dsdoc["travauxrestant"];
    DeplacementConstroller = widget.dsdoc["contrenu"];

    TravauxeffectuerController.text = widget.dsdoc["travauxeff"];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape:const CircleBorder(),
        onPressed: () {DocumentReference<Map<String, dynamic>> ficheclientRef = FirebaseFirestore.instance.collection("ficheclient").doc(widget.ds["id"]).collection('R24').doc(widget.dsdoc["id"]);
    ficheclientRef.update({
    'dateintervention':Heureintervention.text,
    'personne1':Personne1.text,
    'personne2':Personne2.text,
    'personne3':Personne3.text,
    'personne4':Personne4.text,
    'materiel':MaterielController.text,

    'typesinistre' : typeController,
    'causesinitre' : causesinitreController.text,
    'categorieeau' : CategorieController,
    'amiante' : AmianteController,
    'dommagegraduel' : GraduelController,
    'lieuhabitable' : HabitableController,
    'meublretouche' : MeubleController,
    'vetementtouche' : VetementConstroller,
    'equipementtouche' : EletroniqueController,

    'typeassechement':TypeassController,
    'partietouche' : PartietoucherController.text,
    'nombrepiece':PiecetoucherController.text,
    'ventilateur':VentiController.text,
    'dh':DHConstroller.text,
    'hepa':HepaConstroller.text,
    'tapis':tapisassController.text,
    'autre':AutreequipementController.text,

    'travauxrestant':TravrestController,
    'contrenu' : DeplacementConstroller,

    'travauxeff':TravauxeffectuerController.text,

    });
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Le rapport 24H a été modifié"))
    );

    Navigator.of(context).push(MaterialPageRoute(
    builder: ((context)=> Infor24(ds: widget.ds, dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,)
    )));

    },

        child:
        const Icon(Icons.check,
        color: Colors.white,)),

        appBar: AppBar(
          title: Text("Rapport 24H",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          automaticallyImplyLeading:true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ) ,
            body:ListView(
                children: [
            //Information du projet
            Container(
            margin: EdgeInsets.all(20),
        child:
        Column(
          children: [
            Card(
                child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.orange),
                        child: Text("Information du projet",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),),),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(children: [Text("Nom du client: "), Text(widget.ds["nomclient"]),]),),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(children: [Text("Adresse: "), Text(widget.ds["adresse"]),],),),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(children: [Text("Numero de projet: "), Text(widget.ds["numeroprojet"]),],),),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(children: [Text("# projet assurance: "), Text(widget.ds["numeroassurance"]),],),),

                            SizedBox(height: 10,),

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
                                        controller: Heureintervention,
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
                      ])]))])),

                            //Information du sinitre
                            Container(
                                margin: EdgeInsets.all(10),
                                child:
                                Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center ,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Colors.orange
                                        ),
                                        child: Text("Information du sinitre",
                                          style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),),),


                              Column(
                                          children: [
                                            //Type de sinitre
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                      border:OutlineInputBorder(),
                                                      labelText: 'Type de sinistre'),
                                                  items: const[
                                                    DropdownMenuItem(value: 'Eau', child: Text("Eau")),
                                                    DropdownMenuItem(value: 'Feu', child: Text("Feu")),
                                                    DropdownMenuItem(value: 'Autre', child: Text("Autre"))
                                                  ],
                                                  value: typeController,
                                                  onChanged: (value){
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
                                                    border: OutlineInputBorder()
                                                ),
                                                controller: causesinitreController,),
                                            ),
                                            //Catégorie d'eau
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child:DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                      labelText: "Catégorie d'eau",
                                                      border: OutlineInputBorder()),
                                                  items: const[
                                                    DropdownMenuItem(value: '', child: Text("")),
                                                    DropdownMenuItem(value: '1', child: Text("1")),
                                                    DropdownMenuItem(value: '2', child: Text("2")),
                                                    DropdownMenuItem(value: '3', child: Text("3"))
                                                  ],
                                                  value: CategorieController,
                                                  onChanged: (value){
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
                                                    DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                                    DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                                  value: AmianteController,
                                                  onChanged: (value){
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
                                                    DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                                    DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                                  value: GraduelController,
                                                  onChanged: (value){
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
                                                    DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                                    DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                                  value: HabitableController,
                                                  onChanged: (value){
                                                    setState(() {
                                                      HabitableController = value!;
                                                    });
                                                  }),
                                            ),
                                          ],
                                        ),
                                      //Meuble toucher
                                      Padding(padding: EdgeInsets.all(10),
                                        child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                labelText: 'Meuble touché',
                                                border: OutlineInputBorder()),
                                            items: [
                                              DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                              DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                            value: MeubleController,
                                            onChanged: (value){
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
                                              DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                              DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                            value: VetementConstroller,
                                            onChanged: (value){
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
                                              DropdownMenuItem(value: 'Oui', child: Text("Oui")),
                                              DropdownMenuItem(value: 'Non', child: Text("Non")),],
                                            value: EletroniqueController,
                                            onChanged: (value){
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
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.orange
                                    ) ,
                                    child: Text("Assèchement et équipement",
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),),

                                    Column(
                                      children: [
                                        //Type d'assèchement
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: DropdownButtonFormField(
                                              decoration:InputDecoration(
                                                  labelText: "Type d'assèchement",
                                                  border: OutlineInputBorder()
                                              ),
                                              items: [
                                                DropdownMenuItem(value: 'Aucun', child: Text("Aucun")),
                                                DropdownMenuItem(value: 'Préventif', child:Text("Préventif")),
                                                DropdownMenuItem(value: 'Restauratif', child: Text("Restauratif"),),
                                                DropdownMenuItem(value: 'Structural', child: Text("Structural"),)],
                                              value: TypeassController,
                                              onChanged: (value){
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
                                                hintText: 'Partie touchée',
                                                border: OutlineInputBorder()
                                            ),
                                            controller: PartietoucherController,),
                                        ),
                                        //Nombre de pièce touchée
                                        Padding(padding: EdgeInsets.all(10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Nombre de pièce touchées',),
                                            controller: PiecetoucherController,
                                          ),
                                        ),
                                        //Nombre de ventilateur
                                        Padding(padding: EdgeInsets.all(10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Nombre de ventilateur',),
                                            controller: VentiController,
                                          ),
                                        ),
                                        //Nombre de DH
                                        Padding(padding: EdgeInsets.all(10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Nombre de désumidificateur',),
                                            controller: DHConstroller,
                                          ),
                                        ),
                                        // Nombre Hepa
                                        Padding(padding: EdgeInsets.all(10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Nombre d'Hépa",),
                                            controller: HepaConstroller,
                                          ),
                                        ),
                                        //Tapis d'assèchement
                                        Padding(padding: EdgeInsets.all(10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Nombre de tapis d'assèchement",),
                                            controller: tapisassController,
                                          ),
                                        ),
                                        //Autre équipement
                                        Padding(padding: EdgeInsets.all(10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Autre équipement",),
                                              controller: AutreequipementController,
                                            )
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.orange
                                    ),
                                    child: Text("À suivre ou en attente ",
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),),

                                  Column(
                                    children: [
                                      // Travaux restant
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: DropdownButtonFormField(
                                            decoration:InputDecoration(
                                                labelText: "Travaux restant",
                                                border: OutlineInputBorder()
                                            ),
                                            items: [
                                              DropdownMenuItem(value: 'Oui', child:Text("Oui")),
                                              DropdownMenuItem(value: 'Non', child: Text("Non"),)],
                                            value: TravrestController,
                                            onChanged: (value){
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
                                            decoration:InputDecoration(
                                                labelText: "Déplacement de contenu à prévoir",
                                                border: OutlineInputBorder()
                                            ),
                                            items: [
                                              DropdownMenuItem(value: 'Oui', child:Text("Oui")),
                                              DropdownMenuItem(value: 'Non', child: Text("Non"),)],
                                            value: DeplacementConstroller,
                                            onChanged: (value){
                                              setState(() {
                                                DeplacementConstroller = value!;
                                              });
                                            }
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Card(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center ,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Colors.orange
                                        ) ,
                                        child: Text("Travaux effectué",
                                          style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),),),
                                       //Travaux effectué
                                        Padding(padding: EdgeInsets.all(10),
                                            child: TextField(maxLines: 20,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Travaux effectué",),
                                              controller: TravauxeffectuerController,
                                            )
                                        )
                                    ]))]
                        ),
                      )
                    ])
        );
  }

  Future<void>selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2050)
    );
    if (_picked != null) {
      setState(() {
        Heureintervention.text = _picked.toString().split(" ")[0];
      });
    }
  }
}