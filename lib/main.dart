
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/bloc/bloc.dart';

import 'ui/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OccasionBloc() .. add(LoadingDataEvent()),
      child: BlocBuilder<OccasionBloc, OccasionState>(
        builder: (context, state){
          return SafeArea(
            child: Scaffold(
              body: state is LoadingDataState? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              )
              : state is DataLoadedState?
                Home(data: state.props[0])
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}



