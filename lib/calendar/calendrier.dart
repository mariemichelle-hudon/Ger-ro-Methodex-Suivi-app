import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendrier extends StatefulWidget {
  const Calendrier({super.key});

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  late CalendarBuilders _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarBuilders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horraire",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        automaticallyImplyLeading:true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2025,01,01),
              lastDay: DateTime.utc(2030,12,31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
              )
          ],
        ),
      ),
    );
  }
}
