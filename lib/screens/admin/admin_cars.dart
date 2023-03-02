import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/cars_model.dart';

class AdminCars extends StatefulWidget {
  String category;
  static const routeName = '/adminCars';
   AdminCars({
    required this.category
  });

  @override
  State<AdminCars> createState() => _AdminCarsState();
}

class _AdminCarsState extends State<AdminCars> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Cars> carsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCars();
  }

  @override
  void fetchCars() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("cars").child(widget.category);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Cars p = Cars.fromJson(event.snapshot.value);
      carsList.add(p);
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
              backgroundColor: Colors.red, title: Text('قائمة السيارات')),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                  itemCount: carsList.length,
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
                                            '${carsList[index].imageUrl.toString()}'),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        '${carsList[index].name.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
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
                                                .child(carsList[index]
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
