import 'package:flutter/material.dart';
import 'package:ebook_ui/constant/app_colors.dart' as AppColors;
import 'dart:convert';

import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
    late ScrollController _scrollController;
   late TabController _tabController;

  List? popularBooks;
  ReadData() async {
    DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(Icons.notifications),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: -50,
                        right: 0,
                        child: Container(
                          height: 180,
                          child: PageView.builder(
                              itemCount: popularBooks == null
                                  ? 0
                                  : popularBooks!.length,
                              controller: PageController(viewportFraction: 0.8),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  height: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              popularBooks![index]["img"]))),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                    )
                  ];
                },
                body: Text("hii"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
