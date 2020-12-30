import 'package:flutter/material.dart';

class PostReactPopupButton extends StatefulWidget {
  PostReactPopupButton({Key key}) : super(key: key);

  @override
  _PostReactPopupButtonState createState() => _PostReactPopupButtonState();
}

class _PostReactPopupButtonState extends State<PostReactPopupButton>
    with TickerProviderStateMixin<PostReactPopupButton> {
  AnimationController _containerController;

  @override
  void initState() {
    super.initState();
    _containerController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Row iconContainer =
        Row(children: List.generate(5, (index) => Icon(Icons.emoji_nature)));

    return AnimatedBuilder(
      animation: _containerController,
      builder: (context, child) {
        return Stack(children: [
          // pop up menu
          Positioned(
            bottom: 100,
            height: 100,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow()],
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).backgroundColor),
              child: iconContainer,
            ),
          )
        ]);
      },
    );
  }
}
