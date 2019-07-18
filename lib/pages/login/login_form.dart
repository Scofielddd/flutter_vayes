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
              body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    /*Image.asset(
                      'assets/vayes_logo.png',
                      fit: BoxFit.fitWidth,
                      height: 80,
                      width: 250,
                    ),*/
                    Text(
                      'vayes prime',textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 70,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          
                          fontFamily: ("Playlines"),
                          color: Color(0xff1b76b9)),
                    ),
                    SizedBox(height: 16.0),
                    
                  ],
                ),
                SizedBox(height: 60.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                    filled: true,
                    labelText: 'Şifre',
                  ),
                  obscureText: true,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('KAYIT OL'),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      child: Text('İLERİ'),
                      onPressed:
                          state is! LoginLoading ? _onLoginButtonPressed : null,
                    ),
                  ],
                ),
                Center(
                  child: Text("Şifremi Unuttum!",
                      style:
                          new TextStyle(fontSize: 13.0, color: Colors.black)),
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
