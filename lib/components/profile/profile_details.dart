import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // add to story button & options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // add to story
              Expanded(
                child: TextButton.icon(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Add to story",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15.0))),
                ),
              ),
              // options
              Material(
                child: IconButton(
                  icon: Icon(LineAwesomeIcons.horizontal_ellipsis),
                  //TODO: there would be a new menu about user-self
                  onPressed: () {},
                ),
              )
            ],
          ),
          Divider(),
          // featured images
          DetailsText(
            icon: LineAwesomeIcons.birthday_cake,
            text: "Born on",
            boldText: "February 29, 1998",
          ),
          DetailsText(
            icon: LineAwesomeIcons.location_arrow,
            text: "Lives in",
            boldText: "Noakhali Division, Noakhali Country",
          ),
          DetailsText(
            icon: LineAwesomeIcons.heartbeat,
            text: "Followed by",
            boldText: "259 people",
          ),
          DetailsText(
            icon: LineAwesomeIcons.horizontal_ellipsis,
            text: "See your About info",
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                constraints: BoxConstraints(maxWidth: 80),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network("https://i.imgur.com/QCNbOAo.png"),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Edit your public info button
          Row(
            children: [
              Expanded(
                child: SplashedButton(
                  text: "Edit public info",
                  fontColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SplashedButton extends StatelessWidget {
  final String text;
  final Color fontColor;
  final VoidCallback onPress;
  const SplashedButton({
    @required this.text,
    this.onPress,
    this.fontColor = Colors.blue,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(color: fontColor),
      ),
      onPressed: onPress ?? () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          fontColor.withOpacity(0.2),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}

/// Widget for displaying the profile page details text
/// which is by default rich text
class DetailsText extends StatelessWidget {
  final IconData icon;
  final String text;
  final String boldText;

  const DetailsText({
    @required this.icon,
    @required this.text,
    Key key,
    this.boldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(children: [
      Icon(icon),
      SizedBox(width: 10),
      Flexible(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(text: "$text ", style: textTheme.bodyText1),
            if (boldText != null) ...[
              TextSpan(
                text: boldText,
                style: TextStyle(
                  fontSize: textTheme.bodyText1.fontSize,
                  fontWeight: FontWeight.bold,
                  color: textTheme.bodyText1.color,
                  decoration: TextDecoration.none,
                ),
              )
            ],
          ]),
        ),
      )
    ]);
  }
}
