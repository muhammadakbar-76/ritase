import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ritase/db/unit_db_operation.dart';
import 'package:ritase/services/unit_service.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitInitial());

  final UnitService _unitService = UnitService();

  final UnitDBOperation _unitDBOperation = UnitDBOperation();

  void getUnits() async {
    try {
      emit(UnitLoading());
      var units = await _unitService.getUnits();
      await _unitDBOperation.deleteAllUnits();
      await _unitDBOperation.insertUnits(units);
      emit(UnitSuccess(units));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(UnitFailed(e.message));
      } else {
        emit(UnitFailed(e.toString()));
      }
    }
  }
}
