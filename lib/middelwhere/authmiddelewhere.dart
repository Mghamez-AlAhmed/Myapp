import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:socialmedia/services/sevices_setting.dart';

class AuthMiddleware extends GetMiddleware {
  SevicesSetting c=  Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final token = c.sharedP!.getString('token');

    if (token != null) {
      return const RouteSettings(name: '/home');
      
    }

    return null;
  }
}
