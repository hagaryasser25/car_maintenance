import 'dart:io';
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
import 'admin_home.dart';

class AddCar extends StatefulWidget {
  static const routeName = '/addCar';
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String dropdownValue = 'Autohub';
  var galleryNameController = TextEditingController();
  var nameController = TextEditingController();
  var modelController = TextEditingController();
  var colorController = TextEditingController();
  var capacityController = TextEditingController();
  var priceController = TextEditingController();

  String imageUrl = '';
  File? image;

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
    base = database.reference().child("galleryNames");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Gallery p = Gallery.fromJson(event.snapshot.value);
      galleryList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }



  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

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
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: HexColor('#fdd47c'),
                              backgroundImage:
                                  image == null ? null : FileImage(image!),
                            )),
                        Positioned(
                            top: 120,
                            left: 120,
                            child: SizedBox(
                              width: 50,
                              child: RawMaterialButton(
                                  // constraints: BoxConstraints.tight(const Size(45, 45)),
                                  elevation: 10,
                                  fillColor: HexColor('#ffba26'),
                                  child: const Align(
                                      // ignore: unnecessary_const
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 22)),
                                  padding: const EdgeInsets.all(15),
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Choose option',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.amber)),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        pickImageFromDevice();
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          Text('Gallery',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        // pickImageFromCamera();
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons.camera,
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          Text('Camera',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          Text('Remove',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                            )),
                      ],
                    ),
                  ),
                  
                 DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),

                        // Step 3.
                        value: dropdownValue,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_drop_down,
                              color: Colors.grey),
                        ),

                        // Step 4.
                        items: keyslist.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 118, 118)),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
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
                      controller: modelController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'موديل السيارة',
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
                        hintText: 'الألوان المتوفرة',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: capacityController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'سعة الموتور',
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
                        hintText: 'سعر السيارة',
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
                        String galleryName = dropdownValue;
                        String name = nameController.text.trim();
                        String model = modelController.text.trim();
                        String color = colorController.text.trim();
                        String capacity = capacityController.text.trim();
                        String price = priceController.text.trim();

                        if (galleryName.isEmpty ||
                            model.isEmpty ||
                            color.isEmpty ||
                            capacity.isEmpty ||
                            price.isEmpty ||
                            imageUrl.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          int date = DateTime.now().millisecondsSinceEpoch;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('cars').child(galleryName);

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'galleryName': galleryName,
                            'name': name,
                            'model': model,
                            'color': color,
                            'capacity': capacity,
                            'price': price,
                            'imageUrl': imageUrl,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child:
                          Text('أضافة', style: TextStyle(color: Colors.white)),
                    ),
                  ),
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
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة السيارة"),
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
