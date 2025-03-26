import 'package:bloc_lesson/BlocStateManagmentTemplates/UI/add_user.dart'
    show AddUserPage;
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
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<UserBloc>(),
                        child: AddUserPage(),
                      ),
                    ),
                  ),
              icon: Icon(Icons.person_add_outlined))
        ],
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is FloatingButtonClicked) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Button clicked")),
            );
          }
        },
        child: buildBloc(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<UserBloc>().add(TriggerFloatingButton()),
        child: Icon(Icons.add),
      ),
    );
  }

  /// STEP 2: BlocBuilder to handle UI updates based on state
  Widget buildBloc() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
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
            onPressed: () => context.read<UserBloc>().add(GetUserEvent()),
            child: Text("Get user list"),
          ),
        );
      },
    );
  }

  /// Build List of Users
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
