// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Api_Links/api_links.dart';

import 'package:socialmedia/Models/profaile_model.dart';

import 'package:socialmedia/Views/home_scrrens.dart';
import 'package:socialmedia/services/sevices_setting.dart';


// ignore: camel_case_types
class fetcController extends GetxController {
  
 
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;
  var user = UserModel().obs;
  

  var myImage = Rx<File?>(null);
  SevicesSetting c=  Get.find();
 
// for image
  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        myImage.value = File(pickedFile.path);
      } else {
        Get.snackbar("Error", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: ${e.toString()}");
    }
  }

//for register
  Future<void> registerUserWithImage() async {
    try {
      if (myImage.value != null) {
        var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

        // Adding form fields
        request.fields['username'] = usernameController.text;
        request.fields['password'] = passwordController.text;
        request.fields['name'] = nameController.text;
        request.fields['email'] = emailController.text;

        // Adding the image file
        request.files.add(
            await http.MultipartFile.fromPath('image', myImage.value!.path));

        // Sending the request
        var response = await request.send();

        // Handling the response
        if (response.statusCode == 200) {
          Get.snackbar("Success", "Enjoy the app");

          var responseBody = await response.stream.bytesToString();
          var json = jsonDecode(responseBody);
          var token=json["token"];
          c.sharedP!.setString("token", token); 

          user.value = UserModel.fromJson(json);

          Get.to(() => PostsScreen());
        } else {
          Get.snackbar("Error", "There are one or more empty fields");
        }
      } else {
        Get.snackbar("Error", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  
  //for login
  Future<void> loginrec() async {
    try {
      isLoading.value=true;
      // ignore: non_constant_identifier_names
      var Headers = {'Accept': 'application/json'};
      Map body = {
        "username": "tooken",
        "password": "tooken1",
      };
      // ignore: non_constant_identifier_names
      var Url = Uri.parse(baseUrll);

      var response = await http.post(Url, body: body, headers: Headers);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var token = json["token"];
      c.  sharedP!.setString("token", "$token");

                user.value = UserModel.fromJson(json);

isLoading.value=false;
        Get.to(()=>PostsScreen(), transition: Transition.leftToRight);

      } else {
        var json = jsonDecode(response.body);
        var message = json["message"];
        Get.snackbar("Erorr", message);
      }
    } catch (e) {
      Get.snackbar("ss", e.toString());
    }
  }
}
