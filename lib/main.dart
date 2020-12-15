import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:facebookui/components/post_card.dart';
import 'package:facebookui/shared/search_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final List<Map<String, IconData>> tabs = [
    {"selected": Icons.home, "unseleceted": Icons.home_outlined},
    {"selected": Icons.group, "unseleceted": Icons.group_outlined},
    {"selected": Icons.movie, "unseleceted": Icons.movie_outlined},
    {"selected": Icons.more_horiz, "unseleceted": Icons.more_horiz_outlined},
  ];
  final List<String> listExample =
      List.generate(20, (index) => "User died for $index");

  int _activeTabIndex;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
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
    return MaterialApp(
      title: 'Facebook',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Facebook',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[600]),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          primary: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((tab) {
              return Tab(
                  icon: Icon(
                      tabs.indexOf(tab) == _activeTabIndex
                          ? tab["selected"]
                          : tab["unseleceted"],
                      color: Colors.blue[600]));
            }).toList(),
            indicatorColor: Colors.transparent,
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate:
                              Search(listExample, listExample.sublist(3, 12)));
                    });
              },
            ),
            IconButton(icon: Icon(Icons.message), onPressed: () {})
          ],
          actionsIconTheme: IconThemeData(color: Colors.grey[800]),
        ),
        body: TabBarView(
          children: [
            // home page/feeds
            SingleChildScrollView(
              child: Builder(builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width, //100%
                  child: Column(
                    children: [
                      PostCard(),
                      PostCard(),
                      PostCard(),
                      PostCard(),
                      PostCard(),
                      PostCard(),
                      PostCard(),
                      PostCard(),
                    ],
                  ),
                );
              }),
            ),
            // group
            Icon(Icons.group_outlined),
            // videos
            Icon(Icons.movie_outlined),
            // more
            Icon(Icons.more_horiz_outlined)
          ],
          controller: _tabController,
        ),
        backgroundColor: Colors.blueGrey[50],
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
