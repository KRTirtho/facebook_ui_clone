import 'package:facebookui/components/post_card/card_actions.dart';
import 'package:facebookui/components/post_card/card_body.dart';
import 'package:facebookui/components/post_card/card_header.dart';
import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
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

  OverlayState overlayState;
  ReactionStatus _reactionStatus;
  ReactionPopup _reactionPopupOverlay;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;
  Animation _reactionPopupAnimation;
  @override
  void initState() {
    super.initState();
    reactCount = widget.reactCount;
    commentCount = widget.commentCount;
    // overlay global state
    overlayState = Overlay.of(context);
    // initializing controller for animation
    _animationController = AnimationController(
        duration: Duration(milliseconds: 250), //demonstration
        vsync: this);
    _reactionPopupAnimation =
        CurvedAnimation(curve: Curves.bounceIn, parent: _animationController);
    _reactionPopupAnimation.addListener(animateOverlayEntry);
  }

  /// Creates a facebook post reaction overlay/popup
  OverlayEntry _createPostReactionOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _dismissOverlayEntry,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height - _reactionPopupAnimation.value * 85.0,
            child: Opacity(
              opacity: _reactionPopupAnimation.value,
              child: PostReactionPopup(
                onChanged: _dismissOverlayEntry,
                setReactionStatus: (status) {
                  setState(() {
                    _reactionStatus = status;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reactionPopupAnimation.removeListener(animateOverlayEntry);
    super.dispose();
  }

  /// this method shows up the reaction overlay
  void _showOverlayEntry() {
    setState(() {
      _overlayEntry = _createPostReactionOverlayEntry();
      overlayState.insert(_overlayEntry);
      _reactionPopupOverlay = ReactionPopup.open;
    });
    _animationController.forward();
  }

  void animateOverlayEntry() {
    overlayState.setState(() {
      print("State Updated inside Overlay ${_reactionPopupAnimation.value}");
    });
  }

  ///this method dismisses the overlay also setting the open state false
  void _dismissOverlayEntry() {
    _animationController.reverse().whenComplete(() {
      setState(() {
        _overlayEntry.remove();
        _overlayEntry = null;
        _reactionPopupOverlay = ReactionPopup.close;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      child: Card(
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
              reactionStatus: _reactionStatus,
              onLikeButtonLongPressed: () {
                if (_reactionPopupOverlay == ReactionPopup.open) {
                  _dismissOverlayEntry();
                } else {
                  _showOverlayEntry();
                }
              },
              onLikeButtonPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class PostReactionPopup extends StatelessWidget {
  final List reactionList = [
    {"icon": AssetImage("assets/fb_like.gif"), "status": ReactionStatus.like},
    {"icon": AssetImage("assets/fb_love.gif"), "status": ReactionStatus.love},
    {"icon": AssetImage("assets/fb_care.gif"), "status": ReactionStatus.care},
    {"icon": AssetImage("assets/fb_haha.gif"), "status": ReactionStatus.haha},
    {"icon": AssetImage("assets/fb_wow.gif"), "status": ReactionStatus.wow},
    {"icon": AssetImage("assets/fb_sad.gif"), "status": ReactionStatus.sad},
    {"icon": AssetImage("assets/fb_angry.gif"), "status": ReactionStatus.angry},
  ];

  final void Function(ReactionStatus status) setReactionStatus;
  final VoidCallback onChanged;

  PostReactionPopup({
    Key key,
    @required this.setReactionStatus,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(blurRadius: 5, spreadRadius: 2, color: Colors.grey[400])
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: Row(
            children: reactionList.map((reaction) {
          double imgDims =
              reaction["status"] == ReactionStatus.care ? 28.0 : 48.0;
          double responsiveImgDims =
              MediaQuery.of(context).size.width < 350 ? imgDims - 15 : imgDims;
          return InkWell(
            // reaction icon buttons
            onTap: () {
              setReactionStatus(reaction["status"]);
              onChanged();
            },
            child: Image(
              height: responsiveImgDims,
              width: responsiveImgDims,
              image: reaction["icon"],
            ),
          );
        }).toList()),
      ),
    );
  }
}
