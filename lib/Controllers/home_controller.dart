import 'dart:convert';

import 'package:get/get.dart';
import 'package:socialmedia/Models/post_model.dart';
import 'package:http/http.dart' as http;


class homecontroller extends GetxController{
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPosts();
  }

  var postList = <Postvi>[].obs;
   var isLoading = true.obs;

Future<void> fetchPosts() async {
    var response = await http
        .get(Uri.parse('https://tarmeezacademy.com/api/v1/posts?limit=200'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var posts = jsonData['data'] as List;
      postList.value = posts.map((post) => Postvi.fromJson(post)).toList();
      
    } else {
      Get.snackbar('Error', 'Failed to fetch posts');
    }

    isLoading.value = false;
  }





}