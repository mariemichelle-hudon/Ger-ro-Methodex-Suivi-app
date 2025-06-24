import 'package:flutter/material.dart';


class Splashpage extends StatelessWidget {
  int? duration =0;

  Splashpage({required this.duration});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                child: const Icon(Icons.construction, color: Colors.white,size: 100),
              )
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(.5)
                  ) ,
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
