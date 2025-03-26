import 'package:bloc_lesson/BlocStateManagmentTemplates/data/UserProvider.dart';

abstract class UserState {}

class InitialState extends UserState {}

class SuccessUserState extends UserState {
  List<User> users;
  SuccessUserState(this.users);
}

class LoadingUserState extends UserState {}

class FailureUserState extends UserState {
  String errorMessage;
  FailureUserState(this.errorMessage);
}

class AddUserLoadingState extends UserState {}

class SuccessAddUserState extends UserState {}

class FloatingButtonClicked extends UserState {}
