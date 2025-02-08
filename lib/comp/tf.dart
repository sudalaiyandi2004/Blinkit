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
                  Text("|",style: TextStyle(color: Colors.black),)
                  ,
                  IconButton(
                    icon: Icon(Icons.mic, color: Colors.black),
                    onPressed: () {
                     
                    },
                  ),
                ],
              ),
          
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15)
            ),
          ),
        );
}

}