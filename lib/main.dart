import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovent_test/UI/home.dart';
import 'package:innovent_test/UI/start.dart';
import 'package:innovent_test/Utils/theme.dart';
import 'package:innovent_test/bloc/login_bloc.dart';
import 'package:innovent_test/repositories/authentication_repository.dart';

void main() {
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const MyApp({Key? key, required this.authenticationRepository})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            LoginBloc(authenticationRepository: authenticationRepository),
        child: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: appTheme,
      builder: (context, child) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            _navigator.pushAndRemoveUntil<void>(
                MyHomePage().route(), (route) => false);
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => StartPage().route(),
    );
  }
}
