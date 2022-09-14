import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ritase/db/ritase_db_operation.dart';
import 'package:ritase/services/ritase_service.dart';

part 'ritase_state.dart';

class RitaseCubit extends Cubit<RitaseState> {
  RitaseCubit() : super(RitaseInitial());

  final RitaseService _ritaseService = RitaseService();

  final RitaseDBOperation _ritaseDBOperation = RitaseDBOperation();

  void getRitases() async {
    try {
      emit(RitaseLoading());
      var ritases = await _ritaseService.getRitases();
      await _ritaseDBOperation.deleteAllRitases();
      await _ritaseDBOperation.insertRitases(ritases);
      emit(RitaseSuccess(ritases));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(RitaseFailed(e.message));
      } else {
        emit(RitaseFailed(e.toString()));
      }
    }
  }

  void createRitase({
    required String ritaseMaterial,
    required String ritaseKategori,
    required String ritaseKeterangan,
    required int kodeUnit,
  }) async {
    try {
      emit(RitaseLoading());
      var meta = await _ritaseService.createRitase(
        kodeUnit: kodeUnit,
        ritaseKategori: ritaseKategori,
        ritaseKeterangan: ritaseKeterangan,
        ritaseMaterial: ritaseMaterial,
      );
      emit(RitaseSended(meta));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(RitaseFailed(e.message));
      } else {
        emit(RitaseFailed(e.toString()));
      }
    }
  }

  void editRitase({
    required int ritaseId,
    required String ritaseMaterial,
    required String ritaseKategori,
    required String ritaseKeterangan,
    required int kodeUnit,
  }) async {
    try {
      emit(RitaseLoading());
      var meta = await _ritaseService.editRitase(
        ritaseId: ritaseId,
        kodeUnit: kodeUnit,
        ritaseKategori: ritaseKategori,
        ritaseKeterangan: ritaseKeterangan,
        ritaseMaterial: ritaseMaterial,
      );
      emit(RitaseSended(meta));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(RitaseFailed(e.message));
      } else {
        emit(RitaseFailed(e.toString()));
      }
    }
  }

  void deleteRitase({required int ritaseId}) async {
    try {
      emit(RitaseLoading());
      var meta = await _ritaseService.deleteRitase(
        ritaseId: ritaseId,
      );
      emit(RitaseSended(meta));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(RitaseFailed(e.message));
      } else {
        emit(RitaseFailed(e.toString()));
      }
    }
  }
}
