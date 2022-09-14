import 'package:dio/dio.dart';
import 'package:ritase/models/unit_model.dart';

class UnitService {
  final Dio _dio = Dio();

  Future<List<dynamic>> getUnits() async {
    var response =
        await _dio.get('https://ritase-app-backend.herokuapp.com/api/units');
    var listOfUnits = response.data;
    return listOfUnits['data'].map((json) => UnitModel.fromJson(json)).toList();
  }
}
