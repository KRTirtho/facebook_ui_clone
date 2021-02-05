import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // add to story button & options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // add to story
              Container(
                constraints: BoxConstraints(maxWidth: double.infinity),
                child: Expanded(
                  child: TextButton.icon(
                    icon: Icon(LineAwesomeIcons.plus_square),
                    label: Text("Add to story"),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
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
          )
        ],
      ),
    );
  }
}
