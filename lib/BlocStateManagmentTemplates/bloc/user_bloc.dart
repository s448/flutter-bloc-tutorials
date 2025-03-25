import 'dart:async';

import 'package:bloc_lesson/BlocStateManagmentTemplates/data/UserProvider.dart';

import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialState()) {
    on<GetUserEvent>(_getUserList);
  }

  FutureOr<void> _getUserList(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());
    Future.delayed(Duration(seconds: 3));
    try {
      List<User> users = await ApiProvider().getUsers();
      emit(SuccessUserState(users));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }
}
