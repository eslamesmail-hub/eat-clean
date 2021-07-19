import 'package:animate_do/animate_do.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/orders_provider/orders.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:falafel/screen/home/orderspage/one_order_detail_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var getOrderData = Provider.of<OrderProvider>(context, listen: false);
    getOrderData.callAPIForAllOrders();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            width: size.width/10,
            child: Image.asset(
              'assets/images/Image 1.png',
              fit: BoxFit.contain,
            ),
          ),
          Spacer(),
          IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.primary,
              ),
              onPressed: () {
               
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }),
        ],
      ),
      body: SafeArea(
        child: Consumer<OrderProvider>(builder: (ctx, orderProvider, _) {
          return orderProvider.getOrderData == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : orderProvider.counter == 0
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff47B751).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset('assets/images/bell.png'),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            AppText(
                              text: 'لا يوجد اوردرات مطلوبة',
                              color: AppColors.primary,
                              fontSize: 3.9,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInLeft(
                                  child: SvgPicture.asset(
                                    'assets/icons/food-delivery.svg',
                                    width: getSizeText(4.5),
                                    height: getSizeText(4.9),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(5),
                                ),
                                Icon(
                                  Icons.logout,
                                  size: getSizeText(4.9),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                                AppText(
                                  text: 'الحي الثالث 6 اكتوبر',
                                  color: AppColors.primary,
                                  fontSize: 3.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(100)),
                            FadeInUp(
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primary),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: getProportionateScreenHeight(50),
                                  child: AppText(
                                    text: "اكتشف العروض",
                                    fontSize: 3.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orderProvider.list.data.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: OrderDetails(
                                    id: getOrderData.list.data[index].orderCode
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'غير مقيم ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: AppColors.primary,
                                            size: getSizeText(5),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'كود الطلب : ' +
                                                getOrderData
                                                    .list.data[index].orderCode
                                                    .toString(),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            getOrderData.list.data[index].date
                                                .toString().toLowerCase(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.check_circle_sharp,
                                        size: getSizeText(6),
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      });
        }),
      ),
    );
  }
}
