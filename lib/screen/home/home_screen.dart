import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:falafel/apis/check_connection.dart';
import 'package:falafel/screen/home/favoritepage/favoritePage.dart';
import 'package:falafel/screen/home/orderspage/orders_screen.dart';
import 'package:falafel/screen/home/profilepage/profilePage.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'homepage/homePage.dart';
import 'offerpage/offerPage.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isCheck = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isCheck = true;
      });
    }
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  int select = 0;
  int currentIndex = 2;
  final List<StatefulWidget> tabs = [
    FavoritePage(),
    OfferPage(),
    HomePage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: isCheck == false
              ? Center(
                  // ignore: deprecated_member_use
                  child: OutlineButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: AppColors.lightGrey,
                      child: Text('لا يوجد اتصال بالانترنت'),
                      onPressed: () {
                        checkConnection();
                      }),
                )
              : CustomNavigationBar(
                  iconSize: size.height * 0.03,
                  selectedColor: AppColors.primary,
                  borderRadius: Radius.circular(15),
                  strokeColor: Color(0x30040307),
                  unSelectedColor: Color(0xffacacac),
                  backgroundColor: AppColors.wight,
                  items: [
                    CustomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        badgeCount: 1,
                        title: AppText(
                          text: "المفضله",
                          fontSize: 3.2,
                          color: AppColors.grey,
                        )),
                    CustomNavigationBarItem(
                        icon: Icon(Icons.local_offer),
                        badgeCount: 2,
                        title: AppText(
                          text: "العروض",
                          fontSize: 3.2,
                          color: AppColors.grey,
                        )),
                    CustomNavigationBarItem(
                        icon: Icon(Icons.home),
                        badgeCount: 3,
                        title: AppText(
                          text: 'الرئيسة',
                          fontSize: 3.2,
                          color: AppColors.grey,
                        )),
                    CustomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket_outlined),
                        badgeCount: 4,
                        title: AppText(
                          text: translator.translate('اوردرات'),
                          fontSize: 3.2,
                          color: AppColors.grey,
                        )),
                    CustomNavigationBarItem(
                        icon: Icon(Icons.perm_identity),
                        badgeCount: 4,
                        title: AppText(
                          text: 'بروفيل',
                          fontSize: 3.2,
                          color: AppColors.grey,
                        )),
                  ],
                  currentIndex: currentIndex,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
        ),
        body: tabs[currentIndex]);
  }
}
