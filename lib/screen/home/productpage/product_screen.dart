import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/cart_provider/cart.dart';
import 'package:falafel/provider/favorite_provider/favorite.dart';
import 'package:falafel/provider/get_one_product_provider/one_product.dart';
import 'package:falafel/screen/home/ratepage/all_rates_screen.dart';
import 'package:falafel/screen/home/ratepage/rate_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  String id;

  ProductScreen({this.id});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  int value = 1;
  IconData icon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    var getFavorite = Provider.of<FavoriteProvider>(context, listen: false);
    getFavorite.callAPIForAllFavorites();
    var getOneProduct =
    Provider.of<GetOneProductProvider>(context, listen: false);
    getOneProduct.callAPIForGetOneProductData(widget.id);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Consumer<GetOneProductProvider>(
        builder: (ctx, getOneProduct, _) {
          return getOneProduct.list == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: [
              Stack(
                children: [
                  Image.network(
                    getOneProduct.list.oneProduct.imagePath,
                    fit: BoxFit.cover,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.250,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                  ),
                  Positioned(
                    bottom: 2,
                    child: IconButton(
                        icon: Icon(
                          getOneProduct.list.oneProduct.favorite == '0'
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: Colors.pinkAccent,
                          size: getSizeText(7),
                        ),
                        onPressed: () {
                          setState(() {
                            if (getOneProduct
                                .list.oneProduct.favorite ==
                                '1') {
                              getFavorite.deleteFavorite(
                                  widget.id, context);
                              Provider.of<GetOneProductProvider>(
                                  context,
                                  listen: false)
                                  .callAPIForGetOneProductData(
                                  widget.id);
                            } else {
                              getFavorite.addFavorite(
                                  widget.id, context);
                              Provider.of<GetOneProductProvider>(
                                  context,
                                  listen: false)
                                  .callAPIForGetOneProductData(
                                  widget.id);
                            }
                          });
                        }
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getOneProduct.list.oneProduct.name}',
                      style: TextStyle(
                          color: AppColors.primary, fontSize: 12),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'شارك الوجبه',
                        style: TextStyle(
                            color: AppColors.primary, fontSize: 12),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('اختار الحجم'),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color: AppColors.primary, size: 12),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'عادي',
                          style: TextStyle(
                            fontSize: getSizeText(3.5),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${getOneProduct.list.oneProduct.price}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(' اضافات'),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  كاتشب'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkboxValue1 = !checkboxValue1;
                              });
                            },
                            child: checkboxValue1
                                ? Icon(
                              Icons.check_box_outlined,
                              color: AppColors.primary,
                              size: 20,
                            )
                                : Icon(
                              Icons.check_box,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  كاتشب'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkboxValue2 = !checkboxValue2;
                              });
                            },
                            child: checkboxValue2
                                ? Icon(
                              Icons.check_box_outlined,
                              color: AppColors.primary,
                              size: 20,
                            )
                                : Icon(
                              Icons.check_box,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  كاتشب'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkboxValue3 = !checkboxValue3;
                              });
                            },
                            child: checkboxValue3
                                ? Icon(
                              Icons.check_box_outlined,
                              color: AppColors.primary,
                              size: 20,
                            )
                                : Icon(
                              Icons.check_box,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  كاتشب'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkboxValue4 = !checkboxValue4;
                              });
                            },
                            child: checkboxValue4
                                ? Icon(
                              Icons.check_box_outlined,
                              color: AppColors.primary,
                              size: 20,
                            )
                                : Icon(
                              Icons.check_box,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('التقيمات'),
                    Spacer(),
                    Text('الكل'),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      AllRateScreen(
                                        id: widget.id,
                                      )));
                        }),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: RatesScreen(
                        id: getOneProduct.list.oneProduct.id.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          Provider.of<CartProvider>(context,
                              listen: false)
                              .addToCart(widget.id.toString(), context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              )),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اطلب الان',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getSizeText(4),
                                ),
                              ),
                              Text(
                                getOneProduct.list.oneProduct.price,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getSizeText(4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
            ],
          );
        },
      ),
    );
  }
}