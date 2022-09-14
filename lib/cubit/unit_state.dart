part of 'unit_cubit.dart';

abstract class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object> get props => [];
}

class UnitInitial extends UnitState {}

class UnitSuccess extends UnitState {
  const UnitSuccess(this.units);

  final List<dynamic> units;

  @override
  List<Object> get props => [units];
}

class UnitLoading extends UnitState {}

class UnitFailed extends UnitState {
  const UnitFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
