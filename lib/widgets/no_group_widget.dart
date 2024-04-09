import 'package:flutter/material.dart';
import 'package:gossip_letest/widgets/popup_dialog.dart';

Widget noGroupWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            popUpDialog(context);
          },
          child: Icon(
            Icons.add_circle,
            color: Colors.grey[700],
            size: 75,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
