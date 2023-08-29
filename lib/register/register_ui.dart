import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_store/bloc/auth_event.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../home/home.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  AuthBloc bloc = AuthBloc();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void register() async {
    bloc.add(RegisterUseEvent(
      emailValue: emailController.text,
      passwordValue: passwordController.text,
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
            if(state is Registrationsuccessstate){
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
            child: SingleChildScrollView(child: registerUI()),
          ),
        ),
      ),
    );
  }

  Column registerUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        const Text(
          "Register",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
         SizedBox(
          height: 50.h,
        ),
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              )),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              )),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
              labelText: "Email Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              )),
        ),
         SizedBox(
          height: 20.h,
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
          height: 50.h,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              register();
            },
            style: const ButtonStyle(
              padding:
                  MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 18)),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.deepPurpleAccent),
            ),
            child: Text("Register"),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 15.h,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
