import 'package:car_maintenance/screens/admin/add_car.dart';
import 'package:car_maintenance/screens/admin/admin_cars.dart';
import 'package:car_maintenance/screens/admin/admin_gallery.dart';
import 'package:car_maintenance/screens/auth/login_page.dart';
import 'package:car_maintenance/screens/user/update_profile.dart';
import 'package:car_maintenance/screens/user/user_cars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/users_model.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red,
              title: Center(child: Text('الصفحة الرئيسية')),
            ),
            body: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/car.jfif',
                    height: 280.h,
                    width: double.infinity,
                  ),
                  Text(
                    'الخدمات المتاحة',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Marhey',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UserCars.routeName);
                          },
                          child: card('السيارات')),
                      SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                          onTap: () async{
                            
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UpdateProfile(
                                email: currentUser.email,
                                password: currentUser.password,
                                name: '${currentUser.name}',
                                phoneNumber: '${currentUser.phoneNumber}',
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              );
                            }));
                          },
                          child: card('الملف الشخصى'))
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 85.w,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, UserLogin.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: card('تسجيل الخروج')),
                      SizedBox(
                        width: 85.w,
                      ),
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
