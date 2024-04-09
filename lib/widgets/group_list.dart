import 'package:flutter/material.dart';
import 'package:gossip_letest/widgets/group_tile.dart';
import 'package:gossip_letest/widgets/no_group_widget.dart';

String getId(String res) {
  return res.substring(0, res.indexOf("_"));
}

String getName(String res) {
  return res.substring(res.indexOf("_") + 1);
}

Widget groupList(Stream groups, BuildContext context, String userName) {
  return StreamBuilder(
    stream: groups,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data['groups'] != null) {
          if (snapshot.data['groups'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['groups'].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data['groups'].length - index - 1;
                return GroupTile(
                  groupId: getId(snapshot.data['groups'][reverseIndex]),
                  groupName: getName(snapshot.data['groups'][reverseIndex]),
                  userName: snapshot.data['fullName'],
                );
              },
            );
          } else {
            return noGroupWidget(context);
          }
        } else {
          return noGroupWidget(context);
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }
    },
  );
}
