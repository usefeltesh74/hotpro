import 'package:flutter/material.dart';

class PlayerDropMenu extends StatefulWidget {
  final ValueChanged<int?> onValueSelected; // Callback for selected value

  PlayerDropMenu({Key? key, required this.onValueSelected}) : super(key: key);

  @override
  State<PlayerDropMenu> createState() => _PlayerDropMenuState();
}

class _PlayerDropMenuState extends State<PlayerDropMenu> {
  int _selectedValue = 0; // Default value

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownMenu(
        width: 400,
        label: Text(
          'Select your player bet',
          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
        ),
        dropdownMenuEntries: const <DropdownMenuEntry<int>>[
          DropdownMenuEntry(value: 0, label: "0 point : 0\$"),
          DropdownMenuEntry(value: 10000, label: "1 point : \$10k"),
          DropdownMenuEntry(value: 20000, label: "2 points : \$20k"),
          DropdownMenuEntry(value: 30000, label: "3 points : \$30k"),
          DropdownMenuEntry(value: 40000, label: "4 points : \$40k"),
          DropdownMenuEntry(value: 50000, label: "5 points : \$50k"),
          DropdownMenuEntry(value: 60000, label: "6 points : \$60k"),
          DropdownMenuEntry(value: 70000, label: "7 points : \$70k"),
          DropdownMenuEntry(value: 80000, label: "8 points : \$80k"),
          DropdownMenuEntry(value: 90000, label: "9 points : \$90k"),
          DropdownMenuEntry(value: 100000, label: "10 points : \$100k"),
          DropdownMenuEntry(value: 110000, label: "11 points : \$110k"),
          DropdownMenuEntry(value: 120000, label: "12 points : \$120k"),
          DropdownMenuEntry(value: 130000, label: "13 points : \$130k"),
          DropdownMenuEntry(value: 140000, label: "14 points : \$140k"),
          DropdownMenuEntry(value: 150000, label: "15 points : \$150k"),
          DropdownMenuEntry(value: 160000, label: "16 points : \$160k"),
          DropdownMenuEntry(value: 170000, label: "17 points : \$170k"),
          DropdownMenuEntry(value: 180000, label: "18 points : \$180k"),
          DropdownMenuEntry(value: 190000, label: "19 points : \$190k"),
          DropdownMenuEntry(value: 200000, label: "20 points : \$200k"),
        ],
        onSelected: (int? val) {
          setState(() {
            _selectedValue = val ?? 0;
          });
          widget.onValueSelected(_selectedValue); // Notify parent with the selected value
        },
      ),
    );
  }
}
