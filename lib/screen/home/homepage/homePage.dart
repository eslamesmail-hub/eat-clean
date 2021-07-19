import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/category_provider/category.dart';
import 'package:falafel/provider/product_provider/product.dart';
import 'package:falafel/screen/home/productbycategoryidpage/categories.dart';
import 'package:falafel/screen/home/productpage/product_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryProvider>(context);
    category.callAPIForCategoryData();
    var products = Provider.of<ProductsProvider>(context);
    products.callAPIForProductsData();
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
                          fontSize: getSizeText(2.05),
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.primary,
                        )
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
                          text: 'خصومات حصرية',
                          color: Colors.black,
                          fontSize: getSizeText(2.05),
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),

                    ///DiscountsItems
                    DiscountsItems(size: size),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),

                    Row(
                      children: [
                        AppText(
                          text: 'المأكولات',
                          color: Colors.black,
                          fontSize: getSizeText(2.05),
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        AppText(
                          text: 'اوردو اونلاين',
                          color: AppColors.primary,
                          fontSize: getSizeText(2.05),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    HomeProduct(size: size),
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

class HomeProduct extends StatelessWidget {
  const HomeProduct({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 4,
      child: Consumer<ProductsProvider>(
        builder: (ctx, productProvider, _) {
          return productProvider.list == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: productProvider.list.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductScreen(
                              id: productProvider.list.data[index].id
                                  .toString(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 7), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  productProvider.list.data[index].imagePath,
                                  height: size.height * 0.125,
                                  width: size.width / 1.80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: productProvider.list.data[index].name,
                                    fontSize: getSizeText(2),
                                    color: Colors.black54,
                                  ),
                                  AppText(
                                    text:
                                        productProvider.list.data[index].price,
                                    fontSize: getSizeText(2),
                                    color: Colors.black54,
                                  ),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            productProvider
                                                .list.data[index].rating),
                                        minRating: 1,
                                        itemSize: getSizeText(4.0),
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

class DiscountsItems extends StatelessWidget {
  const DiscountsItems({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.23,
        width: size.width * 1,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int i) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductScreen()));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.180,
                        width: size.width * 0.850,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/chicken-steak-with-lemon-tomato-chili-carrot-white-plate.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 15,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 7),
                                    color: Colors.grey[200],
                                    blurRadius: 15)
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Image 1.png',
                                    width: getProportionateScreenWidth(30),
                                    height: getProportionateScreenHeight(30),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      AppText(
                                        text: 'ايت اند جو',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: getSizeText(2),
                                      ),
                                      AppText(
                                        text: 'خصم 25% للمكولات',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                        fontSize: getSizeText(2),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }));
  }
}

class OfferItems extends StatelessWidget {
  const OfferItems({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.150,
      child: Consumer<CategoryProvider>(builder: (ctx, categoryProvider, _) {
        return categoryProvider.list == null
            ? Container(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: size.width * 0.250,
                                height: size.height * 0.09,
                                color: Colors.grey[200],
                              )));
                    }))
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.list.data.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(CategoriesScreen(
                          id: categoryProvider.list.data[index].id.toString(),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 12,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.network(
                                categoryProvider.list.data[index].imagePath,
                                width: size.width * 0.250,
                                height: size.height * 0.09,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          AppText(
                            text: categoryProvider.list.data[index].name,
                            color: Colors.black,
                            fontSize: getSizeText(2),
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  );
                });
      }),
    );
  }
}
