import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gossip_letest/pages/chat_page.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!.docs;
          List<Widget> userWidgets = [];
          for (var user in users) {
            final userData = user.data() as Map<String, dynamic>;
            final username = userData['fullName'] ?? '';
            final email = userData['email'] ?? '';
            final profilePictureUrl = userData['profilePictureUrl'];

            final userWidget = Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListTile(
                leading: profilePictureUrl != null
                    ? Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, // Adjust the color of the border
                            width: 2, // Adjust the width of the border
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(profilePictureUrl),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, // Adjust the color of the border
                            width: 2, // Adjust the width of the border
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                title: Text(
                  username,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(email),
                onTap: () {
                  // Navigate to chat page with this user
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        userId: auth.currentUser!
                            .uid, // Assuming you have current user ID
                        recipientId: user.id, // ID of the selected user
                      ),
                    ),
                  );
                },
              ),
            );
            userWidgets.add(userWidget);
          }
          return ListView(
            children: userWidgets,
          );
        },
      ),
    );
  }
}
