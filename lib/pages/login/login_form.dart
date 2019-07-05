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
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
              children: [
                Hero(
                  tag: 'hero',
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 54.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                    padding: EdgeInsets.all(12),
                    color: Colors.lightBlueAccent,
                    child: Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pushNamed(ForgetPasswordPage.tag);
                  },
                ),
                FlatButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pushNamed(RegisterPage.tag);
                  },
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
