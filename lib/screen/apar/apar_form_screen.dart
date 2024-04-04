import 'package:flutter/material.dart';
import 'package:kagok_app/controller/apar_controller.dart';

//stateless widget
class AparFormScreen extends StatelessWidget {
  ///
  /** 
   * 
   *  'no_apar'       => $data['no_apar'],
      'lokasi'        => $data['lokasi'],
      'jenis'         => $data['jenis_apar'],
      'tgl_kedaluwarsa' => $data['tgl_kedaluwarsa'],
      'tgl_input'     => $data['tgl_input'], //format 'Y-m-d
      'kapasitas'     => $data['kapasitas'],
      'selang'        => $data['selang'],
      'pin'           => $data['pin'],
      'isi_tabung'    => $data['isi_tabung'],
      'handle_apar'   => $data['handle_apar'],
      'tekanan_gas'   => $data['tekanan_gas'],
      'corong_bawah'  => $data['corong_bawah'],
      'kebersihan'    => $data['kebersihan'],
   */
  ///
  final String screenType;
  final String noApar;
  final String lokasi;
  final String jenis;
  final String tglKedaluwarsa;
  final String tglInput;
  final String kapasitas;
  final String selang;
  final String pin;
  final String isiTabung;
  final String handleApar;
  final String tekananGas;
  final String corongBawah;
  final String kebersihan;

  const AparFormScreen({
    super.key,
    this.screenType = '',
    this.noApar = '',
    this.lokasi = '',
    this.jenis = '',
    this.tglKedaluwarsa = '',
    this.tglInput = '',
    this.kapasitas = '',
    this.selang = '',
    this.pin = '',
    this.isiTabung = '',
    this.handleApar = '',
    this.tekananGas = '',
    this.corongBawah = '',
    this.kebersihan = '',
  });

  validate(text) {
    if (text.isEmpty || text == Null) {
      return "This field is required";
    }

    if (!text is String) {
      return "This field must be a string";
    }

    return null;
  }

  Widget formData() {
    TextEditingController noAparValue = TextEditingController();
    TextEditingController lokasiValue = TextEditingController();
    String jenisValue = "";
    String tglKedaluwarsaValue;
    String tglInputValue;
    String kapasitasValue;
    String selangValue;
    String pinValue;
    String isiTabungValue;
    String handleAparValue;
    String tekananGasValue;
    String corongBawahValue;
    String kebersihanValue;
    List<String> jenisOptions = ['Powder', 'HCFC', 'Lain - Lain'];
    return Column(children: <Widget>[
      TextFormField(
        controller: noAparValue,
        validator: (text) => validate(text),
        decoration: const InputDecoration(
          labelText: 'No Apar',
          hintText: '',
        ),
      ),
      TextFormField(
        controller: lokasiValue,
        validator: (text) => validate(text),
        decoration: const InputDecoration(
          labelText: 'Lokasi',
          hintText: '',
        ),
      ),
      DropdownButtonFormField<String>(
          items: jenisOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Jenis',
            hintText: '',
          ),
          onChanged: (String? newValue) {
            jenisValue = newValue!;
          }),

      //Submit button
      const SizedBox(height: 20),
      FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          print(noAparValue.text);
          print(jenisValue);
        },
        child: const Icon(Icons.save),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    '$screenType Data APAR',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                formData()
              ]),
        )));
  }

  void setState(Null Function() param0) {}
}
