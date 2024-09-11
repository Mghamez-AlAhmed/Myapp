import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/Controllers/signup_login_controller.dart';
import '../widget/textformfiled.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({super.key});

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final controller = Get.put(signup_login());
  XFile? myfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff4267B2), 
                  Color(0xff3b5998), 
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello\nSign UP!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => controller.pickImage(),
                          child: Obx(() {
                            return controller.myImage.value == null
                                ? CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Colors.grey[300],
                                    child: ClipOval(
                                      child: Image.asset(
                                        "images/Screenshot (269).png",
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 45,
                                    backgroundColor: Colors.grey[300],
                                    child: ClipOval(
                                      child: Image.file(
                                        controller.myImage.value!,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  );
                          }),
                        ),
                        const SizedBox(height: 20),
                        custextfiled(
                          hintText: "Username",
                          controller: controller.usernameController,
                        ),
                        custextfiled(
                          hintText: "Password",
                          controller: controller.passwordController,
                        ),
                        custextfiled(
                          hintText: "Name",
                          controller: controller.nameController,
                        ),
                        custextfiled(
                          hintText: "Email",
                          controller: controller.emailController,
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                               Color(0xff4267B2), 
                  Color(0xff3b5998),
                              ],
                            ),
                          ),
                          child: Center(
                            child: MaterialButton(
                              onPressed: () async {
                                controller.isLoading.value = true; 
                                await controller.registerUserWithImage();
                                controller.isLoading.value = false; 
                              },
                              child: Obx(() => controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
