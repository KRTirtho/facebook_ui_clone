import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    var verticalDivider = VerticalDivider(
      thickness: 1,
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      constraints: BoxConstraints(maxWidth: 500),
      padding: EdgeInsets.all(8.0),
      child: Column(
        // inputs
        children: [
          Row(
            children: [
              // user avatar
              CircleAvatar(
                backgroundImage:
                    NetworkImage("https://i.imgur.com/QCNbOAo.png"),
              ),
              SizedBox(width: 5),
              // input like button
              Expanded(
                child: FlatButton(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("What's on your mind?"),
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey[800])),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Divider(),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.video_call, color: Colors.red),
                  label: GreyText("Live"),
                  onPressed: () {},
                ),
                verticalDivider,
                TextButton.icon(
                  icon: Icon(Icons.photo_library, color: Colors.green),
                  label: GreyText("Photo"),
                  onPressed: () {},
                ),
                verticalDivider,
                TextButton.icon(
                  icon: Icon(Icons.location_on, color: Colors.red),
                  label: GreyText("Check In"),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GreyText extends StatelessWidget {
  final String text;
  const GreyText(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.grey[850]));
  }
}
