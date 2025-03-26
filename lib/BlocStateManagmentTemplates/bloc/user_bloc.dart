import 'dart:async';
import 'dart:developer';

import 'package:bloc_lesson/BlocStateManagmentTemplates/data/UserProvider.dart';
import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialState()) {
    on<GetUserEvent>(_getUserList);
    on<AddUserEvent>(_addUser);
    on<TriggerFloatingButton>(_handleFloatingButtonClick);
  }

  FutureOr<void> _getUserList(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());
    await Future.delayed(Duration(seconds: 3));
    try {
      List<User> users = await ApiProvider().getUsers();
      emit(SuccessUserState(users));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  FutureOr<void> _addUser(AddUserEvent event, Emitter<UserState> emit) async {
    try {
      log(event.gender ?? "unknown");
      await ApiProvider().postUser(
          name: event.name!, gender: event.gender!, email: event.email!);
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> _handleFloatingButtonClick(
      TriggerFloatingButton event, Emitter<UserState> emit) {
    emit(FloatingButtonClicked());
  }
}
