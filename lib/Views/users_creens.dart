import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/Controllers/user_controller.dart';

class UserScreens extends StatefulWidget {
  const UserScreens({super.key});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  final controller = Get.put(usercontroller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff4267B2), // Facebook blue color
        title: const Text(
          'Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isloding.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.userlist.length,
            itemBuilder: (context, index) {
              final user = controller.userlist[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12.0),
                  leading: CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.network(
                        user.profileImage,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  title: Text(
                    "${user.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    "${user.email}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "${user.id}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
