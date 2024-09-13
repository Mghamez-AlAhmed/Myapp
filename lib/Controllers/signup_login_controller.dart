import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Models/profaile_model.dart';
import 'package:socialmedia/Views/home_scrrens.dart';
import 'package:socialmedia/Views/login.dart';
import 'package:socialmedia/core/service_setting.dart';


class signup_login extends GetxController {
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
        var request = http.MultipartRequest('POST', Uri.parse("https://tarmeezacademy.com/api/v1/register"));

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
    var url = Uri.parse("https://tarmeezacademy.com/api/v1/login");

    var response = await http.post(url, body: body, headers: headers);
   
    
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var token = json["token"];

      await c.sharedP!.setString("token", token);

      user.value = UserModel.fromJson(json);

      await c.sharedP!.setString('username', user.value.username ?? '');
      await c.sharedP!.setString('name', user.value.name ?? '');
      await c.sharedP!.setString('email', user.value.email ?? '');
      await c.sharedP!.setString('profileImage', user.value.profileImage ?? '');
      await c.sharedP!.setString('id', user.value.id?.toString() ?? '');
      await c.sharedP!.setString('commentsCount', user.value.commentsCount?.toString() ?? '');
      await c.sharedP!.setString('postsCount', user.value.postsCount?.toString() ?? '');

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

  String? username = c.sharedP!.getString('username');
  String? name = c.sharedP!.getString('name');
  String? email =c.sharedP!.getString('email');
  String? profileImage = c.sharedP!.getString('profileImage');
  String? id = c.sharedP!.getString('id');
  String? commentsCount = c.sharedP!.getString('commentsCount');
  String? postsCount = c.sharedP!.getString('postsCount');

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
