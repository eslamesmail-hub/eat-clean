import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/category_provider/category.dart';
import 'package:falafel/screen/home/productbycategoryidpage/sub_category.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  String id;

  CategoriesScreen({this.id});

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryProvider>(context);
    category.callForCategoryData(id);
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
          // height: size.height * 0.150,
          child:
              Consumer<CategoryProvider>(builder: (ctx, categoryProvider, _) {
            return categoryProvider.list2 == null
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: categoryProvider.list2.data.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4 ,horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            Get.to(SubcategoryScreen(
                              id: category.list2.data[index].id.toString(),
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
                                                .list2.data[index].name,
                                        color: Colors.black,
                                        fontSize: 4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          categoryProvider
                                              .list2.data[index].imagePath,
                                          width: size.width * 0.17,
                                          fit: BoxFit.cover,
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
