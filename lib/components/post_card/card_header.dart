import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebookui/components/post_card/popup_menu_item_child.dart';
import 'package:facebookui/shared/adaptive_network_image.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'post_card_shared_abstracts.dart';
import 'package:flutter/material.dart';
import "package:timeago/timeago.dart" as timeago;

class CardHeader extends StatefulWidget {
  final String userAvatarUrl;
  final String username;
  final DateTime date;
  CardHeader(
      {Key key,
      @required this.userAvatarUrl,
      @required this.username,
      @required this.date})
      : super(key: key);

  static const List menuItems = [
    {
      "widget": PopupMenuItemChild(
          icon: LineAwesomeIcons.bookmark, title: "Save Post"),
      "value": PostActionValues.save
    },
    {
      "widget": PopupMenuItemChild(
          icon: LineAwesomeIcons.bell_slash,
          title: "Tun on notifications for this post"),
      "value": PostActionValues.turnOnNotifications
    },
    {
      "widget": PopupMenuItemChild(icon: LineAwesomeIcons.code, title: "Embed"),
      "value": PostActionValues.embed
    },
    {
      "widget": PopupMenuItemChild(
          icon: LineAwesomeIcons.times,
          title: "Hide Post",
          subtitle: "See fewer post like this"),
      "value": PostActionValues.hide
    },
    {
      "widget": PopupMenuItemChild(
          icon: LineAwesomeIcons.clock,
          title: "Snooze  KR. Tirtho for 30 days",
          subtitle: "Temporarily stop seeing post"),
      "value": PostActionValues.snooze
    },
    {
      "widget": PopupMenuItemChild(
          icon: LineAwesomeIcons.times_circle,
          title: "Unfollow KR. Tirtho",
          subtitle: "Stop seeing posts but stay friends"),
      "value": PostActionValues.unfollow
    },
    {
      "widget": PopupMenuItemChild(
          icon: Icons.support_agent_outlined,
          title: "Find support or report post ",
          subtitle: "I'm concerned about this post"),
      "value": PostActionValues.support
    },
  ];

  @override
  _CardHeaderState createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  PostActionValues selection;

  void _showConfiguredMoreOptions<PostActionValues>(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0))),
          child: SingleChildScrollView(
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                  children: List.generate(
                CardHeader.menuItems.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selection = CardHeader.menuItems[index]["value"];
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CardHeader.menuItems[index]["widget"],
                    ),
                  );
                },
              )),
            ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // user avatar
          AdaptiveNetworkImage(widget.userAvatarUrl, isAvatar: true),
          // user name & date
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // username
                Text(
                  widget.username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                // date
                Text(timeago.format(widget.date),
                    style: TextStyle(fontSize: 12))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              _showConfiguredMoreOptions(context);
            },
          ),
        ],
      ),
    );
  }
}
