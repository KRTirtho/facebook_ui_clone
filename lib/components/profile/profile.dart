import 'package:facebookui/components/new_post.dart';
import 'package:facebookui/components/post_card/post_card.dart';
import 'package:facebookui/components/profile/profile_cover.dart';
import 'package:facebookui/components/profile/profile_details.dart';
import 'package:facebookui/data/posts.dart';
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
    return Center(
      child: Container(
        color: Colors.grey[350],
        child: Column(
          children: [
            // top bar with search & back button
            AppBar(
              titleSpacing: 0,
              primary: true,
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
              elevation: 0,
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
            Expanded(
              child: Container(
                color: Theme.of(context).backgroundColor,
                constraints: BoxConstraints(maxWidth: 700),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // cover, profile, bio
                        ProfileCover(),
                        // profile details including (date of birth, joined, add to story)
                        ProfileDetails(),
                        Divider(),
                        // heading of the friends detail header
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Friends",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SplashedButton(
                                text: "Find Friends",
                                fontColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(8.0),
                      sliver: SliverGrid.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: List.generate(
                          6,
                          (index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.black.withOpacity(0.2)),
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                              ),
                              child: Image.network(
                                  "https://i.imgur.com/QCNbOAo.png"),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SplashedButton(
                              text: "See All Friends",
                              fontColor: Colors.black,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            color: Colors.grey[350],
                            child: Column(
                              children: List.generate(
                                30,
                                (index) {
                                  if (index == 0) {
                                    return NewPost();
                                  }
                                  return PostCard(
                                    date: DateTime.parse(posts[index]["date"]),
                                    description: posts[index]["description"],
                                    userAvatarUrl: posts[index]
                                        ["userAvatarUrl"],
                                    username: "Firstname Lastname",
                                    media: posts[index]["media"] != null
                                        ? posts[index]["media"][0]["image"]
                                        : null,
                                    reactCount: posts[index]["reacts"],
                                    commentCount: posts[index]["comments"],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
