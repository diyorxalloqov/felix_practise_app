part of 'practise_bloc.dart';

@immutable
class PractiseState extends Equatable {
  final String registerMessage;
  final bool isLoggedin;
  final String error;
  final ActionStatus status;
  final String latitude;
  final String longtitude;

  const PractiseState({
    this.isLoggedin = false,
    this.registerMessage = '',
    this.error = '',
    this.latitude = '',
    this.longtitude = '',
    this.status = ActionStatus.initial,
  });

  PractiseState copyWith(
      {String? registerMessage,
      bool? isLoggedin,
      ActionStatus? status,
      String? error,
      String? latitude,
      String? longtitude,
      int? currentIndex}) {
    return PractiseState(
        error: error ?? this.error,
        isLoggedin: isLoggedin ?? this.isLoggedin,
        registerMessage: registerMessage ?? this.registerMessage,
        status: status ?? this.status,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, error, registerMessage, isLoggedin, latitude, longtitude];
}
