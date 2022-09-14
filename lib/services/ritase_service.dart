import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ritase/models/ritase_model.dart';

class RitaseService {
  final Dio _dio = Dio();

  Future<List<dynamic>> getRitases() async {
    var response =
        await _dio.get('https://ritase-app-backend.herokuapp.com/api/ritase');
    var listOfUnits = response.data as Map<String, dynamic>;
    return listOfUnits['data']
        .map((json) => RitaseModel.fromJson(json))
        .toList();
  }

  Future<Map<String, dynamic>> createRitase({
    required String ritaseMaterial,
    required String ritaseKategori,
    required String ritaseKeterangan,
    required int kodeUnit,
  }) async {
    var response = await _dio.post(
      'https://ritase-app-backend.herokuapp.com/api/ritase',
      data: {
        'ritase_material': ritaseMaterial,
        'ritase_kategori': ritaseKategori,
        'ritase_keterangan': ritaseKeterangan,
        'kode_unit': kodeUnit,
      },
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").toString(),
      ),
    );
    var data = response.data as Map<String, dynamic>;
    return data['meta'];
  }

  Future<Map<String, dynamic>> editRitase({
    required int ritaseId,
    required String ritaseMaterial,
    required String ritaseKategori,
    required String ritaseKeterangan,
    required int kodeUnit,
  }) async {
    var response = await _dio.put(
      "https://ritase-app-backend.herokuapp.com/api/ritase/$ritaseId",
      data: {
        'ritase_material': ritaseMaterial,
        'ritase_kategori': ritaseKategori,
        'ritase_keterangan': ritaseKeterangan,
        'kode_unit': kodeUnit,
      },
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").toString(),
      ),
    );
    var data = response.data as Map<String, dynamic>;
    return data['meta'];
  }

  Future<Map<String, dynamic>> deleteRitase({
    required int ritaseId,
  }) async {
    var response = await _dio.delete(
      "https://ritase-app-backend.herokuapp.com/api/ritase/$ritaseId",
      options: Options(
        contentType:
            ContentType.parse("application/x-www-form-urlencoded").toString(),
      ),
    );
    var data = response.data as Map<String, dynamic>;
    return data['meta'];
  }
}
