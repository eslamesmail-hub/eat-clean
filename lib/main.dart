import 'package:falafel/apis/check_connection.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/cart_provider/cart.dart';
import 'package:falafel/provider/category_provider/category.dart';
import 'package:falafel/provider/favorite_provider/favorite.dart';
import 'package:falafel/provider/get_one_product_provider/one_product.dart';
import 'package:falafel/provider/get_product_by_category_provider/product_by_category.dart';
import 'package:falafel/provider/orders_provider/one_order.dart';
import 'package:falafel/provider/orders_provider/orders.dart';
import 'package:falafel/provider/product_provider/product.dart';
import 'package:falafel/provider/rate_provider/rate.dart';
import 'package:falafel/provider/search_provider/search.dart';
import 'package:falafel/provider/user_information_provider/user_information.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:falafel/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeDefault: LocalizationDefaultType.asDefined,
    languagesList: <String>['ar'],

    assetsDirectory: 'assets/i18n/',
    apiKeyGoogle: '<Key>',
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SearchProvider()),
        ChangeNotifierProvider.value(value: CategoryProvider()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: GetOneProductProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrderProvider()),
        ChangeNotifierProvider.value(value: GetOneOrderProvider()),
        ChangeNotifierProvider.value(value: FavoriteProvider()),
        ChangeNotifierProvider.value(value: RateProvider()),
        ChangeNotifierProvider.value(value: GetProductByCategoryProvider()),
        ChangeNotifierProvider.value(value: UserInformationProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green
        ),
        locale: Locale('ar'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void checkToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    if (token == null) {
      Get.to(SplashScreen());
      ISTOKENEXIST = false;

    } else {
      // Get.to(HomeScreen());
      Get.to(HomeScreen());
      ISTOKENEXIST = true;

    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
