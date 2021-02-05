import 'package:facebookui/components/profile/profile_cover.dart';
import 'package:facebookui/components/profile/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // top bar with search & back button
            AppBar(
              titleSpacing: 0,
              backgroundColor: Theme.of(context).backgroundColor,
              leading: IconButton(
                icon: Icon(
                  LineAwesomeIcons.arrow_left,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 2.0,
              title: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Search",
                  isDense: true,
                ),
              ),
            ),
            // cover, profile, bio
            ProfileCover(),
            // profile details including (date of birth, joined, add to story)
            ProfileDetails()
          ],
        ),
      ),
    );
  }
}
