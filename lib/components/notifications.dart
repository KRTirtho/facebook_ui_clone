import 'dart:math';

import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

const double kContainerMaxWidth = 400;

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(maxWidth: kContainerMaxWidth),
              padding: EdgeInsets.all(8),
              child: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                elevation: 0.0,
                title: Text(
                  "Notifications",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        LineAwesomeIcons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {})
                ],
                titleSpacing: 0.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: NotificationsCategorized(heading: "New"),
          ),
          Align(
            alignment: Alignment.center,
            child: NotificationsCategorized(heading: "Earlier"),
          )
        ],
      ),
    );
  }
}

class NotificationsCategorized extends StatelessWidget {
  final String heading;
  const NotificationsCategorized({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kContainerMaxWidth),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Divider(),
          ...List.generate(
              10,
              (index) => Notification(
                    isActive: Random.secure().nextInt(1000) % 2 == 0,
                  ))
        ],
      ),
    );
  }
}

class Notification extends StatefulWidget {
  final bool isActive;
  Notification({Key key, @required this.isActive}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  List<List> notificationPopupItems = [
    [LineAwesomeIcons.check, "Mark as Read"],
    [LineAwesomeIcons.times_circle, "Remove this notification"],
    [LineAwesomeIcons.skull___crossbones, "Turn off notifications for this"],
    [LineAwesomeIcons.bug, "Report this to Notifications Team"]
  ];

  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _isActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:
          _isActive ? Colors.blue[50] : Theme.of(context).backgroundColor,
      horizontalTitleGap: 3.5,
      contentPadding: EdgeInsets.all(8.0),
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      leading: CircleAvatar(
          maxRadius: 40,
          backgroundImage: NetworkImage("https://i.imgur.com/QCNbOAo.png")),
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
      subtitle: Text(
        timeago.format(
          DateTime.now().subtract(
            Duration(minutes: 15),
          ),
        ),
        style: TextStyle(
            color: _isActive
                ? Colors.blueAccent[400]
                : Theme.of(context).textTheme.subtitle1.color),
      ), //shows 15 mins ago
      trailing: PopupMenuButton(
        icon: Icon(LineAwesomeIcons.horizontal_ellipsis),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPopupRadius)),
        itemBuilder: (context) {
          return notificationPopupItems
              .map((item) => PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          item[0],
                          color: Theme.of(context).accentIconTheme.color,
                        ),
                        SizedBox(width: 5),
                        Flexible(child: Text(item[1]))
                      ],
                    ),
                  ))
              .toList();
        },
      ),
    );
  }
}
