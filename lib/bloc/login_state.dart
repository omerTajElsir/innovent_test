part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;

  const LoginState({
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [this.status];

  LoginState copyWith({FormzStatus? status}) {
    return LoginState(status: status ?? this.status);
  }
}

class LoginInitial extends LoginState {}
