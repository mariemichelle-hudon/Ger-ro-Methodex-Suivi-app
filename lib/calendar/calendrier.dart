import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../page/drawer.dart';
import 'meeting.dart';
import 'nouvelletache.dart';


// 🔹 Modèle Meeting
class Meeting {
  Meeting(this.eventName, this.from, this.to,
      {this.employeeId,
        this.nomContremaitre,
        this.nomApprenti,
        this.description,
        this.id});

  String eventName;
  DateTime from;
  DateTime to;
  String? employeeId;
  String? nomContremaitre;
  String? nomApprenti;
  String? description;
  String? id;
}


class CalendrierEmployes extends StatefulWidget {
  const CalendrierEmployes({super.key, required this.dsutilisateur, required this.dsempl});
  final DocumentSnapshot dsutilisateur;
  final DocumentSnapshot dsempl;

  @override
  State<CalendrierEmployes> createState() => _CalendrierEmployesState();
}

class _CalendrierEmployesState extends State<CalendrierEmployes> {
  MeetingDataSource? _dataSource;
  List<CalendarResource> _employees = [];
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _fetchEmployees();
    await _fetchAppointmentsFromFirebase();

    setState(() {
      _dataSource = MeetingDataSource(_appointments, _employees);
    });
  }

  Future<void> _fetchEmployees() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('utilisateur').where('fonction',isNotEqualTo: "Chargé de projet").get();

    _employees = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return CalendarResource(
        id: doc.id,
        displayName: (data['nom'] ?? "Inconnu").toString(),
        color: Colors.orange,
        image: (data['photoUrl'] != null && data['photoUrl'] != "")
            ? NetworkImage(data['photoUrl'] as String)
            : null,
      );
    }).toList();
  }

  Future<void> _fetchAppointmentsFromFirebase() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('calendrier').get();
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final start = (data['debut'] as Timestamp).toDate();

      if (start.isBefore(DateTime.now().subtract(Duration(days: 14)))) {
        await doc.reference.delete(); // 👈 suppression Firestore
        continue;
      }
    }

    _appointments = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      // ⚡ si c’est une seule string, on la convertit en liste
      final List<Object> empIds = data['employes'] != null
          ? List<String>.from(data['employes'])
          : (data['employes'] != null ? [data['employes']] : []);


      return Appointment(
        startTime: (data['debut'] as Timestamp).toDate(),
        endTime: (data['fin'] as Timestamp).toDate(),
        subject: (data['nomclient'] ?? 'Sans titre').toString(),
        notes: (data['description'] ?? '').toString(),
        color: _getRandomColor(),
        id: doc.id,
        resourceIds: empIds, // 👈 plusieurs employés assignés
      );



    }).toList();
  }


  Color _getRandomColor() {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.orange,
    ];
    colors.shuffle();
    return colors.first;
  }

  void _showAppointmentDetails(Appointment appointment) {
    List<String> employeeNames = [];

    if (appointment.resourceIds != null && appointment.resourceIds!.isNotEmpty) {
      for (var id in appointment.resourceIds!) {
        final emp = _employees.firstWhere(
              (e) => e.id == id,
          orElse: () => CalendarResource(
            id: "?",
            displayName: "Inconnu",
            color: Colors.grey,
          ),
        );
        employeeNames.add(emp.displayName);
      }
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          appointment.subject.isNotEmpty ? appointment.subject : "Sans titre",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Employés : ${employeeNames.join(', ')}"), // 👈 liste jointe
            Text("Début : ${appointment.startTime}"),
            Text("Fin : ${appointment.endTime}"),
            if (appointment.notes != null && appointment.notes!.isNotEmpty)
              Text("Notes : ${appointment.notes}"),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
            onPressed: () async {
              Navigator.of(context).pop();
              if (appointment.id != null) {
                await FirebaseFirestore.instance
                    .collection('calendrier')
                    .doc(appointment.id.toString())
                    .delete();
                _fetchAppointmentsFromFirebase(); // rafraîchir
              }
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fermer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendrier"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
    backgroundColor: Colors.orange,
    onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: ((context)=> Nouvelletache()
    )));
    },
    child:
    const Icon(Icons.add,
    color: Colors.white,)),
      drawer: CustomDrawer(dsutilisateur: widget.dsutilisateur, dsempl: widget.dsempl,),


      body: _dataSource == null
          ? const Center(child: CircularProgressIndicator())
          : SfCalendar(
        view: CalendarView.timelineWorkWeek,
        dataSource: _dataSource,
    resourceViewSettings:ResourceViewSettings(
      size: 100
    ),
    resourceViewHeaderBuilder: (BuildContext context, ResourceViewHeaderDetails details) {
    return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(4),
    color: Colors.orange,
    child: Text(
    details.resource.displayName,
    textAlign: TextAlign.center,
    style: const TextStyle(
    color: Colors.white,
    fontSize: 14,
    ),
    maxLines: 2, // 👈 autorise 2 lignes
    softWrap: true,       // 👈 permet le retour à la ligne
    ),);},
        timeSlotViewSettings: const TimeSlotViewSettings(
          startHour: 7,
          endHour: 17,
          nonWorkingDays: [DateTime.saturday, DateTime.sunday],
        ),
        todayHighlightColor: Colors.orange,
        showNavigationArrow: true,

        onTap: (CalendarTapDetails details) {
          if (details.appointments != null &&
              details.appointments!.isNotEmpty) {
            final Appointment appt =
            details.appointments!.first as Appointment;
            _showAppointmentDetails(appt);
          }
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source, List<CalendarResource> resources) {
    appointments = source;
    this.resources = resources;
  }
}
