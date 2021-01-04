import 'package:facebookui/components/post_react_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PostCardCommentView extends StatefulWidget {
  PostCardCommentView({Key key}) : super(key: key);

  @override
  _PostCardCommentViewState createState() => _PostCardCommentViewState();
}

class _PostCardCommentViewState extends State<PostCardCommentView> {
  Size popupBtnSize;

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey),
    );

    return Column(
      children: [
        // header for post comment view like actions

        AppBar(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          leading: BackButton(
            color: Colors.black,
          ),
          actions: [
            // like button for the post
            Builder(builder: (context) {
              double validDX = popupBtnSize != null ? popupBtnSize.width : 0;
              return PostReactPopupButton(
                context: context,
                onlyIcon: true,
                translatePopup: Offset(-validDX * 4.25, 27.0),
                onPopupStateChange: (context) {
                  if (popupBtnSize == null) {
                    setState(() {
                      popupBtnSize = context.size;
                    });
                  }
                },
                onReactionChange: (status, popupState) {},
              );
            }),
          ],
          title: Text(
            "Fokunni, What the hell & 1.3k other",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 5),
        // comment list_view
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CardCommentItems(),
            ),
          ),
        ),
        // input or text_field for commenting inside
        Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(LineAwesomeIcons.camera),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(LineAwesomeIcons.smiling_face),
                onPressed: () {},
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      border: inputBorder,
                      fillColor: Colors.grey[200],
                      focusedBorder: inputBorder,
                      errorBorder: inputBorder,
                      focusedErrorBorder: inputBorder,
                      hintText: "Write a reply",
                    ),
                    showCursor: true,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(LineAwesomeIcons.paper_plane),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}

class CardCommentItems extends StatefulWidget {
  CardCommentItems({Key key}) : super(key: key);

  @override
  _CardCommentItemsState createState() => _CardCommentItemsState();
}

class _CardCommentItemsState extends State<CardCommentItems> {
  @override
  Widget build(BuildContext context) {
    TextStyle subtitle3 =
        TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold);

    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage("https://randomuser.me/api/portraits/women/67.jpg"),
      ),
      title: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // username
            Text(
              "Username",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            // comment
            Text(
                "Some random f comment without any reason. Don't know why angular sucks but flutter rocks. Weird, nah?")
          ],
        ),
      ),
      subtitle: Material(
        type: MaterialType.transparency,
        child: Row(
          children: [
            SizedBox(width: 8.0),
            // time ago
            Text(
              "1 hour ago",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(width: 8.0),
            // like button
            PostReactPopupButton(
              context: context,
              compact: true,
              translatePopup: Offset(30.0, 0.0),
              onlyText: true,
              onReactionChange: (status, popupState) {},
            ),
            SizedBox(width: 8.0),
            // reply button
            InkWell(
              child: Text(
                "Reply",
                style: subtitle3,
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
