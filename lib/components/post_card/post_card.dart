import 'package:facebookui/components/post_card/card_actions.dart';
import 'package:facebookui/components/post_card/card_body.dart';
import 'package:facebookui/components/post_card/card_header.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

class PostCard extends StatefulWidget {
  final String userAvatarUrl;
  final String username;
  final DateTime date;
  final String description;
  final String media;
  final int reactCount;
  final int commentCount;
  const PostCard({
    Key key,
    @required this.date,
    @required this.description,
    @required this.userAvatarUrl,
    @required this.username,
    @required this.reactCount,
    @required this.commentCount,
    this.media,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  int reactCount;
  int commentCount;

  @override
  void initState() {
    super.initState();
    reactCount = widget.reactCount;
    commentCount = widget.commentCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 700),
      child: Card(
        elevation: 0,
        borderOnForeground: true,
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            // react popup
            CardHeader(
              date: widget.date,
              userAvatarUrl: widget.userAvatarUrl,
              username: widget.username,
            ),
            CardBody(
              description: widget.description,
              media: widget.media,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // react count
                  Text(Numeral(reactCount).value()),
                  // comment count
                  Text(Numeral(commentCount).value() + " comments")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Divider(
                color: Colors.black,
                thickness: 0.1,
              ),
            ),
            CardActions(
                // gets called after reactionStatus change
                onPostReactPopupStatusChange: (status, prevStatus) {
              setState(() {
                if (prevStatus != null && status == null) {
                  reactCount--;
                } else if (prevStatus == null && status != null) {
                  reactCount++;
                }
              });
            }),
          ],
        ),
      ),
    );
  }
}
