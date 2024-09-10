import 'package:flutter/material.dart';


class custextfiled extends StatefulWidget {


  final TextEditingController?controller;
  final String hintText;
  
  custextfiled({super.key, this.controller, required this.hintText,});

  @override
  State<custextfiled> createState() => _custextfiledState();
}

class _custextfiledState extends State<custextfiled> {
  GlobalKey<FormState> formState=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      
      child:
    Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        
        
      
        controller: widget.controller,
      
      decoration: InputDecoration(

      hintText: widget.hintText,
   
       
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      
    
      
      ),
      
      
      ),
    )
    
    
    
    
    
     );
  }
}