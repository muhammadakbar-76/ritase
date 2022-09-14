import 'package:equatable/equatable.dart';

class RitaseModel extends Equatable {
  const RitaseModel({
    required this.ritaseId,
    required this.ritaseDate,
    required this.ritaseTime,
    required this.ritaseMaterial,
    required this.ritaseKategori,
    required this.ritaseKeterangan,
    required this.kodeUnit,
  });

  final int ritaseId;

  final String ritaseDate;

  final String ritaseTime;

  final String ritaseMaterial;

  final String ritaseKategori;

  final String ritaseKeterangan;

  final int kodeUnit;

  factory RitaseModel.fromJson(Map<String, dynamic> json) => RitaseModel(
        ritaseId: json['ritase_id'],
        ritaseDate: json['ritase_date'],
        ritaseTime: json['ritase_time'],
        ritaseMaterial: json['ritase_material'],
        ritaseKategori: json['ritase_kategori'],
        ritaseKeterangan: json['ritase_keterangan'],
        kodeUnit: json['kode_unit'],
      );

  Map<String, dynamic> toMap() {
    return {
      'ritase_id': ritaseId,
      'ritase_date': ritaseDate,
      'ritase_time': ritaseTime,
      'ritase_material': ritaseMaterial,
      'ritase_kategori': ritaseKategori,
      'ritase_keterangan': ritaseKeterangan,
      'kode_unit': kodeUnit,
    };
  }

  @override
  List<Object?> get props => [
        ritaseId,
        ritaseDate,
        ritaseTime,
        ritaseMaterial,
        ritaseKategori,
        ritaseKeterangan,
        kodeUnit
      ];
}
