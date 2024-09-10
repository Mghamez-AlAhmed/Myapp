import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:socialmedia/Models/user_model.dart';

class usercontroller extends GetxController{

  @override
  void onInit() {
    fetchuser();
    super.onInit();
  }
var  userlist=<UsersModel>[].obs;
var isloding=true.obs;
Future<void>fetchuser()async{
  isloding.value=true;
var url=Uri.parse("https://tarmeezacademy.com/api/v1/users");

var response= await http.get(url,);
if(response.statusCode==200){
var jsonbody= jsonDecode(response.body);
      var user = jsonbody['data'] as List;
      userlist.value = user.map((post) => UsersModel.fromJson(post)).toList();
      isloding.value=false;

}





}

}