class AparDataTable {
  final int draw;
  final int recordsTotal;
  final int recordsFiltered;
  final List<Data> data;

  AparDataTable({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
  });

  factory AparDataTable.fromJson(Map<String, dynamic> json) {
    return AparDataTable(
      draw: json['draw'] ?? 0,
      recordsTotal: json['recordsTotal'] ?? 0,
      recordsFiltered: json['recordsFiltered'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((data) => Data.fromJson(data))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'draw: $draw, recordsTotal: $recordsTotal, recordsFiltered: $recordsFiltered, data: ${data.toString()}';
  }
}

class Data {
  final int id;
  final String noApar;
  final String lokasi;
  final String jenisApar;
  final String tglInput;
  final String kapasitas;
  final String selang;
  final String pin;
  final String isiTabung;
  final String handleApar;
  final String tekananGas;
  final String corongBawah;
  final String kebersihan;
  final String insertAt;
  final String insertBy;
  final int insertById;
  final String? updateAt;
  final String? updateBy;
  final int status;
  final String tglKedaluwarsa;
  final List<dynamic> action;
  final int dtRowIndex;

  Data({
    required this.id,
    required this.noApar,
    required this.lokasi,
    required this.jenisApar,
    required this.tglInput,
    required this.kapasitas,
    required this.selang,
    required this.pin,
    required this.isiTabung,
    required this.handleApar,
    required this.tekananGas,
    required this.corongBawah,
    required this.kebersihan,
    required this.insertAt,
    required this.insertBy,
    required this.insertById,
    this.updateAt,
    this.updateBy,
    required this.status,
    required this.tglKedaluwarsa,
    required this.action,
    required this.dtRowIndex,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      noApar: json['no_apar'] ?? '',
      lokasi: json['lokasi'] ?? '',
      jenisApar: json['jenis_apar'] ?? '',
      tglInput: json['tgl_input'] ?? '',
      kapasitas: json['kapasitas'] ?? '',
      selang: json['selang'] ?? '',
      pin: json['pin'] ?? '',
      isiTabung: json['isi_tabung'] ?? '',
      handleApar: json['handle_apar'] ?? '',
      tekananGas: json['tekanan_gas'] ?? '',
      corongBawah: json['corong_bawah'] ?? '',
      kebersihan: json['kebersihan'] ?? '',
      insertAt: json['insert_at'] ?? '',
      insertBy: json['insert_by'] ?? '',
      insertById: json['insert_by_id'] ?? 0,
      updateAt: json['update_at'],
      updateBy: json['update_by'],
      status: json['status'] ?? 0,
      tglKedaluwarsa: json['tgl_kedaluwarsa'] ?? '',
      action: json['action'] ?? '',
      dtRowIndex: json['DT_RowIndex'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'id: $id, noApar: $noApar, lokasi: $lokasi, jenisApar: $jenisApar, tglInput: $tglInput, '
        'kapasitas: $kapasitas, selang: $selang, pin: $pin, isiTabung: $isiTabung, handleApar: $handleApar, '
        'tekananGas: $tekananGas, corongBawah: $corongBawah, kebersihan: $kebersihan, '
        'insertAt: $insertAt, insertBy: $insertBy, insertById: $insertById, '
        'updateAt: $updateAt, updateBy: $updateBy, status: $status, '
        'tglKedaluwarsa: $tglKedaluwarsa, action: $action, dtRowIndex: $dtRowIndex';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_apar': noApar,
      'lokasi': lokasi,
      'jenis_apar': jenisApar,
      'tgl_input': tglInput,
      'kapasitas': kapasitas,
      'selang': selang,
      'pin': pin,
      'isi_tabung': isiTabung,
      'handle_apar': handleApar,
      'tekanan_gas': tekananGas,
      'corong_bawah': corongBawah,
      'kebersihan': kebersihan,
      'insert_at': insertAt,
      'insert_by': insertBy,
      'insert_by_id': insertById,
      'update_at': updateAt,
      'update_by': updateBy,
      'status': status,
      'tgl_kedaluwarsa': tglKedaluwarsa,
      'action': action,
      'DT_RowIndex': dtRowIndex,
    };
  }
}
