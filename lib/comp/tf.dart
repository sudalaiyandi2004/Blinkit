import 'package:flutter/material.dart';
class Texts extends StatelessWidget {
  const Texts({super.key});

 

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
          child: TextField(
  decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelText: '''Search "cookies"''',
    prefixIcon: Icon(Icons.search, color: Colors.black),

    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("|", style: TextStyle(color: Colors.black)),
        IconButton(
          icon: Icon(Icons.mic, color: Colors.black),
          onPressed: () {},
        ),
      ],
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15), // Set border radius to 15
      borderSide: BorderSide(color: Colors.white, width: 2), // White border
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
  ),
)

        );
}

}