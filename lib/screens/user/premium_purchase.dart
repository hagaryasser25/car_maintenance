import 'dart:io';
import 'package:car_maintenance/screens/user/user_home.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import '../models/gallery_model.dart';

class PremiumPurchase extends StatefulWidget {
  String galleryName;
  String carName;
  static const routeName = '/cashPurshase';
   PremiumPurchase({
    required this.galleryName,
    required this.carName,
   });

  @override
  State<PremiumPurchase> createState() => _PremiumPurchaseState();
}

class _PremiumPurchaseState extends State<PremiumPurchase> {
  var nationalIdController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateController = TextEditingController();
  var colorController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/car.jfif'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الأسم',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: nationalIdController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الرقم القومى',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'العنوان',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'رقم الهاتف',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: colorController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'لون السيارة',
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'المقدم',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                 
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تاريخ الأستلام',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                   
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      ),
                      onPressed: () async {
                        String name = nameController.text.trim();
                        String nationalId = nationalIdController.text.trim();
                        String address = addressController.text.trim();
                        String phoneNumber = phoneNumberController.text.trim();
                        String date = dateController.text.trim();
                        String color = colorController.text.trim();
                        String price = priceController.text.trim();
                        
                        

                        if (name.isEmpty ||
                            nationalId.isEmpty ||
                            address.isEmpty ||
                            phoneNumber.isEmpty ||
                            color.isEmpty ||
                            date.isEmpty ||
                            price.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('premium');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'galleryName': widget.galleryName,
                            'carName': widget.carName,
                            'name': name,
                            'nationalId': nationalId,
                            'address': address,
                            'phoneNumber': phoneNumber,
                            'date': date,
                            'color': color,
                            'price': price,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child:
                          Text('حجز', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم حجز السيارة"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
