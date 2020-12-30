import 'package:facebookui/components/notifications.dart';
import 'package:facebookui/components/post_card/card_actions.dart';
import 'package:flutter/material.dart';

class FriendRequests extends StatelessWidget {
  const FriendRequests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kContainerMaxWidth),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // user avatar
            CircleAvatar(
              maxRadius: 40,
              minRadius: 15,
              backgroundImage: NetworkImage(
                  "https://scontent.fdac5-2.fna.fbcdn.net/v/t1.0-9/129917362_3597237230389498_3924461286604049841_o.jpg?_nc_cat=101&ccb=2&_nc_sid=825194&_nc_ohc=mlw6BxjAcm0AX8mrn3p&_nc_ht=scontent.fdac5-2.fna&oh=ffd5f0c36fcf3ca778e7da70f2dae250&oe=5FFE9AAA"),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // friend name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Text("Fokunni",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        // mutuals
                        Text("15 mutual friends",
                            style: TextStyle(fontSize: 13))
                      ]),
                ),
                Row(
                  children: [
                    // accept button
                    CardActionButton(
                      child: Text("Confirm"),
                      color: Theme.of(context).primaryColor,
                      borderRadius: 5,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    SizedBox(width: 15),
                    // remove button
                    CardActionButton(
                      child: Text("Delete"),
                      borderRadius: 5,
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendRequestViewHeader extends StatelessWidget {
  const FriendRequestViewHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            children: [
              TextSpan(text: "Friend Requests "),
              TextSpan(
                text: "19",
                style: TextStyle(color: Colors.red),
              ),
            ]),
      ),
    );
  }
}
