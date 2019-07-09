import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/login/login.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: new IconThemeData(color: Color(0xFF18D191)),
            ),
            body: Container(
              width: double.infinity,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    child: Image.asset('assets/vayes_logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0.0),
                          child: new TextField(
                            controller: _usernameController,
                            decoration: new InputDecoration(labelText: 'Email'),
                          ),
                        ),
                        new SizedBox(
                          width: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0.0),
                          child: new TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration:
                                new InputDecoration(labelText: 'Password'),
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: state is! LoginLoading ? _onLoginButtonPressed : null,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 5.0, top: 10.0),
                                  child: new Container(
                                    alignment: Alignment.center,
                                    height: 45.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                    ),
                                    child: new Text(
                                      "Login",
                                      style: new TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 20.0, top: 10.0),
                                child: new Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  child: new Text("Forgot Password?",
                                      style: new TextStyle(
                                          fontSize: 17.0, color: Colors.blue)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13.0),
                          child: new Text("Create A New Account ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
