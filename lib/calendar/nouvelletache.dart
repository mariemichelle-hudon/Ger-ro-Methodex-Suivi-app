import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'meeting.dart';


class Nouvelletache extends StatefulWidget {
  final Meeting? existingMeeting; // 🔹 Nouvelle propriété

  const Nouvelletache({super.key, this.existingMeeting});

  @override
  State<Nouvelletache> createState() => _NouvelletacheState();
}

class _NouvelletacheState extends State<Nouvelletache> {
  TextEditingController Descriptioncrolleur = TextEditingController();
  TextEditingController sartControlleur = TextEditingController();
  TextEditingController endController = TextEditingController();
  DateTime? starDateTime;
  DateTime? endDateTime;
  List<String> _selectedEmployes = [];

  final _formKey = GlobalKey<FormState>();
  String ProjetClient = "0";
  String Projetemploye = "0";
  String Projetapprenti = "0";
  bool journeeComplete = false;


  @override
  void initState() {
    super.initState();
    if (widget.existingMeeting != null) {
      final m = widget.existingMeeting!;
      ProjetClient = m.eventName;
      Projetemploye = m.nomContremaitre ?? "0";
      Projetapprenti = m.nomApprenti ?? "0";
      Descriptioncrolleur.text = m.description ?? "";
      starDateTime = m.from;
      endDateTime = m.to;
      sartControlleur.text =
          DateFormat("dd MMMM yyyy - HH'h'mm", 'fr_CA').format(m.from);
      endController.text =
          DateFormat("dd MMMM yyyy - HH'h'mm", 'fr_CA').format(m.to);
    }
  }

  // Ici tu peux garder toutes tes fonctions starDate(), endDate(), saveTache()
  // et les adapter pour gérer modification si widget.existingMeeting != null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle tâche",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: saveTache,
        child: const Icon(Icons.check, color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Client
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('ficheclient').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final clients = snapshot.data!.docs.reversed.toList();
                  List<DropdownMenuItem<String>> clientItems = [
                    const DropdownMenuItem(value: "0", child: Text('Sélectionner le client'))
                  ];
                  for (var client in clients) {
                    final data = client.data() as Map<String, dynamic>;
                    final nom = data['nomclient'] ?? 'Sans nom';
                    clientItems.add(DropdownMenuItem(value: nom, child: Text(nom)));
                  }

                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom du client',
                    ),
                    items: clientItems,
                    value: ProjetClient,
                    onChanged: (value) {
                      setState(() {
                        ProjetClient = value ?? "0";
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              // Contremaître (filtré)
              // 🔹 Liste d’employés avec cases à cocher
              SizedBox(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('utilisateur')
                      .where("fonction", isNotEqualTo: "Chargé de projet")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final employees = snapshot.data!.docs;
                    return ListView(
                      children: employees.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final employeId = doc.id;
                        final employeNom = data['nom'] ?? "Sans nom";

                        return CheckboxListTile(
                          title: Text(employeNom),
                          value: _selectedEmployes?.contains(employeId),
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selectedEmployes?.add(employeId);
                              } else {
                                _selectedEmployes?.remove(employeId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),

              // Apprenti (filtré)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("utilisateur")
                    .where("fonction", isEqualTo: "Apprenti")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final employes = snapshot.data!.docs;
                  List<DropdownMenuItem<String>> apprentiItem = [
                    const DropdownMenuItem(value: "0", child: Text("Sélectionner l'apprenti"))
                  ];
                  for (var employe in employes) {
                    final data = employe.data() as Map<String, dynamic>;
                    final nom = data['nom'] ?? 'Sans nom';
                    apprentiItem.add(DropdownMenuItem(value: nom, child: Text(nom)));
                  }

                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nom de l'apprenti"),
                    items: apprentiItem,
                    value: Projetapprenti,
                    onChanged: (value) {
                      setState(() {
                        Projetapprenti = value ?? "0";
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              // Checkbox Journée complète
              CheckboxListTile(
                title: const Text("Journée complète (7h-16h)"),
                value: journeeComplete,
                onChanged: (value) {
                  setState(() {
                    journeeComplete = value ?? false;
                  });
                },
              ),

              // Date de début
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month),
                    hintText: "Date de début",
                    labelText: 'Date de début',
                    border: OutlineInputBorder()),
                readOnly: true,
                controller: sartControlleur,
                onTap: () => starDate(journeeComplete: journeeComplete),
              ),

              const SizedBox(height: 10),

              // Date de fin
              if (!journeeComplete)
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      hintText: "Date de fin",
                      labelText: 'Date de fin',
                      border: OutlineInputBorder()),
                  readOnly: true,
                  controller: endController,
                  onTap: () => endDate(),
                ),
              const SizedBox(height: 10),

              // Description
              TextFormField(
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(),
                    labelText: 'Description'),
                controller: Descriptioncrolleur,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour choisir la date début
  Future<void> starDate({bool journeeComplete = false}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2060),
    );

    if (pickedDate != null) {
      DateTime finalDateTime;

      if (journeeComplete) {
        finalDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 7, 0);
        endDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 16, 0);
      } else {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime == null) return;
        finalDateTime = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
      }

      setState(() {
        starDateTime = finalDateTime;
        sartControlleur.text =
            DateFormat("dd MMMM yyyy - HH'h'mm", 'fr_CA').format(finalDateTime);
        if (journeeComplete && endDateTime != null) {
          endController.text =
              DateFormat("dd MMMM yyyy - HH'h'mm", 'fr_CA').format(endDateTime!);
        }
      });
    }
  }

  // Fonction pour choisir la date fin (uniquement si pas journée complète)
  Future<void> endDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2060),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime == null) return;
      DateTime finalDateTime =
      DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);

      setState(() {
        endDateTime = finalDateTime;
        endController.text =
            DateFormat("dd MMMM yyyy - HH'h'mm", 'fr_CA').format(finalDateTime);
      });
    }
  }

  Future<void> saveTache() async {
    if (!_formKey.currentState!.validate()) return;

    final CollectionReference calendrierRef =
    FirebaseFirestore.instance.collection('calendrier');

    // Récupération des valeurs du formulaire
    final String client = ProjetClient;
    final String contremaitre = Projetemploye;
    final String apprenti = Projetapprenti;
    final DateTime debut = starDateTime!;
    final DateTime fin = endDateTime!;
    final String description = Descriptioncrolleur.text;

    // Préparer les données à sauvegarder
    final Map<String, dynamic> data = {
      'nomclient': client,
      'nomcontremaitre': contremaitre,
      'nomapprentie': apprenti,
      'debut': Timestamp.fromDate(debut),
      'fin': Timestamp.fromDate(fin),
      'description': description,
      'employes':_selectedEmployes,
    };

    if (widget.existingMeeting != null && widget.existingMeeting!.docId != null) {
      // 🔹 Modification
      await calendrierRef.doc(widget.existingMeeting!.docId).update(data);
    } else {
      // 🔹 Nouvelle tâche
      await calendrierRef.add(data);
    }


    // Message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.existingMeeting != null
            ? "La tâche a été modifiée"
            : "La tâche a été créée"),
      ),
    );

    // Retour au calendrier et rafraîchissement
    Navigator.of(context).pop(true); // renvoie true pour indiquer un changement
  }
}