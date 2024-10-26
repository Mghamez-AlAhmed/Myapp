import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:socialmedia/core/service_setting.dart';


class CreatePost extends GetxController {
  SevicesSetting c=  Get.find();

  var myImage = Rx<File?>(null);
  var bodyTextController = ''.obs;
   var isLoading = false.obs;
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

 Future<void> uploaded() async {
  try {
    isLoading.value = true;

    if (myImage.value != null) {
     var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${c.sharedP!.getString("token")}'
    };


      var request = http.MultipartRequest(
        'POST', 
        Uri.parse("https://tarmeezacademy.com/api/v1/posts")
      );

      request.fields['body'] = bodyTextController.value;
      request.files.add(
        await http.MultipartFile.fromPath('image', myImage.value!.path)
      );
      request.headers.addAll(headers);

      var response = await request.send();
      

      if (response.statusCode == 201) {

        Get.back(result: true);

        Get.snackbar("Success", "Post uploaded successfully");

      } else {
        Get.snackbar("Error", "Failed to upload post. Please try again.");
      }
    } else {
      Get.snackbar("Error", "No image selected");
    }
  } catch (e) {
    Get.snackbar("Error", "An error occurred: ${e.toString()}");
  } finally {
    isLoading.value = false;
  }
}

}
