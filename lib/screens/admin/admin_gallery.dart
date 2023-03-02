import 'package:car_maintenance/screens/admin/add_gallery.dart';
import 'package:car_maintenance/screens/admin/admin_cars.dart';
import 'package:car_maintenance/screens/models/gallery_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminGallery extends StatefulWidget {
  static const routeName = '/adminGallery';
  const AdminGallery({super.key});

  @override
  State<AdminGallery> createState() => _AdminGalleryState();
}

class _AdminGalleryState extends State<AdminGallery> {
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
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة معرض',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddGallery.routeName);
                  },
                )),
          ),
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
                                              return AdminCars(
                                                category: '${galleryList[index].name.toString()}',
                                              );
                                            }));
                                          },
                                          child: Text('السيارات'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            base
                                                .child(galleryList[index]
                                                    .id
                                                    .toString())
                                                .remove();
                                          },
                                          child: Icon(Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 122, 122, 122)))
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
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
