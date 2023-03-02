import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/cars_model.dart';

class FetchCars extends StatefulWidget {
  String category;
  static const routeName = '/fetchCars';
  FetchCars({required this.category});

  @override
  State<FetchCars> createState() => _FetchCarsState();
}

class _FetchCarsState extends State<FetchCars> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Cars> carsList = [];
  List<Cars> searchList = [];
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
      searchList.add(p);
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
              padding:  EdgeInsets.only(
                right: 10.w,
                left: 10.w
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  TextField(
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'بحث عن سيارة',
                    ),
                    onChanged: (char) {
                      setState(() {
                        if (char.isEmpty) {
                          setState(() {
                            carsList = searchList;
                          });
                        } else {
                          carsList = [];
                          for (Cars model in searchList) {
                            if (model.name!.contains(char)) {
                              carsList.add(model);
                            }
                          }
                          setState(() {});
                        }
                      });
                    },
                  ),
                  SizedBox(height: 10.h,),
                  Expanded(
                    flex: 8,
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
                                              padding:
                                                  EdgeInsets.only(right: 15.w),
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
                                            Text(
                                              'موديل السيارة : ${carsList[index].model.toString()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'سعة الموتور : ${carsList[index].capacity.toString()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'السعر : ${carsList[index].price.toString()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'الألوان المتوفرة : ${carsList[index].color.toString()}',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
