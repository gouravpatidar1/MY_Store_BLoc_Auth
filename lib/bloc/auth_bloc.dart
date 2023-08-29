import 'package:bloc/bloc.dart';
import 'package:my_store/bloc/auth_event.dart';
import 'package:my_store/bloc/auth_state.dart';
import 'package:http/http.dart'as http;

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc(): super(Initialstate()){

    on<LoginEvent>((event, emit) async {
      try{
        emit(loadingstate());
        var result = await loginCall(
          event.loginEmail,event.loginPassword
        );
        if(result != null && result !=""){
          emit(LogInsuccessstate());
        }else{
          emit(Errorstate());
        }
      }catch(e){
        emit(Errorstate());
      }
    },);

    on<RegisterUseEvent>((event, emit) async{
      try {
          emit(loadingstate());
        var result = await registerCall(
            event.emailValue, event.passwordValue);
        if (result != null && result != "") {
          print("Registration successfull");
          emit(Registrationsuccessstate());
        } else {
          emit(Errorstate());
        }
      } catch (e) {
        emit(Errorstate());
      }
    });
  }

  Future registerCall(email, password) async{
  if(email.isNotEmpty && password.isNotEmpty){
      var response = await http.post(Uri.parse("https://reqres.in/api/register"),
      body :({
        'email': email,
        'password':password
      }));
      if(response.statusCode==200){
        return response.body;
      }
  }
  }

  Future loginCall(email, password) async{
  if(email.isNotEmpty && password.isNotEmpty){
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
      body :({
        'email': email,
        'password':password
      }));
      if(response.statusCode==200){
        return response.body;
      }
  }
      
} 

}