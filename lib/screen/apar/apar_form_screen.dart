import 'package:flutter/material.dart';
import 'package:kagok_app/controller/apar_controller.dart';
import 'package:intl/intl.dart';

class AparFormScreen extends StatefulWidget {
  final String screenType;

  final String? idIndex;
  final String? noApar;
  final String? lokasi;
  final String? jenis;
  final String? tglKedaluwarsa;
  final String? tglInput;
  final String? kapasitas;
  final String? selang;
  final String? pin;
  final String? isiTabung;
  final String? handleApar;
  final String? tekananGas;
  final String? corongBawah;
  final String? kebersihan;

  const AparFormScreen({
    super.key,
    this.screenType = '',
    this.idIndex = "",
    this.noApar = "",
    this.lokasi = "",
    this.jenis = "",
    this.tglKedaluwarsa = "",
    this.tglInput = "",
    this.kapasitas = "",
    this.selang = "",
    this.pin = "",
    this.isiTabung = "",
    this.handleApar = "",
    this.tekananGas = "",
    this.corongBawah = "",
    this.kebersihan = "",
  });

  @override
  // _AparFormScreenState createState() => _AparFormScreenState();
  State<AparFormScreen> createState() => _AparFormScreenState();
}

class _AparFormScreenState extends State<AparFormScreen> {
  Future<void> _process(BuildContext context) async {
    await AparController().process(
        context,
        widget.screenType == 'Edit' ? idIndexValue ?? "" : "",
        noAparValue.text,
        lokasiValue.text,
        jenisValue,
        tglKedaluwarsaValue ?? "",
        tglInputValue,
        kapasitasValue.text,
        selangValue.toString(),
        pinAparValue.toString(),
        isiTabungValue.toString(),
        handleAparValue.toString(),
        tekananGasValue.toString(),
        corongBawahValue.toString(),
        kebersihanValue.toString());
  }

  final TextEditingController noAparValue = TextEditingController();
  final TextEditingController lokasiValue = TextEditingController();
  String jenisValue = "";
  String tglInputValue = "";
  String? tglKedaluwarsaValue;
  final TextEditingController kapasitasValue = TextEditingController();
  String? pinAparValue;
  String? selangValue;
  String? isiTabungValue;
  String? handleAparValue;
  String? tekananGasValue;
  String? corongBawahValue;
  String? kebersihanValue;
  String? idIndexValue;

  List<String> jenisOptions = ['Powder', 'HCFC', 'Lain - Lain'];
  List<String> valueOption = ['powder', 'hcfc', 'lain-lain'];
  @override
  void initState() {
    super.initState();
    // Initialize hidden field values if provided
    if (widget.screenType == "Edit") {
      noAparValue.text = widget.noApar!;
      lokasiValue.text = widget.lokasi!;
      jenisValue = widget.jenis!;
      tglInputValue = widget.tglInput!;
      tglKedaluwarsaValue = widget.tglKedaluwarsa;
      kapasitasValue.text = widget.kapasitas!;
      pinAparValue = widget.pin;
      selangValue = widget.selang;
      isiTabungValue = widget.isiTabung;
      handleAparValue = widget.handleApar;
      tekananGasValue = widget.tekananGas;
      corongBawahValue = widget.corongBawah;
      kebersihanValue = widget.kebersihan;
      idIndexValue = widget.idIndex;

      //set also on form data
    }
    // print(noAparValue.text);
  }

