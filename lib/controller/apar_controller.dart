import 'package:flutter/material.dart';
import 'package:kagok_app/model/apar/datatable_model.dart';
import 'package:kagok_app/model/common_model.dart';
import 'package:kagok_app/service/api_service.dart';
import 'package:kagok_app/screen/apar/apar_form_screen.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  Future process(
      BuildContext context,
      String idIndex,
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
      String kebersihan) async {
    List<String> requiredField = [
      'no_apar',
      'lokasi',
      'jenis_apar',
      'tgl_input',
      'selang',
      'pin',
      'isi_tabung',
      'handle_apar',
      'tekanan_gas',
      'corong_bawah',
      'kebersihan'
    ];

    final requestData = {
      "id_index_apar": idIndex,
      "no_apar": noApar,
      "lokasi": lokasi,
      "jenis_apar": jenis,
      "tgl_kedaluwarsa": tglKedaluwarsa,
      "tgl_input": tglInput,
      "kapasitas": kapasitas,
      "selang": selang,
      "pin": pin,
      "isi_tabung": isiTabung,
      "handle_apar": handleApar,
      "tekanan_gas": tekananGas,
      "corong_bawah": corongBawah,
      "kebersihan": kebersihan
    };

    //check if required data is empty based on requiredField
    for (var element in requiredField) {
      if (requestData[element] == null ||
          requestData[element] == "" ||
          requestData[element] == "null") {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Field $element is required"),
              backgroundColor: Colors.red,
              showCloseIcon: true,
            ),
          );
        }
        return null;
      }
    }

    // change tglInput format from 01 June 2024 to d/m/Y
    DateTime tglInputDate = DateFormat("d MMMM y").parse(tglInput);
    tglInput = DateFormat("d/M/y").format(tglInputDate);

    if (tglKedaluwarsa != "") {
      // change tglKedaluwarsa format from 01 June 2024 to Y-m-d
      DateTime tglKedaluwarsaDate =
          DateFormat("d MMMM y").parse(tglKedaluwarsa);
      tglKedaluwarsa = DateFormat("d/M/y").format(tglKedaluwarsaDate);
    }

    //upddate tgl_input and tgl_kedaluwarsa
    requestData['tgl_input'] = tglInput;
    requestData['tgl_kedaluwarsa'] = tglKedaluwarsa;

    final data = await APIService().apiProvider(
        context: context,
        method: "POST",
        endpoint: "/apar/process",
        requestdata: requestData,
        model: (json) => CommonModel.fromJson(json),
        showNotification: true);

    if (data?.metadata.status == 200) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/apar');
        // Navigator.pop(context, true);
      }
    }

    return data;
  }

  Future hapus(BuildContext context, String idIndex) async {
    final requestData = {"id": idIndex};

    final data = await APIService().apiProvider(
        context: context,
        method: "POST",
        endpoint: "/apar/delete",
        requestdata: requestData,
        model: (json) => CommonModel.fromJson(json),
        showNotification: true);

    if (data?.metadata.status == 200) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/apar');
        // Navigator.pop(context, true);
      }
    }

    return data;
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
        String id = data.id.toString();
        if (arrAction.isNotEmpty) {
          List<Widget> arrActionRow = [];

          for (var element in arrAction) {
            switch (element) {
              case 'edit':
                arrActionRow.add(FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return AparFormScreen(
                        screenType: 'Edit',
                        idIndex: id,
                        noApar: data.noApar,
                        lokasi: data.lokasi,
                        jenis: data.jenisApar,
                        tglKedaluwarsa: data.tglKedaluwarsa,
                        tglInput: data.tglInput,
                        kapasitas: data.kapasitas,
                        selang: data.selang,
                        pin: data.pin,
                        isiTabung: data.isiTabung,
                        handleApar: data.handleApar,
                        tekananGas: data.tekananGas,
                        corongBawah: data.corongBawah,
                        kebersihan: data.kebersihan,
                      );
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
                  onPressed: () {
                    showModalDelete(context, data.id);
                  },
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

  void showModalDelete(BuildContext context, int idIndexData) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'Yakin Menghapus Data Ini?',
      desc: 'Data yang sudah dihapus tidak bisa dikembalikan',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        //hapus data;
        AparController().hapus(context, idIndexData.toString());
      },
    ).show();
  }
}
