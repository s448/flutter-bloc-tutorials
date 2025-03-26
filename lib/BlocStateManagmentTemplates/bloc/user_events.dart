abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  String? name, email, gender;

  AddUserEvent({required this.name, required this.email, required this.gender});
}

class TriggerFloatingButton extends UserEvent {}
