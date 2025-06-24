
import 'package:flutter/material.dart';

class CategorieSection extends StatelessWidget {
   CategorieSection({super.key});

  final categorie = [
    {
      "icon" : Icons.all_inclusive,
      "color" : Colors.lightBlue,
      "title" : "Tout"
    },
    {
      "icon" : Icons.fire_truck,
      "color" : Colors.lightBlue,
      "title" : "Urgence"
    },
    {
      "icon" : Icons.book,
      "color" : Colors.lightBlue,
      "title" : "Soumission"
    },
    {
      "icon" : Icons.access_time_outlined,
      "color" : Colors.lightBlue,
      "title" : "En attente"
    },
    {
      "icon" : Icons.call,
      "color" : Colors.lightBlue,
      "title" : "À planifier"
    },
    {
      "icon" : Icons.construction,
      "color" : Colors.lightBlue,
      "title" : "En cours"
    },
    {
      "icon" : Icons.add_card,
      "color" : Colors.lightBlue,
      "title" : "À facturer"
    },
    {
      "icon" : Icons.task_alt,
      "color" : Colors.blueGrey,
      "title" : "Terminé"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        //color: Colors.yellow,
        height: 105,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20
              ),
              height: 105,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:categorie[index]["color"] as Color),
                        child: Icon(
                            categorie[index]['icon'] as IconData,
                          color:Colors.white)
                      ),
                    Text(categorie[index]['title'] as String,
                      style: const TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                      ) ,
                    ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(width: 33,),
                  itemCount: categorie.length),
            )
          ],
        ),
      ),
    );
  }
}
