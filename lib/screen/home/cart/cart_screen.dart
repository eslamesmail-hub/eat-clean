import 'package:falafel/apis/check_connection.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/cart_provider/cart.dart';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:falafel/screen/home/orderspage/confirm_order_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var getCartData = Provider.of<CartProvider>(context, listen: false);
    getCartData.callAPIForCart();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        width: size.width * 1,
        height: size.height * 0.3,
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            // ISTOKENEXIST
            //     ? Center(
            //         // ignore: deprecated_member_use
            //         child: RaisedButton(
            //           onPressed: () {
            //             Get.to(LoginScreen());
            //           },
            //           child: Text('يجب تسجيل الدخول اولا'),
            //         ),
            //       )
            //     :
         Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -4),
                          color: Colors.grey[200],
                          blurRadius: 10)
                    ]),
                    child:
                        Consumer<CartProvider>(builder: (ctx, cartProvider, _) {
                      return cartProvider.counter == 0
                          ? Text('')
                          : Column(
                              children: [
                                ListTile(
                                  title: AppText(
                                    text: "المجموع",
                                    color: Colors.black,
                                    fontSize: 3.5,
                                  ),
                                  trailing: Consumer<CartProvider>(
                                      builder: (ctx, cartProvider, _) {
                                    return cartProvider.list.total == 0
                                        ? Text('')
                                        : AppText(
                                            text: getCartData.list.total
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 3.5,
                                          );
                                  }),
                                ),
                              ],
                            );
                    }),
                  ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey[400],
                        blurRadius: 10)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            text: 'اضف اصناف',
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 3.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (getCartData.counter != 0) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ConfirmOrderScreen(),
                              ),
                            );
                          } else {
                            Get.snackbar('خطأ', 'عربتك فارغه ',
                                snackPosition: SnackPosition.TOP);
                          }
                          return null;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: 'تنفيذ الطلب',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 3.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary,
              )),
        ],
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: AppText(
          text: 'سلة المتشريات',
          fontSize: 3.7,
          color: AppColors.primary,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Container(
                height: size.height * 0.60,
                color: Colors.white,
                child: Consumer<CartProvider>(
                  builder: (ctx, cartProvider, _) {
                    return cartProvider.counter == 0
                        ? Center(
                            child: Text(
                              'العربه فارغه',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          )
                        : cartProvider.counter == 0
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: cartProvider.counter,
                                itemBuilder: (_, index) {
                                  return Dismissible(
                                    background: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    key: ValueKey(1),
                                    onDismissed: (value) {
                                      getCartData.cartProperties(
                                        cartProvider.list.data[index].productId
                                            .toString(),
                                        'https://bitna.club/api/remove_cart',
                                      );
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: cartProvider
                                                      .list.data[index].name,
                                                  color: AppColors.primary,
                                                  fontSize: 3.5,
                                                ),
                                                AppText(
                                                  text: 'عادي',
                                                  color: AppColors.primary,
                                                  fontSize: 3.5,
                                                ),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10),
                                                ),
                                                AppText(
                                                  text: cartProvider
                                                      .list.data[index].price,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.6,
                                                ),
                                                Row(
                                                  children: [
                                                    buildInkWell(Icons.add, () {
                                                      {
                                                        getCartData
                                                            .cartProperties(
                                                          cartProvider
                                                              .list
                                                              .data[index]
                                                              .productId
                                                              .toString(),
                                                          'https://bitna.club/api/increase_cart',
                                                        );
                                                      }
                                                    }),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: AppText(
                                                        text: cartProvider
                                                            .list
                                                            .data[index]
                                                            .quantity,
                                                        color: Colors.black,
                                                        fontSize: 3.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    buildInkWell(
                                                        Icons
                                                            .indeterminate_check_box_outlined,
                                                        () {
                                                      {
                                                        getCartData
                                                            .cartProperties(
                                                          cartProvider
                                                              .list
                                                              .data[index]
                                                              .productId
                                                              .toString(),
                                                          'https://bitna.club/api/decrease_cart',
                                                        );
                                                      }
                                                    }),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              height: size.height * 0.12,
                                              width: size.width * 0.3,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  cartProvider
                                                      .list.data[index].image,
                                                  //'assets/images/chicken-steak-with-lemon-tomato-chili-carrot-white-plate.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                  },
                ),
              ),
              SizedBox(
                height: size.height / 50,
                //300
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell(IconData iconData, final onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.primary)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(
            iconData,
            color: AppColors.primary,
            size: getSizeText(3.9),
          ),
        ),
      ),
    );
  }
}
