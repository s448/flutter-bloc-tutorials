import 'package:bloc_lesson/BlocStateManagmentTemplates/UI/UserUIScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocStateManagmentTemplates/bloc/user_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(),
      child: MyApp(),
    ),
  );
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
