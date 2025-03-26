import 'dart:developer';

import 'package:bloc_lesson/BlocStateManagmentTemplates/UI/UserUIScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocStateManagmentTemplates/bloc/user_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(
    BlocProvider(
      create: (context) => UserBloc(),
      child: MyApp(),
    ),
  );
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Bloc: ${bloc.runtimeType}, Change: $change');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBlocPage(),
    );
  }
}
