import 'package:flutter/material.dart';
class Teamdrop extends StatefulWidget {
  final ValueChanged<int?> onValueSelected;
  const Teamdrop({super.key,required this.onValueSelected});

  @override
  State<Teamdrop> createState() => _TeamdropState();
}

class _TeamdropState extends State<Teamdrop> {
  @override
  int _selectedValue = 0;
  Widget build(BuildContext context) {
    return DropdownMenu(
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
      onSelected: (int? val) {
        setState(() {
          _selectedValue = val ?? 0;
        });
        widget.onValueSelected(_selectedValue);
      });;
  }
}
