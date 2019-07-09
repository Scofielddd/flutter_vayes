import 'package:flutter/material.dart';
import 'package:flutter_vayes/pages/forget_password_page.dart';
import 'package:flutter_vayes/pages/register_page.dart';
import './pages/home_page.dart';
import './pages/login/login_page.dart';
import './pages/test_page.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/data/user/user_repository.dart';

import 'package:flutter_vayes/authentication/authentication.dart';
import 'package:flutter_vayes/pages/splash_page.dart';
import 'package:flutter_vayes/pages/login/login.dart';
import 'package:flutter_vayes/pages/home_page.dart';
import 'package:flutter_vayes/pages/loading_indicator.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..dispatch(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}



class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  final routes = <String, WidgetBuilder>{
    //LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    TestPage.tag: (context) => TestPage(),
  };

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vayes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
        fontFamily: 'Nunito',
      ),
      home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
      routes: routes,
    );
  }
}
