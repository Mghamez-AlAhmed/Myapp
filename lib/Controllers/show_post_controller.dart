 import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socialmedia/Models/show_posts_model.dart';
import 'package:socialmedia/Views/show_post.dart';
class ShowPostController extends GetxController{
  var post = Post().obs;




 
  Future<void> Getposte(int id) async {
    var request = http.Request('GET', Uri.parse("https://tarmeezacademy.com/api/v1/posts/$id"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      Map<String, dynamic> jsonbody = await jsonDecode(json);
      Map<String, dynamic> jsondata = jsonbody["data"];
      post.value = Post.fromJson(jsondata);

      Get.to(() => PostScreen());
    } 
    else{
Get.snackbar("Erorr", "");

    }
  }

}