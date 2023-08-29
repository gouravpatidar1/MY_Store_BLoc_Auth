import 'package:http/http.dart' as http;
import 'package:my_store/home/user_model.dart';

class UserRepository {
  final http.Client client;
  UserRepository(this.client);

  Future<User> getUser() async {
    try{  
      final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(response.body);
    } 
    }
    catch(e){
      print(e);
    }
    throw Exception('Some Error Occurred');
  }
} 