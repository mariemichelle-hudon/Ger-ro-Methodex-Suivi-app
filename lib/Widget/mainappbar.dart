import 'package:flutter/material.dart';


class Mainappbar extends StatefulWidget implements PreferredSizeWidget {
  const Mainappbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  State<Mainappbar> createState() => _MainappbarState();
}

class _MainappbarState extends State<Mainappbar> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar:
      AppBar(automaticallyImplyLeading: true,

        foregroundColor: Colors.white,

        title:Center(
          child: const Icon(
              Icons.construction,
              color: Colors.white,
              size: 40),
        ),

        backgroundColor: Colors.orange,

        leading: Builder
          (builder: (context) {
          return IconButton(
              icon: Icon(Icons.menu),
              onPressed:Scaffold.of(context).openDrawer);
        },)
    ),
    );
  }
}
