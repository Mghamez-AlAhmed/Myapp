import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/Controllers/comment_controller.dart';
import 'package:socialmedia/Controllers/show_post_controller.dart';
class PostScreen extends StatelessWidget {
  final controller = Get.put(ShowPostController());
  final coontroller = Get.put(createcomments());

  Future<void> _refreshComments() async {
        final post = controller.post.value;

    await controller.Getposte(post.id!);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Obx(() {
        final post = controller.post.value;

        if (post.id == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshComments,  
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      if (post.image != null && post.image!.isNotEmpty)
                        Image.network(post.image!),

                      const SizedBox(height: 16.0),

                      Text(post.title ?? 'No Title', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 16.0),

                      Text(post.body ?? 'No Content'),

                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          if (post.author?.profileImage != null && post.author!.profileImage!.isNotEmpty)
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(post.author!.profileImage!),
                            )
                          else
                            const CircleAvatar(
                              radius: 40,
                              child: Icon(Icons.person),
                            ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.author?.name ?? 'Unknown', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('@${post.author?.username ?? 'Unknown'}', style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16.0),

                      if (post.tags != null && post.tags!.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          children: post.tags!.map((tag) => Chip(label: Text("${tag.name}"))).toList(),
                        ),

                      const SizedBox(height: 16.0),

                      Text('${post.commentsCount} Comments', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 16.0),

                      if (post.comments != null && post.comments!.isNotEmpty)
                        ...post.comments!.map((comment) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: comment.author?.profileImage != null &&
                                        comment.author!.profileImage!.isNotEmpty
                                    ? NetworkImage(comment.author!.profileImage!)
                                    : null,
                                child: comment.author?.profileImage == null || comment.author!.profileImage!.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(comment.author?.name ?? 'Unknown'),
                              subtitle: Text(comment.body ?? ''),
                            )),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: coontroller.textEditingController, 
                        // onChanged: (value) => coontroller.bodyTextController.value = value,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () async {
                        coontroller.isloading.value=true;
                        await coontroller.fetchcomments(post.id!);
                        await _refreshComments();
                        coontroller.textEditingController.clear();
                        coontroller.isloading.value=false;

                      },
                      child: Obx(() => coontroller.isloading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ))
                                  : const Icon(Icons.send)),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
