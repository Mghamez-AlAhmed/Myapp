import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socialmedia/services/sevices_setting.dart';

class AuthMiddleware extends GetMiddleware {
  SevicesSetting c=  Get.find();

  @override
  RouteSettings? redirect(String? route) {
    print("AuthMiddleware executed");
    final token = c.sharedP!.getString('token');
    print("Token in middleware: ");

    if (token != null) {
      print("${token}00000000000000000000000000000000000000000000");
      return const RouteSettings(name: '/home');
      
    }

    return null;
  }
}