import 'package:flutter/material.dart';
import 'package:kagok_app/controller/apar_controller.dart';
import 'package:kagok_app/service/date_picker.dart';
import 'package:kagok_app/screen/apar/apar_form_screen.dart';

class AparScreen extends StatefulWidget {
  const AparScreen({super.key});

  @override
  State<AparScreen> createState() => _AparScreenState();
}

class _AparScreenState extends State<AparScreen> {
  final controller = AparController();
  TextEditingController searchController = TextEditingController();
  DateTime startDate =
      DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  late Future<dynamic> _aparDataFuture;

  @override
  void initState() {
    super.initState();
    _aparDataFuture = controller.getAparDataTable(
        context, startDate, endDate, searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'Data APAR',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 30), // Adjust the width as needed
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AparFormScreen(screenType: 'Tambah');
                  }));
                },
                heroTag: 'Tambah',
                elevation: 0,
                label: const Text("Tambah"),
                icon: const Icon(Icons.add),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 20),
          DateRangePickerWidget(onDateRangeChanged: (startDate, endDate) {
            // Handle date range change here
            setState(() {
              this.startDate = startDate;
              this.endDate = endDate;
            });
            _updateAparData(startDate, endDate);
          }),
          const SizedBox(height: 20),
          //SeachBar
          Row(
            children: [
              // Adjust the width as needed
              const SizedBox(width: 30),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              //Search Button
              FloatingActionButton(
                onPressed: () {
                  _updateAparData(startDate, endDate);
                },
                heroTag: 'Search',
                elevation: 0,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: const Icon(Icons.search),
              ),
              const SizedBox(width: 30),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: FutureBuilder(
                future: _aparDataFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return snapshot.data ?? Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateAparData(DateTime startDate, DateTime endDate) {
    setState(() {
      _aparDataFuture = controller.getAparDataTable(
          context, startDate, endDate, searchController.text);
    });
  }
}
