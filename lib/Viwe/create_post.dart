
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/Controllers/create_post_contorller.dart';

// ignore: use_key_in_widget_constructors
class PostView extends StatelessWidget {
  final controller = Get.put(CreatePost());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children:[Column(
            children: [
              TextField(
                onChanged: (value) => controller.bodyTextController.value = value,
                decoration: const InputDecoration(
                  labelText: "Post Body",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Obx(() => controller.myImage.value!= null
                  ? Image.file(controller.myImage.value!)
                  : const Text("No image selected")),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: controller.pickImage,
                child: const Text("Pick Image"),
              ),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.uploaded,
                      child: const Text("Upload Post"),
                    )),
            ],
          ),
          ]
        ),
      ),
    );
  }
}
