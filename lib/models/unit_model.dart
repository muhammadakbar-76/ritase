import 'package:equatable/equatable.dart';

class UnitModel extends Equatable {
  const UnitModel({
    required this.unitKode,
    required this.name,
    required this.operator,
  });

  final int unitKode;

  final String name;

  final String operator;

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        unitKode: json['unit_kode'],
        name: json['name'],
        operator: json['operator'],
      );

  Map<String, dynamic> toMap() {
    return {
      'unit_kode': unitKode,
      'name': name,
      'operator': operator,
    };
  }

  @override
  List<Object?> get props => [unitKode, name, operator];
}
