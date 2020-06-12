import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:inovola/data/my_chopper_service.dart';
import './bloc.dart';

class OccasionBloc extends Bloc<OccasionEvent, OccasionState> {
  @override
  OccasionState get initialState => InitialOccasionState();

  @override
  Stream<OccasionState> mapEventToState(
    OccasionEvent event,
  ) async* {
    yield InitialOccasionState();

    if(event is LoadingDataEvent) {
      yield LoadingDataState();
      var response = await MyChopperService.create().getData();

      Map data = json.decode(response.bodyString);

      yield DataLoadedState(data: data);
    }
  }
}
