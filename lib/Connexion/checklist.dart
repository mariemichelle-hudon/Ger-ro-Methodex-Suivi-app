import 'package:applicationsuivis/Connexion/firebaseautservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/splashpage.dart';

class Checklist extends StatefulWidget {
  Checklist({super.key, required this.dsutilisateur});

  final DocumentSnapshot dsutilisateur;

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {

  Stream? Datastream;

  getontheload() async {
    var iddoc  = widget.dsutilisateur["id"] ;
    Datastream = await Firebaseautservice().getchecklist(id: iddoc);
    setState(() {Splashpage(duration: 3);
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
        body: StreamBuilder(
        stream: Datastream,
        builder: (context,AsyncSnapshot snapshot){
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder : (context, index){
                DocumentSnapshot dsliste = snapshot.data.docs[index];

                  return Padding(padding: const EdgeInsets.all(10),
                  child: Card(margin: const EdgeInsets.all(10),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: IconButton(onPressed: () {
                            DSutilisateur(dsutilisateur:widget.dsutilisateur).deletesubidnote(docid:dsliste["docid"]);
                          },
                            icon: const Icon(Icons.delete, color: Colors.orange,),) ,
                          title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(dsliste["Titre"]),
                            Text(dsliste["date"]),
                          ],),
                          subtitle: Text(dsliste["note"]),

                        )
                    ),
                  ));
                  }
          ): Splashpage(duration: 10)
          ;
        }
    ),
    );
  }



}
