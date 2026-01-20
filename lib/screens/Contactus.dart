import 'package:flutter/material.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
       appBar: AppBar(
            title: const Text(
              'Contact Us',
              style: TextStyle(fontSize: 34),
            ),
            centerTitle: true,
            backgroundColor: Colors.orange.shade800,),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.phone),
              subtitle: Text("0721211212"),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.email),
              subtitle: Text("info.thisisme@gmail.com"),
            ),
          ],
        ),
      ),
      
    );

  }
}