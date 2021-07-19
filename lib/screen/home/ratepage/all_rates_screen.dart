import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/rate_provider/rate.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
class AllRateScreen extends StatefulWidget {
  String id;

  AllRateScreen({this.id});
  @override
  _AllRateScreenState createState() => _AllRateScreenState();
}

class _AllRateScreenState extends State<AllRateScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var getAllRates = Provider.of<RateProvider>(context, listen: false);
    getAllRates.callAPIForAllRates(widget.id.toString());
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            Container(
              width: size.width/10,
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
        body: Consumer<RateProvider>(
          builder: (ctx, getRatedOrder, _) {
            return getRatedOrder.list == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : getRatedOrder.list == null
                ? Center(child: CircularProgressIndicator())
                : Center(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount:  getAllRates.list.rate.length,
                itemBuilder: (_, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 7,
                                color: Colors.grey[200])
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Spacer(),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                AppText(
                                  text: getAllRates.list.rate[i].name,
                                  color: Colors.black54,
                                  fontSize: 3.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    AppText(
                                      text: '2021-06-07 15:52:15',
                                      color: Colors.grey,
                                      fontSize: 3.1,
                                    ),
                                    Icon(
                                      Icons.timelapse_outlined,
                                      color: Colors.grey,
                                      size: getSizeText(3.5),
                                    ),
                                    SizedBox(
                                      width:
                                      getProportionateScreenWidth(
                                          5),
                                    ),
                                    RatingBar.builder(
                                      initialRating: double.parse(
                                          getAllRates
                                              .list.rate[i].rate),
                                      minRating: 1,
                                      itemSize: getSizeText(3.4),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(
                                          horizontal: 0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                  getProportionateScreenHeight(5),
                                ),
                                AppText(
                                  text:
                                  getAllRates.list.rate[i].content,
                                  color: Colors.black54,
                                  fontSize: 3.2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

      ),
    );
  }
}
