import 'package:car_maintenance/screens/admin/add_car.dart';
import 'package:car_maintenance/screens/admin/add_gallery.dart';
import 'package:car_maintenance/screens/admin/admin_cars.dart';
import 'package:car_maintenance/screens/admin/admin_gallery.dart';
import 'package:car_maintenance/screens/admin/admin_home.dart';
import 'package:car_maintenance/screens/admin/booking_list.dart';
import 'package:car_maintenance/screens/admin/cars_list.dart';
import 'package:car_maintenance/screens/auth/admin_login.dart';
import 'package:car_maintenance/screens/auth/login_page.dart';
import 'package:car_maintenance/screens/auth/signup_page.dart';
import 'package:car_maintenance/screens/user/update_profile.dart';
import 'package:car_maintenance/screens/user/user_cars.dart';
import 'package:car_maintenance/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/admin/cash_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const UserLogin()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : UserHome(),
      routes: {
        SignUp.routeName: (ctx) => SignUp(),
        UserLogin.routeName: (ctx) => UserLogin(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AddCar.routeName: (ctx) => AddCar(),
        AddGallery.routeName: (ctx) => AddGallery(),
        AdminGallery.routeName: (ctx) => AdminGallery(),
        UserHome.routeName: (ctx) => UserHome(),
        UserCars.routeName: (ctx) => UserCars(),
        BookingList.routeName: (ctx) => BookingList(),
        CarsList.routeName: (ctx) => CarsList(),
        CashList.routeName: (ctx) => CashList(),
      },
    );
  }
}
