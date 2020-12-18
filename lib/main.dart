import 'package:facebookui/components/friends_requests.dart';
import 'package:facebookui/components/new_post.dart';
import 'package:facebookui/components/notifications.dart';
import 'package:flutter/material.dart';
import 'package:facebookui/components/post_card.dart';
import 'package:facebookui/shared/search_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '=acebook',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MainCollapsingToolbarBody(),
        backgroundColor: Colors.blueGrey[300],
      ),
      theme: ThemeData(
        accentColor: Colors.blue[600],
        accentIconTheme: IconThemeData(size: 13, color: Colors.grey[800]),
        accentTextTheme: TextTheme(),
        appBarTheme: AppBarTheme(),
        backgroundColor: Colors.white,
        buttonColor: Colors.grey[200],
        primaryColor: Colors.blue[600],
      ),
    );
  }
}

class MainCollapsingToolbarBody extends StatefulWidget {
  MainCollapsingToolbarBody({Key key}) : super(key: key);

  @override
  _MainCollapsingToolbarBodyState createState() =>
      _MainCollapsingToolbarBodyState();
}

class _MainCollapsingToolbarBodyState extends State<MainCollapsingToolbarBody>
    with SingleTickerProviderStateMixin {
  final List<Map<String, IconData>> tabs = [
    {"selected": Icons.home, "unseleceted": Icons.home_outlined},
    {"selected": Icons.group, "unseleceted": Icons.group_outlined},
    {"selected": Icons.movie, "unseleceted": Icons.movie_outlined},
    {
      "selected": Icons.notifications,
      "unseleceted": Icons.notifications_outlined
    },
    {"selected": Icons.more_horiz, "unseleceted": Icons.more_horiz_outlined}
  ];

  final List<String> listExample =
      List.generate(20, (index) => "User died for $index");

  TabController _tabController;

  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
    _activeTabIndex = _tabController.index;
    _tabController.addListener(() {
      setState(() {
        _activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            toolbarHeight: _activeTabIndex == 0 ? kToolbarHeight : 0.0,
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            actionsIconTheme:
                IconThemeData(color: Theme.of(context).iconTheme.color),
            title: Text('facebook',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue[600])),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate:
                            Search(listExample, listExample.sublist(3, 12)));
                  }),
              IconButton(icon: Icon(Icons.message), onPressed: () {})
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentTabBar(TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                controller: _tabController,
                tabs: tabs.map((tab) {
                  return Tab(
                      icon: Icon(
                          tabs.indexOf(tab) == _activeTabIndex
                              ? tab["selected"]
                              : tab["unseleceted"],
                          color: Colors.blue[600]));
                }).toList())),
          )
        ];
      },
      body: RootView(tabController: _tabController),
    );
  }
}

class SliverPersistentTabBar extends SliverPersistentHeaderDelegate {
  SliverPersistentTabBar(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2.0,
      child: Container(
        child: _tabBar,
        color: Theme.of(context).backgroundColor,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class RootView extends StatelessWidget {
  const RootView({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // home page/feeds
        SingleChildScrollView(
          child: Builder(builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width, //100%
              child: Column(children: [
                NewPost(),
                ...List.generate(20, (index) => PostCard())
              ]),
            );
          }),
        ),
        // friend requests
        SingleChildScrollView(
          child: Builder(builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width, //100%
              child: Column(
                  children: List.generate(20, (index) => FriendRequests())),
            );
          }),
        ),
        // videos
        Icon(Icons.movie_outlined),
        // notifications
        Notifications(),
        // more
        Icon(Icons.more_horiz_outlined)
      ],
      controller: _tabController,
    );
  }
}
