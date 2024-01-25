// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'practise_bloc.dart';

@immutable
abstract class PractiseEvent extends Equatable {}

class RegisteEvent extends PractiseEvent {
  final String name;
  final String lastName;
  final String phone;
  final String password;
  RegisteEvent({
    required this.name,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, lastName, phone, password];
}

class LoginEvent extends PractiseEvent {
  final String name;
  final String password;
  LoginEvent({
    required this.name,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, password];
}

class SendApiAdress extends PractiseEvent {
  final String title;
  final String description;
  final String lat;
  final String long;
  SendApiAdress({
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, lat, long];
}

class SaveLatLongDb extends PractiseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
