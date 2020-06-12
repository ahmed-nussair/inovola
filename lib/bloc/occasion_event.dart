import 'package:equatable/equatable.dart';

abstract class OccasionEvent extends Equatable {
  const OccasionEvent();
}

class LoadingDataEvent extends OccasionEvent {
  @override
  List<Object> get props => [];
}
