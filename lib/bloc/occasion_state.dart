import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OccasionState extends Equatable {
  const OccasionState();
}

class InitialOccasionState extends OccasionState {
  @override
  List<Object> get props => [];
}

class LoadingDataState extends OccasionState {
  @override
  List<Object> get props => [];
}

class DataLoadedState extends OccasionState {
  final Map data;

  DataLoadedState({@required this.data});
  @override
  List<Object> get props => [data];
}

class ErrorState extends OccasionState {
  @override
  List<Object> get props => [];
}
