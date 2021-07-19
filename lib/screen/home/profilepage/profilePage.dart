import 'package:falafel/apis/auth_api.dart';
import 'package:falafel/apis/check_connection.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/user_information_provider/user_information.dart';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:falafel/screen/home/profilepage/user_edit_password_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var getUserData =
        Provider.of<UserInformationProvider>(context, listen: false);
    getUserData.callAPIForUserInformation();
    return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: SafeArea(
          child:
          // ISTOKENEXIST
          //     ? Center(
          //         // ignore: deprecated_member_use
          //         child: RaisedButton(
          //             child: Text('يجب تسجيل الدخول اولا'),
          //             onPressed: () {
          //               Get.to(LoginScreen());
          //             }),
          //       )
          //     :
          Consumer<UserInformationProvider>(
                  builder: (ctx, userInformationProvider, _) {
                    return userInformationProvider.user == null
                        ? Center(child: CircularProgressIndicator())
                        : Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                IconButton(
                                    alignment: Alignment.topLeft,
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                    }),
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userInformationProvider.user.name,
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userInformationProvider.user.email,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'معلوماتك الشخصية',
                                                style: TextStyle(
                                                  color: AppColors.yellow,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.bottomSheet(BottomSheet(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      onClosing: () {},
                                                      builder: (_) {
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                30),
                                                                        topRight:
                                                                            Radius.circular(30))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          20),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        UserData(
                                                                          controller:
                                                                              name,
                                                                          label:
                                                                              'الاسم',
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              getProportionateScreenHeight(10),
                                                                        ),
                                                                        UserData(
                                                                          controller:
                                                                              mobile,
                                                                          label:
                                                                              'الرقم',
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              getProportionateScreenHeight(10),
                                                                        ),
                                                                        UserData(
                                                                          label:
                                                                              'العنوان',
                                                                          controller:
                                                                              address,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              getProportionateScreenHeight(15),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 20),
                                                                          child:
                                                                              RoundedLoadingButton(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 1,
                                                                            height:
                                                                                getProportionateScreenHeight(47),
                                                                            borderRadius:
                                                                                10,
                                                                            color:
                                                                                AppColors.primary,
                                                                            child:
                                                                                Text('تعديل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () {
                                                                              if (_formKey.currentState.validate()) {
                                                                                _formKey.currentState.save();
                                                                                userInformationProvider.userEditInformation(name.text, mobile.text, address.text, context);
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }));
                                                },
                                                child: Text(
                                                  'تعديل',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'الاسم الاول',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Text(
                                                  userInformationProvider
                                                      .user.name,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Color(0XFF242451),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "الرقم",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Text(
                                                  userInformationProvider
                                                      .user.mobile,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Color(0XFF242451),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'العنوان',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Text(
                                                  userInformationProvider
                                                      .user.address,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Color(0XFF242451),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Auth().UserLogOut(context);
                                                    ISTOKENEXIST = false;
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'تسجيل خروج',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'معلومات الأمان',
                                            style: TextStyle(
                                              color: AppColors.yellow,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                    UserEditPasswordScreen());
                                              },
                                              child: Text(
                                                'تغيير كلمة السر',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          );
                  },
                ),
        ));
  }

  ListTile buildListTile(String text) {
    return ListTile(
      title: AppText(
        text: text,
        color: AppColors.primary,
        fontSize: 3.4,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.primary,
        size: getSizeText(4),
      ),
    );
  }
}
