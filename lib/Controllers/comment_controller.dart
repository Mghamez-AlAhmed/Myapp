import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:socialmedia/Models/comment_model.dart';
import 'package:socialmedia/core/service_setting.dart';

class createcomments extends GetxController{
  TextEditingController textEditingController=TextEditingController();
  var postList = Commentmodel().obs;
var isloading=false.obs;

  SevicesSetting c=  Get.find();

Future<Commentmodel?> fetchcomments(int id) async {
  isloading.value=true;
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${c.sharedP!.getString("token")}'
  };

  var body = {
    "body": textEditingController.text 
  };

  var url = Uri.parse("https://tarmeezacademy.com/api/v1/posts/$id/comments");
  var response = await http.post(url, body: body, headers: headers);

  if (response.statusCode == 201) {
    var json = jsonDecode(response.body);
    var commentData = json['data'];
    isloading.value=false;
Get.snackbar("succsecful uploaded", "");
    return Commentmodel.fromJson(commentData);
    
  } else {
    // في حالة حدوث خطأ، إظهار رسالة خطأ للمستخدم
    Get.snackbar("Error", "Failed to post comment");
    return null; // إرجاع null إذا فشل نشر التعليق
  }
}















}