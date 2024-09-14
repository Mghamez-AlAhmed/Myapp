import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/Controllers/delete_post_controller.dart';
import 'package:socialmedia/Controllers/home_controller.dart';
import 'package:socialmedia/Controllers/show_post_controller.dart';
import 'package:socialmedia/Controllers/signup_login_controller.dart';
import 'package:socialmedia/Models/post_model.dart';
import 'package:socialmedia/Views/create_post.dart';
import 'package:socialmedia/Views/my_profile.dart';
import 'package:socialmedia/Views/start_app.dart';
import 'package:socialmedia/Views/users_creens.dart';
import 'package:socialmedia/core/service_setting.dart';

// ignore: must_be_immutable
class PostsScreen extends StatelessWidget {
  final homecontroller ontroller = Get.put(homecontroller());
  
  final Controoller = Get.put(ShowPostController());
  final Contrller = Get.put(signup_login());

  SevicesSetting c = Get.find();
  final deletepostcontroler= Get.put(DeletePost());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff4267B2),
          title: const Text(
            'ArabMedia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home_filled)),
              Tab(icon: Icon(Icons.person_outline)),
              Tab(icon: Icon(Icons.group)),
              Tab(icon: Icon(Icons.notifications_none)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
               
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            c.sharedP!.clear();
                            Get.to(() => StartApp());
                          },
                          icon: const Icon(Icons.logout_outlined)),
                      const SizedBox(width: 8),
                      const Text("Logout"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff4267B2),
          onPressed: () {
            Get.to(() => PostView());
          },
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            _buildHomeTab(),
            UserProfileScreen(),
            const UserScreens(),
            _buildNotificationsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return GetX<homecontroller>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchPosts();
            },
            child: ListView.builder(
              itemCount: controller.postList.length,
              itemBuilder: (context, index) {
                final post = controller.postList[index];
                return _buildPostCard(post);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildPostCard(Postvi post) {
    return InkWell(
      onTap: () {
        var iid = post.id;
        Controoller.Getposte(iid);
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.black26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(post),
            if (post.body.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  post.body,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            if (post.image != null && post.image!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  post.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: progress.expectedTotalBytes != null
                                    ? progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            _buildPostFooter(post),

          ],
        ),
      ),
    );
  }

 Widget _buildPostHeader(Postvi post) {
  final currentUserId = Contrller.user.value.id; 

  return ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundImage: post.pofeliimage != null && post.pofeliimage!.isNotEmpty
          ? NetworkImage(post.pofeliimage!)
          : const AssetImage("images/Screenshot (267).png") as ImageProvider,
    ),
    title: Text(
      post.authorName,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      post.createdat,
      style: TextStyle(color: Colors.grey[600]),
    ),
    trailing: post.idd == currentUserId 
        ? IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              deletepostcontroler.deletePost(post.id); 
            },
          )
        : null, 
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}


  Widget _buildPostFooter(Postvi post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.thumb_up_alt_outlined,
              color: Colors.grey[600],
            ),
            onPressed: () {},
          ),
          Text(
            '${post.commentsCount}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: Icon(
              Icons.comment_outlined,
              color: Colors.grey[600],
            ),
            onPressed: () {},
          ),
          Text(
            '${post.commentsCount}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              var iid = post.id;
              Controoller.Getposte(iid);
            },
            icon: const Icon(Icons.add_comment, color: Color(0xff4267B2)),
            label: const Text(
              "Comment",
              style: TextStyle(color: Color(0xff4267B2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return const Center(
      child: Text(
        'No notifications yet',
        style: TextStyle(color: Colors.white70, fontSize: 18),
      ),
    );
  }
}
