import 'package:facebookui/components/post_card/post_card_comment_view.dart';
import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
import 'package:facebookui/components/post_react_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CardActions extends StatefulWidget {
  final void Function(ReactionStatus status, ReactionPopup popupStatus)
      onPostReactPopupStatusChange;
  const CardActions({
    Key key,
    @required this.onPostReactPopupStatusChange,
  }) : super(key: key);
  static const icon_size = 18.0;

  @override
  _CardActionsState createState() => _CardActionsState();
}

class _CardActionsState extends State<CardActions> {
  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              )),
          height: MediaQuery.of(context).size.height * 98 / 100, //98%
          child: PostCardCommentView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardActionColor = Colors.transparent;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // like
          PostReactPopupButton(
            context: context,
            onReactionChange: widget.onPostReactPopupStatusChange,
          ),
          // comment
          CardActionButton(
            color: cardActionColor,
            borderRadius: 0.0,
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.alternate_comment,
                  size: CardActions.icon_size,
                ),
                SizedBox(width: 5),
                Text("Comment")
              ],
            ),
            onPressed: () {
              _showCommentSheet(context);
            },
          ),
          // share
          CardActionButton(
            color: cardActionColor,
            borderRadius: 0.0,
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.share_square,
                  size: CardActions.icon_size,
                ),
                SizedBox(width: 5),
                Text("Share")
              ],
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
  final VoidCallback onLongPress;
  final Color color;
  final Color textColor;
  final double borderRadius;
  const CardActionButton(
      {Key key,
      this.child,
      this.onPressed,
      this.onLongPress,
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
      onLongPress: onLongPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20)),
          side: BorderSide(color: Colors.transparent)),
    );
  }
}
