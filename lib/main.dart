import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialmedia/Views/home_scrrens.dart';
import 'package:socialmedia/Views/start_app.dart';
import 'package:socialmedia/core/authmiddleware.dart';
import 'package:socialmedia/core/service_setting.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await initialservices();
  runApp(const MyApp());
}
Future initialservices()async{

await Get.putAsync(()=>SevicesSetting().init());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.blue)),
        initialRoute: "/startapp",
        getPages: [
          GetPage(
            name: "/home",
            page: () => PostsScreen(),
          ),
          GetPage(
              name: "/startapp",
              page: () => StartApp(),
              middlewares: [AuthMiddleware()]),

        ]);
  }
}
