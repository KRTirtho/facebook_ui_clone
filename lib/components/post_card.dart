import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  const PostCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [CardHeader(), CardBody(), CardActions()],
        ),
      ),
      constraints: BoxConstraints(maxWidth: 500),
    );
  }
}

enum PostActionValues {
  save,
  turnOnNotifications,
  hide,
  embed,
  snooze,
  unfollow,
  support
}

class CardHeader extends StatelessWidget {
  CardHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // user avatar
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://scontent.fdac5-2.fna.fbcdn.net/v/t1.0-9/129917362_3597237230389498_3924461286604049841_o.jpg?_nc_cat=101&ccb=2&_nc_sid=825194&_nc_ohc=mlw6BxjAcm0AX8mrn3p&_nc_ht=scontent.fdac5-2.fna&oh=ffd5f0c36fcf3ca778e7da70f2dae250&oe=5FFE9AAA"),
          ),
          // user name & date
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // username
                Text(
                  "KR. Tirtho",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                // date
                Text(
                    timeago.format(
                        new DateTime.now().subtract(Duration(minutes: 15))),
                    style: TextStyle(fontSize: 12))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Spacer(),
          PopupMenuButton<PostActionValues>(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            icon: Icon(Icons.more_horiz),
            offset: Offset(0, 70),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: PopupMenuItemChild(
                        icon: Icons.bookmark_border_outlined,
                        title: "Save Post"),
                    value: PostActionValues.save),
                PopupMenuDivider(),
                PopupMenuItem(
                  child: PopupMenuItemChild(
                      icon: Icons.notifications_none_outlined,
                      title: "Tun on notifications for this post"),
                  value: PostActionValues.turnOnNotifications,
                ),
                PopupMenuItem(
                  child: PopupMenuItemChild(
                      icon: Icons.code_outlined, title: "Embed"),
                  value: PostActionValues.embed,
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  child: PopupMenuItemChild(
                      icon: Icons.close_rounded,
                      title: "Hide Post",
                      subtitle: "See fewer post like this"),
                  value: PostActionValues.hide,
                ),
                PopupMenuItem(
                  child: PopupMenuItemChild(
                      icon: Icons.timelapse_outlined,
                      title: "Snooze  KR. Tirtho for 30 days",
                      subtitle: "Temporarily stop seeing post"),
                  value: PostActionValues.snooze,
                ),
                PopupMenuItem(
                    child: PopupMenuItemChild(
                        icon: Icons.dangerous,
                        title: "Unfollow KR. Tirtho",
                        subtitle: "Stop seeing posts but stay friends"),
                    value: PostActionValues.unfollow),
                PopupMenuItem(
                  child: PopupMenuItemChild(
                      icon: Icons.support_agent_outlined,
                      title: "Find support or report post ",
                      subtitle: "I'm concerned about this post"),
                  value: PostActionValues.support,
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

class PopupMenuItemChild extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const PopupMenuItemChild(
      {Key key, @required this.icon, @required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> textList = [Text(title)];
    if (subtitle != null) {
      textList.add(Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(subtitle,
            style: TextStyle(color: Colors.grey[700], fontSize: 12)),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textList,
          ),
        )
      ],
    );
  }
}

class CardBody extends StatefulWidget {
  CardBody({Key key}) : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  String description =
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime laboriosam velit voluptatem tempora, facere Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime laboriosam velit voluptatem tempora, facere Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime laboriosam velit voluptatem tempora, facere Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime laboriosam velit voluptatem tempora, facere Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime laboriosam velit voluptatem tempora, facere";

  bool isLongDescription = false;

  @override
  void initState() {
    super.initState();
    if (description.length > 100) {
      isLongDescription = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // descriptions text
        TextButton(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  isLongDescription
                      ? description.substring(0, 100)
                      : description,
                  style: TextStyle(color: Colors.black))),
          onPressed: () {
            setState(() {
              isLongDescription = !isLongDescription;
            });
          },
        ),
        // image
        Image(
            image: NetworkImage(
                "https://scontent.fdac5-2.fna.fbcdn.net/v/t1.0-9/129917362_3597237230389498_3924461286604049841_o.jpg?_nc_cat=101&ccb=2&_nc_sid=825194&_nc_ohc=mlw6BxjAcm0AX8mrn3p&_nc_ht=scontent.fdac5-2.fna&oh=ffd5f0c36fcf3ca778e7da70f2dae250&oe=5FFE9AAA"))
      ],
    );
  }
}

class CardActions extends StatefulWidget {
  const CardActions({Key key}) : super(key: key);
  static const icon_size = 18.0;

  @override
  _CardActionsState createState() => _CardActionsState();
}

class _CardActionsState extends State<CardActions> {
  bool isLikedPost = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // like
          CardActionButton(
              child: Icon(
                  isLikedPost ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
                  size: CardActions.icon_size,
                  color: isLikedPost
                      ? Theme.of(context).accentColor
                      : Theme.of(context).iconTheme.color),
              onPressed: () {
                setState(() {
                  isLikedPost = !isLikedPost;
                });
              }),
          // comment
          CardActionButton(
            child: Icon(
              Icons.comment_outlined,
              size: CardActions.icon_size,
            ),
            onPressed: () {
              print("Let me comment");
            },
          ),
          // share
          CardActionButton(
            child: Icon(
              Icons.share_outlined,
              size: CardActions.icon_size,
            ),
            onPressed: () {
              print("Let me share the post...");
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}

class CardActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  const CardActionButton(
      {Key key,
      this.child,
      this.onPressed,
      this.color,
      this.textColor,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      color: color ?? Colors.grey[200],
      textColor: textColor,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20)),
          side: BorderSide(color: Colors.transparent)),
    );
  }
}
