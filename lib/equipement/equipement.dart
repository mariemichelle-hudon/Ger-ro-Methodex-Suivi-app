import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../page/drawer.dart';

class InventaireEquipementPro extends StatefulWidget {
  const InventaireEquipementPro({super.key, required this.dsutilisateur, required this.dsempl});

  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;

  @override
  State<InventaireEquipementPro> createState() =>
      _InventaireEquipementProState();
}

class _InventaireEquipementProState extends State<InventaireEquipementPro> {
  final CollectionReference _equipementsRef =
  FirebaseFirestore.instance.collection('equipements');

  String? _selectedTypeFilter;
  String? _selectedEmplacementFilter;

  List<String> types = ['Ventilateur', 'Déshumidificateur', 'HEPA'];
  List<String> emplacementsFixes = ['Bureau'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaire Équipements"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () => _showAddDialog(),
      ),
      drawer: CustomDrawer(dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,),
      body: Column(
        children: [
          // 🔹 Filtres
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Filtrer par type',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedTypeFilter,
                    items: [null, ...types]
                        .map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(t ?? 'Tous les types'),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => _selectedTypeFilter = val);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Filtrer par emplacement',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedEmplacementFilter,
                    items: [null, ...emplacementsFixes]
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e ?? 'Tous les emplacements'),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => _selectedEmplacementFilter = val);
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Liste des équipements
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _equipementsRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var equipments = snapshot.data!.docs;

                // 🔹 Appliquer les filtres
                if (_selectedTypeFilter != null) {
                  equipments = equipments
                      .where((doc) => doc['type'] == _selectedTypeFilter)
                      .toList();
                }
                if (_selectedEmplacementFilter != null) {
                  equipments = equipments
                      .where((doc) =>
                  doc['emplacement'] == _selectedEmplacementFilter)
                      .toList();
                }

                return ListView.builder(
                  itemCount: equipments.length,
                  itemBuilder: (context, index) {
                    final data = equipments[index];
                    IconData icon;
                    Color color;

                    switch (data['type']) {
                      case 'Ventilateur':
                        icon = Icons.toys;
                        color = Colors.blue.shade300;
                        break;
                      case 'Déshumidificateur':
                        icon = Icons.cloud;
                        color = Colors.green.shade300;
                        break;
                      case 'HEPA':
                        icon = Icons.air;
                        color = Colors.orange.shade300;
                        break;
                      default:
                        icon = Icons.devices;
                        color = Colors.grey.shade300;
                    }

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        leading: Icon(icon, color: color),
                        title: Text(data['nom']),
                        subtitle: Text(
                            'Type: ${data['type']} • Emplacement: ${data['emplacement']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditDialog(data),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _equipementsRef.doc(data.id).delete(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Ajouter un nouvel équipement
  void _showAddDialog() async {
    final clientSnapshot =
    await FirebaseFirestore.instance.collection('ficheclient').get();
    List<String> clients =
    clientSnapshot.docs.map((doc) => doc['nomclient'] as String).toList();

    String? _selectedType;
    String? _selectedEmplacement;
    String? _customLabel;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ajouter un équipement"),
        content: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: types
                      .map((t) =>
                      DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  value: _selectedType,
                  onChanged: (val) => setState(() => _selectedType = val),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nom personnalisé (ex: Ventilateur 1)'),
                  onChanged: (val) => setState(() => _customLabel = val),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration:
                  const InputDecoration(labelText: 'Emplacement'),
                  items: [
                    ...emplacementsFixes.map(
                            (e) => DropdownMenuItem(value: e, child: Text(e))),
                    ...clients.map(
                            (c) => DropdownMenuItem(value: c, child: Text(c))),
                  ],
                  value: _selectedEmplacement,
                  onChanged: (val) =>
                      setState(() => _selectedEmplacement = val),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Annuler"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text("Ajouter"),
            onPressed: () async {
              if (_selectedType != null && _selectedEmplacement != null) {
                await _equipementsRef.add({
                  'type': _selectedType,
                  'nom': _customLabel?.isNotEmpty == true
                      ? _customLabel
                      : _selectedType,
                  'emplacement': _selectedEmplacement,
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 Modifier seulement l'emplacement
  void _showEditDialog(QueryDocumentSnapshot data) async {
    final clientSnapshot =
    await FirebaseFirestore.instance.collection('ficheclient').get();
    List<String> clients =
    clientSnapshot.docs.map((doc) => doc['nomclient'] as String).toList();

    String? _selectedEmplacement = data['emplacement'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modifier emplacement de ${data['nom']}"),
        content: StatefulBuilder(
          builder: (context, setState) => DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Nouvel emplacement'),
            value: _selectedEmplacement,
            items: [
              ...emplacementsFixes.map(
                      (e) => DropdownMenuItem(value: e, child: Text(e))),
              ...clients.map(
                      (c) => DropdownMenuItem(value: c, child: Text(c))),
            ],
            onChanged: (val) => setState(() => _selectedEmplacement = val),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Annuler"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text("Mettre à jour"),
            onPressed: () async {
              if (_selectedEmplacement != null) {
                await _equipementsRef.doc(data.id).update({
                  'emplacement': _selectedEmplacement,
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
