import 'package:facebookui/components/post_card/post_card_shared_abstracts.dart';
import 'package:facebookui/helper_functions/toIndexLetterUppercase.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

const double kReactionPopupMediaMinWidth = 370;

class PostReactPopupButton extends StatefulWidget {
  ///don't use `onlyIcon` & `onlyText` together
  final bool onlyIcon;

  ///don't use `onlyIcon` & `onlyText` together
  final bool onlyText;
  final bool compact;
  final Offset translatePopup;
  final BuildContext context;

  /// this one gets callbacked before inserting the `PostReactionPopup` to
  /// `Overlay.of(context)` & after removing from the `Overlay.of(context)`
  ///  also inside `postFrameCallBack` in `initState`. `context` is the same
  /// passed as named parameter in this widget
  final void Function(BuildContext context) onPopupStateChange;
  final void Function(ReactionStatus status, ReactionStatus prevStatus)
      onReactionChange;
  PostReactPopupButton(
      {@required this.onReactionChange,
      @required this.context,
      Key key,
      this.onPopupStateChange,
      this.translatePopup,
      this.onlyIcon = false,
      this.onlyText = false,
      this.compact = false})
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
    // post frame for the parent widget
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// avoiding null value as often this can cause Exception if the prop
      /// wasn't passed yet
      if (widget.onPopupStateChange != null) {
        widget.onPopupStateChange(widget.context);
      }
    });
    super.initState();

    /// for preventing false rendering by stopping usage of both [onlyText] & [onlyIcon] together
    if (widget.onlyIcon && widget.onlyText) {
      throw ArgumentError(["Used both onlyIcon & onlyText together"]);
    }
    // overlay global state
    overlayState = Overlay.of(context);
    // initializing controller for animation
    _animationController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
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
                onChanged: _dismissOverlayEntry,
                setReactionStatus: (status) {
                  widget.onReactionChange(status, _reactionStatus);
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
    if (widget.onPopupStateChange != null) {
      widget.onPopupStateChange(widget.context);
    }
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
    if (widget.onPopupStateChange != null) {
      widget.onPopupStateChange(widget.context);
    }
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

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: widget.onlyIcon
                ? BorderRadius.circular(50.0)
                : BorderRadius.zero)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          widget.compact ? EdgeInsets.zero : EdgeInsets.all(10.0),
        ),
      ),
      child: Row(
        children: [
          if (!widget.onlyText) ...[
            if (isLikedOnly || postNotReacted)
              Icon(
                  isLikedOnly ? Icons.thumb_up_alt : LineAwesomeIcons.thumbs_up,
                  color: isLikedOnly
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color)
            else
              Image(
                height: imgDims,
                width: imgDims,
                image: AssetImage(decideLikeButtonIcon(_reactionStatus)),
              )
          ],
          if (!widget.onlyIcon) ...[
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
          ]
        ],
      ),
      onPressed: () {
        ReactionStatus newReactionStatus =
            isLikedOnly || !postNotReacted ? null : ReactionStatus.like;

        widget.onReactionChange(newReactionStatus, _reactionStatus);
        setState(() {
          _reactionStatus = newReactionStatus;
        });
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
              MediaQuery.of(context).size.width < kReactionPopupMediaMinWidth
                  ? imgDims - 7
                  : imgDims;
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
