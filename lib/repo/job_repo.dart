import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:khmerjob_project/models/job_model.dart';

// when connect with real device must use the same network

const IOSimulator = "localhost";
const AndroidEmulator = "10.0.2.2";
const LivePhone = "190.168.8.101"; // dak ip address computer yg but this is is a sample ip address of teacher
// cmd -> ipconfig -> ipv4 = 192.168.8.113
Future<Job> getJobsData() async{
  String address = AndroidEmulator;
  String url = "http://$address/php/khmer_job_app/read_latestjob.php";
  http.Response response = await http.get(url);

  if(response.statusCode == 200){
    return compute(jobFromMap, response.body);
  }else{
    throw Exception("Error while reading: ${response.statusCode}");
  }
}

Future<Job> getJobByCategory(String cate) async{
  String address = AndroidEmulator;
  String url = "http://$address/php/khmer_job_app/read_job_category.php";
  http.Response response = await http.post(url,body: {'brphet':cate});

  if(response.statusCode == 200){
    return compute(jobFromMap, response.body);
  }else{
    throw Exception("Error while reading: ${response.statusCode}");
  }
}


Future<Job> getJobDetail(String id) async{
  String address = AndroidEmulator;
  String url = "http://$address/php/khmer_job_app/read_job_detail.php";
  http.Response response = await http.post(url,body: {'ID':id});

  if(response.statusCode == 200){
    return compute(jobFromMap, response.body);
  }else{
    throw Exception("Error while reading: ${response.statusCode}");
  }
}

// Future<ProductData> getProductData() async{
//   String url = "http://10.0.2.2/php/psha_khmer/read_product.php";
//   http.Response response = await http.get(url);
//   if (response.statusCode == 200){
//     return compute(productDataFromMap, response.body);
//   } else {
//     throw Exception("Error while reading: ${response.statusCode}");
//   }
// }