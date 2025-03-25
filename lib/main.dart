import 'package:bloc_lesson/BlocStateManagmentTemplates/UI/UserUIScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocStateManagmentTemplates/bloc/user_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///
      ///STEP ((1))  => ADD BLOC provider
      ///
      home: BlocProvider(
        create: (context) => UserBloc(),
        child: MyBlocPage(),
      ),
    );
  }
}
