import 'package:facebookui/components/profile/profile.dart';
import 'package:facebookui/shared/adaptive_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

List menuListItems = [
  ["leading icon placeholder", "Covid-19 Information Center"],
  ["leading icon placeholder", "Groups"],
  ["leading icon placeholder", "Videos on Watch"],
  ["leading icon placeholder", "Friends"],
  ["leading icon placeholder", "Marketplace"],
  ["leading icon placeholder", "Events"],
  ["leading icon placeholder", "Memories"],
  ["leading icon placeholder", "Saved"],
  ["leading icon placeholder", "Pages"],
  ["leading icon placeholder", "Nearby Friends"],
  ["leading icon placeholder", "Jobs"],
  ["leading icon placeholder", "Gaming"],
  ["leading icon placeholder", "Find Friends"],
];

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      constraints: BoxConstraints(maxWidth: 400.0),
      child: Material(
        type: MaterialType.transparency,
        child: ListView(
          children: [
            // Title Menu AppBar
            AppBar(
              primary: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actionsIconTheme: Theme.of(context).iconTheme,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
              title: Text(
                "Menu",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Divider(),
            // go to profile tile
            ListTile(
              leading: AdaptiveNetworkImage(
                "https://i.imgur.com/QCNbOAo.png",
                isAvatar: true,
              ),
              dense: true,
              enabled: true,
              title: Text(
                "Firstname Lastname",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              // for moving to another account
              trailing: AdaptiveNetworkImage(
                "https://i.imgur.com/QCNbOAo.png",
                isAvatar: true,
                maxWidth: 10,
              ),
              // this should push the user to his profile page
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
            Divider(),
            // the ListTiles for all the basic options
            ...menuListItems
                .map((e) => MenuListTile(
                    leadingIcon: e[0],
                    bodyText: e[1],
                    onTap: () {
                      print("MenuListItem on go");
                    }))
                .toList(),
            // see more expansion
            ExpansionTile(
              title: Text(
                "See More",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              leading: Icon(LineAwesomeIcons.boxes),
              children: [
                MenuListTile(
                  leadingIcon: "",
                  bodyText: "See many more",
                  onTap: () {},
                ),
                MenuListTile(
                  leadingIcon: "",
                  bodyText: "See many more",
                  onTap: () {},
                ),
                MenuListTile(
                  leadingIcon: "",
                  bodyText: "See many more",
                  onTap: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuListTile extends StatelessWidget {
  final leadingIcon;
  final String bodyText;
  final VoidCallback onTap;
  const MenuListTile(
      {Key key,
      @required this.leadingIcon,
      @required this.bodyText,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[350],
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
      margin: EdgeInsets.all(10.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            horizontalTitleGap: 2,
            leading: Icon(LineAwesomeIcons.ad),
            title: Text(bodyText,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
