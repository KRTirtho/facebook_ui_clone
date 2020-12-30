import 'package:facebookui/components/post_card/post_card_comment_view.dart';
import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
import 'package:facebookui/helper_functions/toIndexLetterUppercase.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CardActions extends StatefulWidget {
  final VoidCallback onLikeButtonLongPressed;
  final VoidCallback onLikeButtonPressed;
  final ReactionStatus reactionStatus;
  const CardActions(
      {Key key,
      @required this.onLikeButtonLongPressed,
      this.reactionStatus,
      this.onLikeButtonPressed})
      : super(key: key);
  static const icon_size = 18.0;

  @override
  _CardActionsState createState() => _CardActionsState();
}

class _CardActionsState extends State<CardActions> {
  @protected
  String decideLikeButtonIcon(ReactionStatus status) {
    switch (status) {
      case ReactionStatus.care:
        return FBReactIcon.care;
      case ReactionStatus.wow:
        return FBReactIcon.wow;
      case ReactionStatus.haha:
        return FBReactIcon.haha;
      case ReactionStatus.sad:
        return FBReactIcon.sad;
      case ReactionStatus.angry:
        return FBReactIcon.angry;
      default:
        return FBReactIcon.love;
    }
  }

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
    double imgDims = 20;
    bool isLikedOnly = widget.reactionStatus == ReactionStatus.like;
    bool postNotReacted = widget.reactionStatus == null;
    Color reactionColor = widget.reactionStatus == ReactionStatus.like
        ? Colors.blue[600]
        : widget.reactionStatus == ReactionStatus.love
            ? Colors.red
            : postNotReacted
                ? Colors.black
                : Colors.yellow[800];
    Color cardActionColor = Colors.transparent;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // like
          CardActionButton(
            color: cardActionColor,
            borderRadius: 0.0,
            child: Row(
              children: [
                isLikedOnly || postNotReacted
                    ? Icon(
                        isLikedOnly
                            ? Icons.thumb_up_alt
                            : LineAwesomeIcons.thumbs_up,
                        color: isLikedOnly
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).iconTheme.color)
                    : Image(
                        height: imgDims,
                        width: imgDims,
                        image: AssetImage(
                            decideLikeButtonIcon(widget.reactionStatus)),
                      ),
                SizedBox(width: 5),
                Text(
                  widget.reactionStatus != null
                      ? toIndexLetterUppercase(
                          widget.reactionStatus.toString().split(".")[1], 0)
                      : "Like",
                  style: TextStyle(
                      color: reactionColor,
                      fontWeight: postNotReacted ? null : FontWeight.bold),
                )
              ],
            ),
            onPressed: widget.onLikeButtonPressed,
            onLongPress: widget.onLikeButtonLongPressed,
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
