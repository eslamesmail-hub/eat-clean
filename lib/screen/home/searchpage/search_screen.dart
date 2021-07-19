import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/search_provider/search.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {

  String searchText = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppColors.primary)),
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppColors.primary)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppColors.primary)),
                    labelText: 'ادخل رمز البحث'),
                onChanged: (value) {
                  searchText = value;
                  final searchData =
                      Provider.of<SearchProvider>(context, listen: false);
                  searchData.callAPIForSearchData(searchText);
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'من فضلك ادخل رمز للبحث';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Container(
                height: size.height * 0.5,
                child: Provider.of<SearchProvider>(context).getSearchData ==
                        null
                    ? Center(child: Text(''))
                    : Consumer<SearchProvider>(
                        builder: (ctx, searchProvider, _) {
                        return searchProvider.counter == 0
                            ? Center(child: Text('لا يوجد منتجات'))
                            : GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
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
                                                  const EdgeInsets.all(10.0),
                                              child: Image.network(
                                                searchProvider
                                                    .list.data[index].imagePath,
                                                width: size.width * 0.5,
                                                height: size.height / 12,
                                                fit: BoxFit.contain,
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
                                        searchProvider.list.data[index].name,
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              searchProvider
                                                  .list.data[index].price,
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
                                  ],
                                ),
                                itemCount: searchProvider.counter,
                              );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
