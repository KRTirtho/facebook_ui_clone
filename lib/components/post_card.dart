import 'package:flutter/material.dart';

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

class CardHeader extends StatelessWidget {
  const CardHeader({Key key}) : super(key: key);

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
                Text(new DateTime.now().toString(),
                    style: TextStyle(fontSize: 12))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              print("I need more...");
            },
          )
        ],
      ),
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
              child: Icon(Icons.thumb_up,
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
              Icons.comment_rounded,
              size: CardActions.icon_size,
            ),
            onPressed: () {
              print("Let me comment");
            },
          ),
          // share
          CardActionButton(
            child: Icon(
              Icons.share_rounded,
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
  const CardActionButton({Key key, this.child, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      color: Colors.grey[200],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: Colors.transparent)),
    );
  }
}
