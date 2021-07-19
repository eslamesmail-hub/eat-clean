import 'package:falafel/helper/size_config.dart';
import 'package:falafel/screen/home/homepage/homePage.dart';
import 'package:falafel/screen/home/productpage/product_screen.dart';

import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CusttomAppBar(
              size: size,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: 'عروض حصرية',
                          color: Colors.black,
                          fontSize: 3.6,
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),

                    ///OfferItems
                    OfferItems(size: size),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),

                    Row(
                      children: [
                        AppText(
                          text: 'العروض',
                          color: Colors.black,
                          fontSize: 3.6,
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Container(
                      height: size.height * 0.5,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (_, int i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 5),
                                            blurRadius: 10,
                                            color: Colors.grey[200])
                                      ]),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: 'وجبة وفراخ قطعتين',
                                              color: Colors.black,
                                              fontSize: 3.2,
                                            ),
                                            AppText(
                                              text: 'Eat & GO',
                                              color: AppColors.primary,
                                              fontSize: 3.2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFECA0A),
                                                  size: getSizeText(3.7),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFECA0A),
                                                  size: getSizeText(3.7),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFECA0A),
                                                  size: getSizeText(3.7),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFECA0A),
                                                  size: getSizeText(3.7),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFECA0A),
                                                  size: getSizeText(3.7),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            AppText(
                                              text: '50 دينار',
                                              color: AppColors.primary,
                                              fontSize: 3.2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'assets/images/chicken-steak-with-lemon-tomato-chili-carrot-white-plate.png',
                                          width: size.width * 0.3,
                                          height: size.height * 0.120,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
