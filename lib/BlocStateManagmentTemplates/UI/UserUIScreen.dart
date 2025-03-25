import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_bloc.dart';
import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_events.dart';
import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/UserProvider.dart';

class MyBlocPage extends StatefulWidget {
  MyBlocPage({Key? key}) : super(key: key);

  @override
  State<MyBlocPage> createState() => _MyBlocPageState();
}

class _MyBlocPageState extends State<MyBlocPage> {
  bool change = true;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person_add),
      ),
      body: buildBloc(),
    );
  }

  /**  --------------- Focus Here  ----------------------- **/
  Widget buildBloc() {
    ///
    ///STEP ((2)) => ADD BLOC builder
    ///
    return BlocBuilder<UserBloc, UserState>(builder: (ctx, state) {
      if (state is SuccessUserState) {
        List<User> users = state.users;
        return Center(
          child: buildUserList(users),
        );
      }
      if (state is LoadingUserState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is FailureUserState) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      return Center(
        child: ElevatedButton(
          ///
          ///STEP (( 3 )) =>  ADD the EVENT trigger
          ///
          onPressed: () => ctx.read<UserBloc>().add(GetUserEvent()),
          child: Text("Get user list"),
        ),
      );
    });
  }
  /** 
   --------------- Focus Here  -----------------------
     **/

  Widget buildUserList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text("${users[index].name}"),
          subtitle: Text("${users[index].email}"),
        );
      },
    );
  }
}
