import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:khmerjob_project/models/user_model.dart';

const IOSimulator = "localhost";
const AndroidEmulator = "10.0.2.2";
const LivePhone = "190.168.8.101"; // dak ip address computer yg


Future<User> getUser(String email, String password)async{
  String address = AndroidEmulator;
  String url = "http://$address/php/khmer_job_app/read_user.php";
  http.Response response = await http.post(url, body:{'email': email, 'password': password});
  if(response.statusCode == 200){
    return compute(userFromMap, response.body);
  }else{
    throw Exception("Error while reading: ${response.statusCode}");
  }
}
Future<String> storeUser(UserElement user) async {
  String address = AndroidEmulator;
  String url = "http://$address/php/khmer_job_app/add_user.php";
  http.Response response = await http.post(url, body: user.toMap());
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Error while reading: ${response.statusCode}");
  }
}