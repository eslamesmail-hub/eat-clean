import 'package:falafel/components/default_button.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/orders_provider/one_order.dart';
import 'package:falafel/provider/orders_provider/orders.dart';
import 'package:falafel/provider/rate_provider/rate.dart';
import 'package:falafel/screen/home/productpage/product_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  String id;

  OrderDetails({this.id});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  double s;

  @override
  Widget build(BuildContext context) {
    var getAllOrders = Provider.of<OrderProvider>(context, listen: false);
    var getOneOrderDetails =
        Provider.of<GetOneOrderProvider>(context, listen: false);
    getOneOrderDetails.callAPIForGetOneOrderData(widget.id);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultButton(
            colors: AppColors.primary,
            text: 'الغاء الاوردر',
            textcolor: AppColors.cardColor,
            press: () {
              // ignore: deprecated_member_use
              Widget cancelButton = FlatButton(
                child: Text("نعم", style: TextStyle(color: AppColors.primary)),
                onPressed: () {
                  getAllOrders.deleteOrder(widget.id);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Get.snackbar('تم بنجاح ', 'قد تم حذف الطلب الخاص بك ',
                      snackPosition: SnackPosition.TOP);
                },
              );
              // ignore: deprecated_member_use
              Widget continueButton = FlatButton(
                child: Text(
                  "لا",
                  style: TextStyle(color: AppColors.primary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("تحذير"),
                content: Text("هل تريد حذف الطلب الخاص بك؟"),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Consumer<GetOneOrderProvider>(
                        builder: (ctx, getOneOrderProvider, _) {
                      return getOneOrderProvider.list == null
                          ? Center(child: Text(''))
                          : Text(
                              'الكميه :' +
                                  Provider.of<GetOneOrderProvider>(context)
                                      .list
                                      .data
                                      .products[0]
                                      .quantity,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            );
                    }),
                    Spacer(),
                    Consumer<GetOneOrderProvider>(
                        builder: (ctx, getOneOrderProvider, _) {
                      return getOneOrderProvider.list == null
                          ? Center(child: Text(''))
                          : Text(
                              'الكود : ' +
                                  getOneOrderProvider.list.data.orderCode
                                      .toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            );
                    }),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.primary,
                ),
                Container(
                  height: size.height * 0.8,
                  child: Consumer<GetOneOrderProvider>(
                      builder: (ctx, getOneOrderProvider, _) {
                    return getOneOrderProvider.list == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : getOneOrderProvider.list == null
                            ? Center(child: CircularProgressIndicator())
                            : Center(
                                child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: getOneOrderDetails
                                    .list.data.products.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                      //comment
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ProductScreen(
                                            id: getOneOrderDetails.list.data
                                                .products[index].productId
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            getOneOrderProvider.list.data
                                                .products[index].image,
                                            width: size.width * 1,
                                            height: size.height * 0.130,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/Image 1.png',
                                                width:
                                                    getProportionateScreenWidth(
                                                        40),
                                                height:
                                                    getProportionateScreenHeight(
                                                        40),
                                              ),
                                              SizedBox(
                                                width: size.width / 2,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  AppText(
                                                    //text: "وجبة مكرونة وفراخ قطعتين",
                                                    text: getOneOrderDetails
                                                        .list
                                                        .data
                                                        .products[index]
                                                        .name,
                                                    fontSize: 3.3,
                                                    color: Colors.black54,
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .star_border_outlined),
                                                          onPressed: () {
                                                            Get.defaultDialog(
                                                                title: "Review",
                                                                content: Form(
                                                                  key: _formKey,
                                                                  child: Column(
                                                                    children: [
                                                                      RatingBar
                                                                          .builder(
                                                                        initialRating:
                                                                            0,
                                                                        minRating:
                                                                            1,
                                                                        itemSize:
                                                                            25,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount:
                                                                            5,
                                                                        itemPadding:
                                                                            EdgeInsets.symmetric(horizontal: 4.0),
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          s = rating;
                                                                          print(
                                                                              s);
                                                                        },
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                15,
                                                                            vertical:
                                                                                10),
                                                                        child: Container(
                                                                            height: 55,
                                                                            child: TextFormField(
                                                                              controller: controller,
                                                                            )),
                                                                      ),
                                                                      // ignore: deprecated_member_use
                                                                      OutlineButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String id = getOneOrderDetails
                                                                              .list
                                                                              .data
                                                                              .products[index]
                                                                              .productId
                                                                              .toString();
                                                                          print(
                                                                              id);
                                                                          print(
                                                                              s.toString());
                                                                          Provider.of<RateProvider>(context, listen: false).addRate(
                                                                              id,
                                                                              s.toString(),
                                                                              controller.text,
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'قيم',
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ));
                                                          }),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
