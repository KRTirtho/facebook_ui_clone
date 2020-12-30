import 'package:facebookui/components/friends_requests.dart';
import 'package:facebookui/components/new_post.dart';
import 'package:facebookui/components/notifications.dart';
import 'package:facebookui/components/post_card/post_card.dart';
import 'package:facebookui/data/posts.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RootView extends StatefulWidget {
  RootView({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  static const pageSize = 5;
  PagingController _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPosts(pageKey);
      print("Paginated: $pageKey");
    });
  }

  Future<void> _fetchPosts(int pageKey) async {
    try {
      final newItems = await Future.delayed(Duration(milliseconds: 2005), () {
        List<Map> items = posts.sublist(pageKey, pageSize + pageKey);
        return items;
      });
      if (newItems.length < pageSize) {
        _pagingController.appendLastPage(newItems);
      }
      final nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // home page/feeds
        PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              if (index == 0) {
                return Align(
                  child: NewPost(),
                  alignment: Alignment.center,
                );
              }
              return Align(
                child: PostCard(
                  date: DateTime.parse(posts[index]["date"]),
                  description: posts[index]["description"],
                  userAvatarUrl: posts[index]["userAvatarUrl"],
                  username: posts[index]["username"],
                  media: posts[index]["media"] != null
                      ? posts[index]["media"][0]["image"]
                      : null,
                  reactCount: posts[index]["reacts"],
                  commentCount: posts[index]["comments"],
                ),
                alignment: Alignment.center,
              );
            },
          ),
        ),
        // friend requests
        Container(
          color: Theme.of(context).backgroundColor,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FriendRequestViewHeader();
              }
              return Align(
                  alignment: Alignment.center, child: FriendRequests());
            },
          ),
        ),
        // videos
        Icon(Icons.movie_outlined),
        // notifications
        NotificationsView(),
        // more
        Icon(Icons.more_horiz_outlined)
      ],
      controller: widget._tabController,
    );
  }
}
