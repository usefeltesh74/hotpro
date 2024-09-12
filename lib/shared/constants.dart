import 'package:flutter/material.dart';
const text_input_dec = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white , width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent , width: 2),
  ),
);


int x=0;
const Team_dropmenu = DropdownMenu(
  width: 400,
  label: Text("Select your Expected team points",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
  dropdownMenuEntries: <DropdownMenuEntry<int>>[
    DropdownMenuEntry(value: 10000, label: '10 points : \$10k'),
    DropdownMenuEntry(value: 20000, label: '20 points : \$20k'),
    DropdownMenuEntry(value: 30000, label: '30 points : \$30k'),
    DropdownMenuEntry(value: 40000, label: '40 points : \$40k'),
    DropdownMenuEntry(value: 50000, label: '50 points : \$50k'),
    DropdownMenuEntry(value: 60000, label: '60 points : \$60k'),
    DropdownMenuEntry(value: 70000, label: '70 points : \$70k'),
    DropdownMenuEntry(value: 80000, label: '80 points : \$80k'),
    DropdownMenuEntry(value: 90000, label: '90 points : \$90k'),
    DropdownMenuEntry(value: 100000, label: '100 points : \$100k'),
  ],

);


var Box_dec = BoxDecoration(
    color: Colors.orange ,
    shape: BoxShape.rectangle,
    borderRadius:  BorderRadius.circular(30),
    boxShadow: const [BoxShadow(color: Colors.teal,spreadRadius: 7,blurRadius: 13,offset: Offset(0, 3))]
);

var tiles_dec = BoxDecoration(
    color: Colors.teal[50] ,
    shape: BoxShape.rectangle,
    borderRadius:  BorderRadius.circular(20),
    boxShadow: const [BoxShadow(color: Colors.teal,spreadRadius: 7,blurRadius: 13,offset: Offset(0, 3))]
);