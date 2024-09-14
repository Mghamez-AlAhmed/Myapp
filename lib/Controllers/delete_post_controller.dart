import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socialmedia/core/service_setting.dart';

class DeletePost extends GetxController {
  SevicesSetting c=  Get.find();
  
  Future<void> deletePost(int id) async {
    var headers = {'Accept': 'application/json',
      'Authorization': 'Bearer ${c.sharedP!.getString("token")}'
    
    };
    var request = http.Request(
        'DELETE', Uri.parse('https://tarmeezacademy.com/api/v1/posts/$id'));
    request.body = '''{\n    "body": "hello sdffsdsfds"\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.snackbar("succsesful delete", "");
    } else {
      Get.snackbar("Erorr", "this post is not for you");

    }
  }
}
