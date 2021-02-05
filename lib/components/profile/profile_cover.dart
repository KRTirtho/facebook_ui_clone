import 'package:facebookui/shared/adaptive_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCover extends StatelessWidget {
  const ProfileCover({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: AdaptiveNetworkImage("https://i.imgur.com/QCNbOAo.png")),
        ),
        // profile pic with username
        Transform.translate(
          offset: Offset(0, -55),
          child: Column(
            children: [
              // profile picture
              CircleAvatar(
                child: Image.network("https://i.imgur.com/QCNbOAo.png"),
                minRadius: 5,
                maxRadius: 50,
              ),
              SizedBox(height: 5),
              // username of profile page
              Text(
                "Firstname Lastname",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        // Bio
        Text(
          "I don't write bio",
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
