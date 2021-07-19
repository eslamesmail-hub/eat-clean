import 'package:falafel/provider/cart_provider/cart.dart';
import 'package:falafel/provider/get_product_by_category_provider/product_by_category.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductByCategoryIdScreen extends StatelessWidget {
  String id;

  ProductByCategoryIdScreen({this.id});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var getProductByCategory =
        Provider.of<GetProductByCategoryProvider>(context);
    getProductByCategory.callAPIForGetProductByCategory(id);
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
                  Navigator.of(context).pop();
                }),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Consumer<GetProductByCategoryProvider>(
                      builder: (ctx, getProductByCategoryId, _) {
                    return getProductByCategoryId.list == null
                        ? Center(child: CircularProgressIndicator())
                        : getProductByCategory.counter == 0
                            ? Center(child: Text('لا يوجد تفاصيل للمنتج'))
                            : GridView.builder(
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[100],
                                      ),
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Image.network(
                                                getProductByCategory
                                                    .list
                                                    .productByCategory[index]
                                                    .imagePath,
                                                width: size.width * 0.5,
                                                height: size.height / 12,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        // color: secondaryColor,
                                                        )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Icon(
                                                    getProductByCategoryId
                                                                .list
                                                                .productByCategory[
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
                                        getProductByCategoryId
                                            .list.productByCategory[index].name,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.primary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10),
                                        child: InkWell(
                                          onTap: () {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .addToCart(
                                                    getProductByCategoryId
                                                        .list
                                                        .productByCategory[
                                                            index]
                                                        .id
                                                        .toString(),
                                                    context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                getProductByCategoryId
                                                    .list
                                                    .productByCategory[index]
                                                    .price,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Icon(
                                                Icons.shopping_cart_outlined,
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
                                itemCount: getProductByCategoryId
                                    .list.productByCategory.length,
                              );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
