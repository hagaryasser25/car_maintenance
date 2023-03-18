import 'package:car_maintenance/screens/admin/add_car.dart';
import 'package:car_maintenance/screens/admin/admin_cars.dart';
import 'package:car_maintenance/screens/admin/admin_gallery.dart';
import 'package:car_maintenance/screens/admin/cars_list.dart';
import 'package:car_maintenance/screens/admin/cash_list.dart';
import 'package:car_maintenance/screens/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class BookingList extends StatefulWidget {
  static const routeName = '/bookingList';
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Center(child: Text('قائمة الحجوزات')),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 15.h, right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/admin.jfif',
                    height: 250.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'حجوزات السيارات',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Marhey',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CashList.routeName);
                          },
                          child: card('كاش')),
                      SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CarsList.routeName);
                          },
                          child: card('قسط'))
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

Widget card(String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      color: HexColor('#ffba26'),
      child: SizedBox(
        width: 165.w,
        height: 120.h,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 10.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
