
import 'package:animate_do/animate_do.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/screen/home/cart/cart_screen.dart';
import 'package:falafel/screen/home/searchpage/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import 'app_colors.dart';
import 'app_text.dart';

export 'app_button.dart';
export 'app_form_field.dart';
export 'app_text.dart';
export 'lazy_widget.dart';

// ignore: must_be_immutable
class TextFieldWidgets extends StatelessWidget {
  int min, max;
  TextEditingController controller;
  Widget widget;
  String name;
  bool a;
  // ignore: non_constant_identifier_names
  final Validator;
  TextFieldWidgets(
      {this.controller,
      this.name,
      this.max,
      this.min,
      // ignore: non_constant_identifier_names
      this.Validator,
      this.a,
      this.widget});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: getSizeText(6.8),
      child: TextFormField(
        obscureText: a == null ? false : a,
        controller: controller,
        validator: Validator,
        decoration: InputDecoration(
          suffixIcon: widget == null
              ? Container(
                  height: 0.1,
                  width: 0.1,
                )
              : widget,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: getSizeText(3.7),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: name,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey[100],
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey[100],
              )),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UserData extends StatelessWidget {
  String label, hint;
  final validator;
  TextEditingController controller;
IconButton icon;
bool obSecureText = false;

  UserData({this.hint, this.label, this.validator, this.controller,this.icon,this.obSecureText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        obscureText:obSecureText == null ? false : obSecureText,
        cursorColor: AppColors.primary,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(

       suffixIcon: icon == null ? SizedBox() : IconButton(icon: icon,color: AppColors.primary, onPressed: () {  },),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
            labelText: label,
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: getSizeText(3.1)),
            labelStyle: TextStyle(
                color: AppColors.primary, fontSize: getSizeText(3.2))),
      ),
    );
  }
}

// ignore: must_be_immutable
class SocialLogin extends StatelessWidget {
  String icon;
  String title;
  final onTap;
  SocialLogin({
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                width: getProportionateScreenHeight(25),
              ),
              AppText(
                text: title,
                color: Colors.black54,
                fontSize: 3.4,
                fontWeight: FontWeight.bold,
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class CusttomAppBar extends StatelessWidget {
  final Size size;
  CusttomAppBar({this.size});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'img2',
      child: Container(
        width: size.width * 1,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 7), color: Colors.grey[200], blurRadius: 15)
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInLeft(
                    child: SvgPicture.asset(
                      'assets/icons/food-delivery.svg',
                      width: getSizeText(4.2),
                      height: getSizeText(4.5),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenHeight(5),
                  ),
                  AppText(
                    text: 'بيوصل',
                    color: Colors.black,
                    fontSize: 3.5,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: getProportionateScreenHeight(15),
                  ),
                  Icon(
                    Icons.logout,
                    size: getSizeText(4.4),
                  ),
                  Spacer(),
                  AppText(
                    text: 'الحي الثالث 6 اكتوبر',
                    color: AppColors.primary,
                    fontSize: 3.5,
                    fontWeight: FontWeight.bold,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primary,
                    size: getSizeText(4.4),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: CartScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primary,
                        size: getSizeText(4.7),
                      ))
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => SearchView()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/loupe.svg',
                                  width: getSizeText(4.5),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                AppText(
                                  text: "ابحث عن مطعم",
                                  fontSize: 3.6,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    width: getProportionateScreenWidth(15),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/icons/funnel.svg',
                        width: getSizeText(4.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
