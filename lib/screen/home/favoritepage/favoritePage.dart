import 'package:falafel/apis/check_connection.dart';
import 'package:falafel/provider/cart_provider/cart.dart';
import 'package:falafel/provider/favorite_provider/favorite.dart';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var getCartData = Provider.of<CartProvider>(context, listen: false);
    getCartData.callAPIForCart();
    var getFavorite = Provider.of<FavoriteProvider>(context, listen: false);
    getFavorite.callAPIForAllFavorites();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            Container(
              width: size.width / 10,
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              // ISTOKENEXIST
              //     ? Center(
              //         // ignore: deprecated_member_use
              //         child: RaisedButton(
              //             child: Text('يجب تسجيل الدخول اولا'),
              //             onPressed: () {
              //               Get.to(LoginScreen());
              //             }),
              //       )
                 // :
            Container(
                      height: double.infinity,
                      child: Consumer<FavoriteProvider>(
                        builder: (ctx, favoriteProvider, _) {
                          return favoriteProvider.list == null
                              ? Center(child: CircularProgressIndicator())
                              : favoriteProvider.counter == 0
                                  ? Center(
                                      child: Text(''),
                                    )
                                  : GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: .8,
                                      ),
                                      itemBuilder: (context, index) => Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey[100],
                                            ),
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Image.network(
                                                      favoriteProvider
                                                          .list
                                                          .favorite[index]
                                                          .imagePath,
                                                      width: size.width * 0.5,
                                                      height: size.height / 12,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              // color: secondaryColor,
                                                              )),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            getFavorite.deleteFavorite(
                                                                favoriteProvider
                                                                    .list
                                                                    .favorite[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                context);
                                                          },
                                                          child: Icon(
                                                            favoriteProvider
                                                                        .list
                                                                        .favorite[
                                                                            index]
                                                                        .favorite ==
                                                                    "1"
                                                                ? Icons
                                                                    .favorite_outlined
                                                                : Icons
                                                                    .favorite_outline,
                                                            size: 15,
                                                            //color: secondaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    bottom: 5,
                                                    left: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              favoriteProvider
                                                  .list.favorite[index].name,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppColors.primary,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  getCartData.addToCart(
                                                      favoriteProvider.list
                                                          .favorite[index].id
                                                          .toString(),
                                                      context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      favoriteProvider
                                                          .list
                                                          .favorite[index]
                                                          .price,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      itemCount: favoriteProvider.counter,
                                    );
                        },
                      ),
                    ),
            ],
          ),
        ));
  }
}
