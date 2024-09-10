import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/Api_Links/api_links.dart';

import 'package:socialmedia/Models/profaile_model.dart';

import 'package:socialmedia/Views/home_scrrens.dart';
import 'package:socialmedia/Views/login.dart';
import 'package:socialmedia/services/sevices_setting.dart';


class fetcController extends GetxController {
  @override
void onInit() {
  super.onInit();
  loadUserData();
}
  
 
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

        request.fields['username'] = usernameController.text;
        request.fields['password'] = passwordController.text;
        request.fields['name'] = nameController.text;
        request.fields['email'] = emailController.text;

        request.files.add(
            await http.MultipartFile.fromPath('image', myImage.value!.path));

        var response = await request.send();

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Enjoy the app");

          var responseBody = await response.stream.bytesToString();
          var json = jsonDecode(responseBody);
          var token=json["token"];
          c.sharedP!.setString("token", token); 

          user.value = UserModel.fromJson(json);

          Get.offAll(() => const Login());
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

  
Future<void> loginrec() async {
  try {
    isLoading.value = true;

    var headers = {'Accept': 'application/json'};
    Map body = {
      "username": usernameController.text,
      "password": passwordController.text,
    };
    var url = Uri.parse(baseUrll);

    var response = await http.post(url, body: body, headers: headers);
   
    
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var token = json["token"];

      await c.sharedP!.setString("token", token);

      user.value = UserModel.fromJson(json);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', user.value.username ?? '');
      await prefs.setString('name', user.value.name ?? '');
      await prefs.setString('email', user.value.email ?? '');
      await prefs.setString('profileImage', user.value.profileImage ?? '');
      await prefs.setString('id', user.value.id?.toString() ?? '');
      await prefs.setString('commentsCount', user.value.commentsCount?.toString() ?? '');
      await prefs.setString('postsCount', user.value.postsCount?.toString() ?? '');

      isLoading.value = false;

      Get.offAll(() => PostsScreen(), );
    } else {
      var json = jsonDecode(response.body);
      var message = json["message"];
      Get.snackbar("Error", message);
    }
  } catch (e) {
    print("Error occurred: $e");
    Get.snackbar("Error", e.toString());
    isLoading.value = false;
  }
}

Future<void> loadUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? username = prefs.getString('username');
  String? name = prefs.getString('name');
  String? email = prefs.getString('email');
  String? profileImage = prefs.getString('profileImage');
  String? id = prefs.getString('id');
  String? commentsCount = prefs.getString('commentsCount');
  String? postsCount = prefs.getString('postsCount');

  if (username != null && name != null && email != null && profileImage != null) {
    user.value = UserModel(
      username: username,
      name: name,
      email: email,
      id: int.tryParse(id ?? ''), 
      profileImage: profileImage,
      commentsCount: int.tryParse(commentsCount ?? ''),
      postsCount: int.tryParse(postsCount ?? ''),
    );
  } else {
    print("No user data found in SharedPreferences");
  }
}


}
