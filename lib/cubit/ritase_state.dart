part of 'ritase_cubit.dart';

abstract class RitaseState extends Equatable {
  const RitaseState();

  @override
  List<Object> get props => [];
}

class RitaseInitial extends RitaseState {}

class RitaseSuccess extends RitaseState {
  const RitaseSuccess(this.ritases);

  final List<dynamic> ritases;

  @override
  List<Object> get props => [ritases];
}

class RitaseLoading extends RitaseState {}

class RitaseFailed extends RitaseState {
  const RitaseFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class RitaseSended extends RitaseState {
  const RitaseSended(this.meta);

  final Map<String, dynamic> meta;

  @override
  List<Object> get props => [meta];
}
