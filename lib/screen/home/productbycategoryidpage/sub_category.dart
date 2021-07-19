import 'package:falafel/provider/category_provider/category.dart';
import 'package:falafel/screen/home/productbycategoryidpage/product_by_category_id_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubcategoryScreen extends StatelessWidget {
  String id;

  SubcategoryScreen({this.id});

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryProvider>(context);
    category.callForSubCategory(id);
    Size size = MediaQuery.of(context).size;
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
        body: Container(
          child:
              Consumer<CategoryProvider>(builder: (ctx, categoryProvider, _) {
            return categoryProvider.list3 == null
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) =>SizedBox(height: 0,),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: categoryProvider.list3.data.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4 ,horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            Get.to(ProductByCategoryIdScreen(
                              id: categoryProvider.list3.data[index].id
                                  .toString(),
                            ));
                          },
                          child: Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: 'النوع : ' +
                                        categoryProvider
                                            .list3.data[index].name,
                                        color: Colors.black,
                                        fontSize: 3.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          categoryProvider
                                              .list3.data[index].imagePath,
                                          width: size.width * 0.250,
                                          height: size.height * 0.09,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          }),
        ));
  }
}
