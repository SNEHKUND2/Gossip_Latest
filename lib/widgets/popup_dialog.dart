import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gossip_letest/service/database_service.dart';
import 'package:gossip_letest/widgets/widgets.dart';

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({Key? key}) : super(key: key);

  @override
  _CreateGroupDialogState createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  String groupName = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Create a group",
        textAlign: TextAlign.left,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : TextField(
                  onChanged: (val) {
                    setState(() {
                      groupName = val;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text("CANCEL"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (groupName != "") {
              setState(() {
                _isLoading = true;
              });
              DatabaseService(
                uid: FirebaseAuth.instance.currentUser!.uid,
              )
                  .createGroup(
                groupName,
                FirebaseAuth.instance.currentUser!.uid,
                groupName,
              )
                  .whenComplete(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
              showSnackbar(
                context,
                Colors.green,
                "Group created successfully.",
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text("CREATE"),
        ),
      ],
    );
  }
}

void popUpDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return CreateGroupDialog();
    },
  );
}
