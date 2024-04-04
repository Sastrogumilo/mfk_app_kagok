import 'package:flutter/material.dart';
import 'package:kagok_app/model/apar/datatable_model.dart';
import 'package:kagok_app/service/api_service.dart';
import 'package:kagok_app/screen/apar/apar_form_screen.dart';

class AparController {
  Future getAparDataTable(BuildContext context, DateTime startDate,
      DateTime endDate, String search) async {
    Map<String, dynamic> requestdata = {
      "start_date": startDate.toString().split(" ")[0],
      "end_date": endDate.toString().split(" ")[0],
      "search": {"value": search}
    };

    final data = await APIService().apiProvider(
        context: context,
        method: "POST",
        endpoint: "/apar/datatable",
        requestdata: requestdata,
        model: (json) => AparDataTable.fromJson(json),
        showNotification: false);

    // return data;
    return ListView.builder(
      itemCount: data?.response.recordsTotal,
      itemBuilder: (context, index) {
        Data item = data!.response.data[index];
        return DataTile(data: item);
      },
    );
  }

  bool process(
      BuildContext context,
      String noApar,
      String lokasi,
      String jenis,
      String tglKedaluwarsa,
      String tglInput,
      String kapasitas,
      String selang,
      String pin,
      String isiTabung,
      String handleApar,
      String tekananGas,
      String corongBawah,
      String kebersihan) {
    return true;
  }
}

class DataTile extends StatelessWidget {
  final Data data;
  const DataTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    //make copy of data to map
    Map<String, dynamic> dataMap = data.toJson();

    List<Widget> arrTile = [];
    dataMap.forEach((key, value) {
      if (key == 'action') {
        List<dynamic> arrAction = value;
        if (arrAction.isNotEmpty) {
          List<Widget> arrActionRow = [];

          for (var element in arrAction) {
            switch (element) {
              case 'edit':
                arrActionRow.add(FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AparFormScreen(screenType: 'Edit');
                    }));
                  },
                  heroTag: 'Edit',
                  elevation: 0,
                  label: const Text("Edit"),
                  icon: const Icon(Icons.edit),
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.white,
                ));
                arrActionRow.add(const SizedBox(width: 16.0));

              case 'delete':
                arrActionRow.add(FloatingActionButton.extended(
                  onPressed: () {},
                  heroTag: 'Hapus',
                  elevation: 0,
                  label: const Text("Hapus"),
                  icon: const Icon(Icons.delete),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ));
                arrActionRow.add(const SizedBox(width: 16.0));
                break;
              default:
                arrActionRow.add(const Text(""));
            }
          }

          var rowAction = Row(
            children: arrActionRow,
          );

          arrTile.insert(0, rowAction);
        }
      } else {
        arrTile.add(ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  key.toString(),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                ':',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 3,
                child: Text(
                  '$value',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ));
      }
    });

    return ExpansionTile(
      title: Text(
          '${data.tglInput} - ${data.insertBy} - ${data.lokasi} - ${data.noApar}'),
      children: arrTile,
    );
  }
}
