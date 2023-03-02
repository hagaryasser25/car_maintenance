import 'package:car_maintenance/screens/auth/signup_page.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

import '../user/user_home.dart';
import 'admin_login.dart';

class UserLogin extends StatefulWidget {
  static const routeName = '/userLogin';
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            child: Column(children: [
              SizedBox(
                height: 80.h,
              ),
              Row(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Image.asset('assets/images/user.jfif',
                              height: 250.h, width: 250.h))),
                  Padding(
                    padding:  EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      'هل انت لديك \n حساب بالفعل؟',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Marhey',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.blue),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'البريد الألكترونى',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.blue,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.blue),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: 200.w, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              'سجل دخول',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Marhey',
                              ),
                            ),
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description:
                                            Text("please fill all fields"))
                                    .show(context);

                                return;
                              }

                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Logging In'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.pushNamed(
                                      context, UserHome.routeName);
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  MotionToast(
                                          primaryColor: Colors.blue,
                                          width: 300,
                                          height: 50,
                                          position: MotionToastPosition.center,
                                          description: Text("user not found"))
                                      .show(context);
                                  return;
                                } else if (e.code == 'wrong-password') {
                                  MotionToast(
                                          primaryColor: Colors.blue,
                                          width: 300,
                                          height: 50,
                                          position: MotionToastPosition.center,
                                          description:
                                              Text("wrong email or password"))
                                      .show(context);

                                  return;
                                }
                              } catch (e) {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description:
                                            Text("something went wrong"))
                                    .show(context);
                                print(e);

                                progressDialog.dismiss();
                              }
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AdminLogin.routeName);
                            },
                            child: Text(
                              'تسجيل الدخول كأدمن',
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUp.routeName);
                            },
                            child: Text(
                              'اضغط هنا لانشاء حساب',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
