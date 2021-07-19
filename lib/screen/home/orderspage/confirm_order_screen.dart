import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/orders_provider/orders.dart';

import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfirmOrderScreen extends StatefulWidget {
  String id;

  ConfirmOrderScreen({this.id});

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  TextEditingController address = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              SizedBox(
                height: height / 15,
              ),
              TextFormField(
                controller: address,
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
                    labelText: 'ادخل عنوان التوصيل'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'من فضلك ادخل عنوان صحيح';
                  }

                  return null;
                },
                onSaved: (input) => address.text = input,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  padding: EdgeInsets.all(13),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('تأكيد الطلب'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addOrder(address.text, context);
                    } else {
                      return null;
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