  Future<void> _selectDate(BuildContext context, {String? dateField}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        final DateFormat formatter = DateFormat(
            'dd MMMM yyyy', Localizations.localeOf(context).toString());
        final formattedDate = formatter.format(pickedDate);
        if (dateField == 'tglInput') {
          // tglInputValue = pickedDate.toString().split(" ")[0];
          tglInputValue = formattedDate;
        } else if (dateField == 'tglKedaluwarsa') {
          // tglKedaluwarsaValue = pickedDate.toString().split(" ")[0];
          tglKedaluwarsaValue = formattedDate;
        }
      });
    }
  }

  Widget formData(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: noAparValue,
          decoration: const InputDecoration(
            labelText: 'No Apar',
          ),
        ),
        TextFormField(
          controller: lokasiValue,
          decoration: const InputDecoration(
            labelText: 'Lokasi',
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context, dateField: 'tglInput'),
          child: AbsorbPointer(
            child: TextFormField(
              controller: TextEditingController(text: tglInputValue),
              decoration: const InputDecoration(
                labelText: 'Tanggal Input',
              ),
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: jenisValue.isNotEmpty ? jenisValue : null,
          items: jenisOptions.map<DropdownMenuItem<String>>((String value) {
            int index = jenisOptions.indexOf(value);
            return DropdownMenuItem<String>(
              value: valueOption[index],
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Jenis',
          ),
          onChanged: (String? newValue) {
            setState(() {
              jenisValue = newValue!;
            });
          },
        ),
        GestureDetector(
          onTap: () => _selectDate(context, dateField: 'tglKedaluwarsa'),
          child: AbsorbPointer(
            child: TextFormField(
              controller: TextEditingController(text: tglKedaluwarsaValue),
              decoration: const InputDecoration(
                labelText: 'Tanggal Kedaluwarsa',
              ),
            ),
          ),
        ),
        TextFormField(
          controller: kapasitasValue,
          decoration: const InputDecoration(
            labelText: 'Kapasitas',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(
              flex: 3,
              child: Text('Pin APAR:'),
            ),
            Radio<String>(
              value: 'baik',
              groupValue: pinAparValue,
              onChanged: (String? value) {
                setState(() {
                  pinAparValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: pinAparValue,
              onChanged: (String? value) {
                setState(() {
                  pinAparValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for selang
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Selang:')),
            Radio<String>(
              value: 'baik',
              groupValue: selangValue,
              onChanged: (String? value) {
                setState(() {
                  selangValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: selangValue,
              onChanged: (String? value) {
                setState(() {
                  selangValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for isi tabung
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Isi Tabung:')),
            Radio<String>(
              value: 'Baik',
              groupValue: isiTabungValue,
              onChanged: (String? value) {
                setState(() {
                  isiTabungValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: isiTabungValue,
              onChanged: (String? value) {
                setState(() {
                  isiTabungValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for handle apar
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Handle APAR:')),
            Radio<String>(
              value: 'baik',
              groupValue: handleAparValue,
              onChanged: (String? value) {
                setState(() {
                  handleAparValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: handleAparValue,
              onChanged: (String? value) {
                setState(() {
                  handleAparValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for tekanan gas
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Tekanan Gas:')),
            Radio<String>(
              value: 'baik',
              groupValue: tekananGasValue,
              onChanged: (String? value) {
                setState(() {
                  tekananGasValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: tekananGasValue,
              onChanged: (String? value) {
                setState(() {
                  tekananGasValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for corong bawah
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Corong Bawah:')),
            Radio<String>(
              value: 'baik',
              groupValue: corongBawahValue,
              onChanged: (String? value) {
                setState(() {
                  corongBawahValue = value;
                });
              },
            ),
            const Text('Baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: corongBawahValue,
              onChanged: (String? value) {
                setState(() {
                  corongBawahValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        //create radio for kebersihan
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 1, child: Text('Kebersihan:')),
            Radio<String>(
              value: 'baik',
              groupValue: kebersihanValue,
              onChanged: (String? value) {
                setState(() {
                  kebersihanValue = value;
                });
              },
            ),
            const Text('baik'),
            Radio<String>(
              value: 'tidak baik',
              groupValue: kebersihanValue,
              onChanged: (String? value) {
                setState(() {
                  kebersihanValue = value;
                });
              },
            ),
            const Text('Tidak Baik'),
          ],
        ),

        const SizedBox(height: 20),
        FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () async {
            //send it to apar controller
            await _process(context);
          },
          heroTag: const Text("Simpan"),
          icon: const Icon(Icons.save),
          label: const Text("Simpan"),
          foregroundColor: Colors.white,
        ),
      ],
    );
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
                  '${widget.screenType} Data APAR',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              formData(context),
            ],
          ),
        ),
      ),
    );
  }
}
