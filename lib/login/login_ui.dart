import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/bloc/auth_bloc.dart';
import 'package:my_store/bloc/auth_event.dart';
import 'package:my_store/register/register_ui.dart';

import '../bloc/auth_state.dart';
import '../home/home.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  AuthBloc bloc = AuthBloc();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    bloc.add(LoginEvent(
      loginEmail: emailController.text,
      loginPassword: passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is loadingstate) {
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if(state is LogInsuccessstate){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(title: '',),
                    ));
                }
            if(state is Errorstate){
                 WidgetsBinding.instance.addPostFrameCallback((_) { 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("An Error Occurred"),
                      ),);
                    });
                } 
          },
        child: Container(
          padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
          child: SingleChildScrollView(child: loginUI()),
        ),
      )),
    );
  }

  Column loginUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
        ),
        Text(
          "Login",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 50,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: "Email Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              login();
            },
            style: const ButtonStyle(
              padding:
                  MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18)),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.deepPurpleAccent),
            ),
            child: Text("Login"),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        registerButton()
      ],
    );
  }

  Widget registerButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterUi()));
      },
      child: const Text(
        'Register',
        style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 15,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
