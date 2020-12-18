import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children:
              List.generate(20, (index) => NotificationsContainer()).toList(),
        ),
      ),
    );
  }
}

class NotificationsContainer extends StatefulWidget {
  NotificationsContainer({Key key}) : super(key: key);

  @override
  _NotificationsContainerState createState() => _NotificationsContainerState();
}

class _NotificationsContainerState extends State<NotificationsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 450),
      child: Card(
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://w7.pngwing.com/pngs/536/216/png-transparent-technical-support-computer-icons-user-avatar-avatar-computer-network-child-face.png")),
          title: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: <InlineSpan>[
                  TextSpan(
                      text: "MR. Uradhura ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "commented on your photo")
                ]),
          ),
          subtitle: Text(timeago.format(DateTime.now()
              .subtract(Duration(minutes: 15)))), //shows 15 mins ago
          trailing: IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        ),
      ),
    );
  }
}
