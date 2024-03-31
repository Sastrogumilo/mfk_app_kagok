import 'package:flutter/material.dart';
//import shared preference
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> homeMenu(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> userMenu = prefs.getStringList('menu') ?? [];

  if (userMenu.isEmpty) {
    return const Center(
        child: Text("Anda belum mendapatkan menu, silahkan hubungi admin"));
  }

  List<Map<String, dynamic>> listMenu = [
    {
      "route": "/user_management",
      "herotag": "",
      "elevation": 0.0,
      "label": "User Management",
      "icon": const Icon(Icons.person_add_alt_1),
    },
    {
      "route": "/apar",
      "herotag": "",
      "elevation": 0.0,
      "label": "APAR",
      "icon": const Icon(Icons.person_add_alt_1),
    },
    {
      "route": "/ipal",
      "herotag": "",
      "elevation": 0.0,
      "label": "IPAL",
      "icon": const Icon(Icons.person_add_alt_1),
    },
    {
      "route": "/gas_medik",
      "herotag": "",
      "elevation": 0.0,
      "label": "Gas Medik",
      "icon": const Icon(Icons.person_add_alt_1),
    },
  ];

  // Filter listMenu based on userMenu
  List<Map<String, dynamic>> filteredMenu =
      listMenu.where((menu) => userMenu.contains(menu['route'])).toList();
  int maxTextLength = listMenu
      .map((menu) => menu['label'].toString().length)
      .reduce((value, element) => value > element ? value : element);
  return SizedBox(
    height:
        MediaQuery.of(context).size.height * 0.21, // Adjust height as needed
    child: GridView.count(
      crossAxisCount: 3, // Change the number of columns as needed
      mainAxisSpacing: 16.0, // Adjust spacing between items vertically
      crossAxisSpacing: 16.0, // Adjust spacing between items horizontally
      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
      childAspectRatio: (maxTextLength / 12),
      children: filteredMenu.map((menu) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, menu['route']),
          child: Card(
            elevation: menu['elevation'],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(menu['icon'].icon),
                const SizedBox(height: 4), // Add spacing between icon and text
                Expanded(
                    // Wrap the Text widget with Expanded
                    child: Text(
                  menu['label'],
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis, // Handle text overflow
                )),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}
