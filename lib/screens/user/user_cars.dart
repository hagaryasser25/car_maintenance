import 'package:car_maintenance/screens/admin/add_gallery.dart';
import 'package:car_maintenance/screens/admin/admin_cars.dart';
import 'package:car_maintenance/screens/models/gallery_model.dart';
import 'package:car_maintenance/screens/user/fetch_cars.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserCars extends StatefulWidget {
  static const routeName = '/userCars';
  const UserCars({super.key});

  @override
  State<UserCars> createState() => _UserCarsState();
}

class _UserCarsState extends State<UserCars> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Gallery> galleryList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchGallerys();
  }

  @override
  void fetchGallerys() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("gallerys");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Gallery p = Gallery.fromJson(event.snapshot.value);
      galleryList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(backgroundColor: Colors.red, title: Text('المعارض')),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                  itemCount: galleryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, bottom: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 15.w),
                                        child: Image.network(
                                            '${galleryList[index].imageUrl.toString()}'),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        '${galleryList[index].name.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${galleryList[index].phoneNumber.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            
                                            ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 80, height: 40.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: HexColor('#ffba26')),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return FetchCars(
                                                category:
                                                    '${galleryList[index].name.toString()}',
                                              );
                                            }));
                                          },
                                          child: Text('السيارات'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
