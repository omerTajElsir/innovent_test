import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:innovent_test/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.shortenLink();
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } on Exception catch (_) {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
