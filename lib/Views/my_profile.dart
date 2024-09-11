import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/Controllers/signup_login_controller.dart';

class UserProfileScreen extends StatelessWidget {
  final Controller = Get.put(signup_login(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff4267B2), 
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Centering the title gives a balanced look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final user = Controller.user.value;

        

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("${user.profileImage}"),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "${user.username}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Name: ${user.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments: ${user.commentsCount}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Posts: ${user.postsCount}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Token:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
   
}
