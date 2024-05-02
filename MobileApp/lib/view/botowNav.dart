import 'package:agrotech_hackat/constants/colors.dart';
import 'package:agrotech_hackat/view/dashboard.dart';
import 'package:agrotech_hackat/view/farmxAI/farmx_ai.dart';
import 'package:agrotech_hackat/view/product_feed.dart';
import 'package:agrotech_hackat/view/scan.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import 'signup pages/controller.dart';
import 'webview page/webviewpage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // StoreController().getProfile();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> title = ["Home", "Orders", "Store", "Prediction"];

  FirebaseController controller = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerPage(),
      body: SizedBox.expand(
        child: PageView(
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            Dashboard(), Scan(), //Orders(),
            Feed(),
            KnowledgeBase()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: w(13, context),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: black, fontSize: w(12, context)),
        selectedItemColor: black,
        backgroundColor: white,
        unselectedItemColor: grey,
        unselectedFontSize: w(13, context),
        unselectedLabelStyle: TextStyle(color: grey, fontSize: w(12, context)),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/svgs/Home.svg",
                semanticsLabel: 'home',
                color: _currentIndex == 0 ? black : grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Tools',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/svgs/Vector.svg",
                semanticsLabel: 'Product',
                color: _currentIndex == 1 ? black : grey,
              ),
            ),
          ),
          // BottomNavigationBarItem(
          //   label: "Orders",
          //   icon: Padding(
          //     padding: const EdgeInsets.only(bottom: 5),
          //     child: SvgPicture.asset(
          //       "assets/svgs/Vector2.svg",
          //       semanticsLabel: 'order',
          //       color: _currentIndex == 2 ? black : grey,
          //     ),
          //   ),
          // ),
          BottomNavigationBarItem(
            label: 'Store',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                "assets/svgs/Vector1.svg",
                semanticsLabel: 'Product',
                color: _currentIndex == 2 ? black : grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
              label: "FarmxAI",
              icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(
                    Icons.lightbulb,
                    color: _currentIndex == 3 ? black : grey,
                  ))),
        ],
      ),
    );
  }
}
