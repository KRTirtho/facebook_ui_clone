import 'package:facebookui/components/post_card/card_actions.dart';
import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
import 'package:facebookui/helper_functions/toIndexLetterUppercase.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PostReactPopupButton extends StatefulWidget {
  final Offset translatePopup;
  final BuildContext context;
  final void Function(ReactionStatus status, ReactionPopup popupState)
      onReactionChange;
  PostReactPopupButton(
      {@required this.onReactionChange,
      @required this.context,
      Key key,
      this.translatePopup})
      : super(key: key);

  @override
  _PostReactPopupButtonState createState() => _PostReactPopupButtonState();
}

class _PostReactPopupButtonState extends State<PostReactPopupButton>
    with TickerProviderStateMixin<PostReactPopupButton> {
  ReactionStatus _reactionStatus;
  OverlayState overlayState;
  ReactionPopup _reactionPopupOverlay;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;
  Animation _reactionPopupAnimation;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _animationController.dispose();
    _reactionPopupAnimation.removeListener(animateOverlayEntry);
    super.dispose();
  }

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

  /// Creates a facebook post reaction overlay/popup
  OverlayEntry _createPostReactionOverlayEntry() {
    RenderBox renderBox = widget.context.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    if (widget.translatePopup != null) {
      offset =
          offset.translate(widget.translatePopup.dx, widget.translatePopup.dy);
    }

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // for backdrop or for closing the _reactionPopup on click outside
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
                onChanged: () {
                  widget.onReactionChange(
                      _reactionStatus, _reactionPopupOverlay);
                  _dismissOverlayEntry();
                },
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
    overlayState.setState(() {});
  }

  ///this method dismisses the overlay also setting the open state false
  void _dismissOverlayEntry() {
    _animationController.reverse().whenComplete(() {
      setState(() {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
          _overlayEntry = null;
        }
        _reactionPopupOverlay = ReactionPopup.close;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLikedOnly = _reactionStatus == ReactionStatus.like;
    bool postNotReacted = _reactionStatus == null;
    double imgDims = 20;
    Color reactionColor = _reactionStatus == ReactionStatus.like
        ? Colors.blue[600]
        : _reactionStatus == ReactionStatus.love
            ? Colors.red
            : postNotReacted
                ? Colors.black
                : Colors.yellow[800];

    return CardActionButton(
      color: Colors.transparent,
      borderRadius: 0.0,
      child: Row(
        children: [
          isLikedOnly || postNotReacted
              ? Icon(
                  isLikedOnly ? Icons.thumb_up_alt : LineAwesomeIcons.thumbs_up,
                  color: isLikedOnly
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color)
              : Image(
                  height: imgDims,
                  width: imgDims,
                  image: AssetImage(decideLikeButtonIcon(_reactionStatus)),
                ),
          SizedBox(width: 5),
          Text(
            _reactionStatus != null
                ? toIndexLetterUppercase(
                    _reactionStatus.toString().split(".")[1], 0)
                : "Like",
            style: TextStyle(
                color: reactionColor,
                fontWeight: postNotReacted ? null : FontWeight.bold),
          )
        ],
      ),
      onPressed: () {
        setState(() {
          _reactionStatus =
              isLikedOnly || !postNotReacted ? null : ReactionStatus.like;
        });
        widget.onReactionChange(_reactionStatus, _reactionPopupOverlay);
      },
      onLongPress: () {
        if (_reactionPopupOverlay == ReactionPopup.open) {
          _dismissOverlayEntry();
        } else {
          _showOverlayEntry();
        }
      },
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
