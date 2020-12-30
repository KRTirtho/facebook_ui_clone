import 'package:facebookui/fixed_components/root_view.dart';
import 'package:facebookui/shared/search_delegate.dart';
import 'package:facebookui/shared/sliver_persistent_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainCollapsingToolbarBody extends StatefulWidget {
  MainCollapsingToolbarBody({Key key}) : super(key: key);

  @override
  _MainCollapsingToolbarBodyState createState() =>
      _MainCollapsingToolbarBodyState();
}

class _MainCollapsingToolbarBodyState extends State<MainCollapsingToolbarBody>
    with TickerProviderStateMixin<MainCollapsingToolbarBody> {
  final List<Map<String, IconData>> tabs = [
    {"selected": Icons.home, "unseleceted": LineAwesomeIcons.home},
    {"selected": Icons.group, "unseleceted": LineAwesomeIcons.user_friends},
    {"selected": Icons.movie, "unseleceted": Icons.movie_outlined},
    {"selected": Icons.notifications, "unseleceted": LineAwesomeIcons.bell},
    {"selected": LineAwesomeIcons.bars, "unseleceted": LineAwesomeIcons.bars}
  ];

  final List<String> listExample =
      List.generate(20, (index) => "User died for $index");

  TabController _tabController;
  AnimationController _animationController;

  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
    _activeTabIndex = _tabController.index;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..forward();
    _tabController.addListener(() {
      setState(() {
        _activeTabIndex = _tabController.index;
      });
      if (_activeTabIndex != 0) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return SliverAppBar(
                  toolbarHeight: _animationController.value * 40,
                  floating: true,
                  snap: true,
                  elevation: 0,
                  backgroundColor: Theme.of(context).backgroundColor,
                  actionsIconTheme:
                      IconThemeData(color: Theme.of(context).iconTheme.color),
                  title: Text('facebook',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600])),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: Search(
                                  listExample, listExample.sublist(3, 12)));
                        }),
                    IconButton(icon: Icon(Icons.message), onPressed: () {})
                  ],
                );
              },
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPersistentTabBar(TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  controller: _tabController,
                  tabs: tabs.map((tab) {
                    bool isActiveTab = tabs.indexOf(tab) == _activeTabIndex;
                    return Tab(
                      icon: Icon(
                        isActiveTab ? tab["selected"] : tab["unseleceted"],
                        color:
                            isActiveTab ? Colors.blue[600] : Colors.grey[600],
                      ),
                    );
                  }).toList())),
            )
          ];
        },
        body: RootView(tabController: _tabController),
      ),
    );
  }
}
