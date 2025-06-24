import 'package:flutter/material.dart';

class searchbar extends StatelessWidget {
  const searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.yellow,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
              //fillColor: Colors.lightBlue,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width:0,
                  style: BorderStyle.none
                )
              ),
              prefixIcon: const Icon(Icons.search_outlined,size: 30),
              hintText: "Rechercher un dossier"
            ),
          ),
          //const Positioned
            //(right: 12,
              //child: SizedBox(
            //height: 50,
            //width: 50,
                //child: Icon(
                  //Icons.mic_outlined
                //),
          //)
          //)
        ],
      ),
    );
  }
}
