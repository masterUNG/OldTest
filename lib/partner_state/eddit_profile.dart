import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/alertdialog/errorupload_profilePic.dart';
import 'package:joelfindtechnician/alertdialog/updateprofile_success.dart';
import 'package:joelfindtechnician/models/user_model.dart';
import 'package:joelfindtechnician/state/community_page.dart';
import 'package:joelfindtechnician/partner_state/home_page.dart';
import 'package:joelfindtechnician/partner_state/mywallet.dart';
import 'package:joelfindtechnician/partner_state/partner_aboutus.dart';
import 'package:joelfindtechnician/partner_state/partner_contactus.dart';
import 'package:joelfindtechnician/partner_state/partner_howtouseapp.dart';
import 'package:joelfindtechnician/partner_state/partner_notification.dart';
import 'package:joelfindtechnician/partner_state/partner_orderhistory.dart';
import 'package:joelfindtechnician/partner_state/partner_signin.dart';
import 'package:joelfindtechnician/partner_state/partner_termandconditon.dart';
import 'package:joelfindtechnician/partner_state/social_service.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';
import 'package:joelfindtechnician/widgets/show_progress.dart';

class EdditProfile extends StatefulWidget {
  const EdditProfile({Key? key}) : super(key: key);

  @override
  _EdditProfileState createState() => _EdditProfileState();
}

class _EdditProfileState extends State<EdditProfile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController img = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  File? image;
  String? imgUrl;
  String? docUserLogin;

  
  

  uploadDatatoFirestore() async {
    if (formKey.currentState!.validate()) {
      if (image == null) {
        if (userModelFirebase!.img == null) {
          showDialog(
              context: context,
              builder: (context) => ErrorUpLoadProfilePic(
                  title: '', discription: '', buttonText: ''));
        } else {
          imgUrl = userModelFirebase!.img;
          updatDataOnFirebase();
        }
      } else {
        // มีการถ่ายรูป
        Random random = Random();
        int i = random.nextInt(1000000);
        var storageImage =
            FirebaseStorage.instance.ref().child('Images/images$i');
        var task = storageImage.putFile(image!);
        imgUrl = await (await task).ref.getDownloadURL();

        updatDataOnFirebase();

        showDialog(
          context: context,
          builder: (context) =>
              UpdateProfileSuccess(title: '', discription: '', buttonText: ''),
        );

        formKey.currentState!.reset();
      }
    }
  }

  Future<Null> updatDataOnFirebase() async {
    Map<String, dynamic> data = {};
    data['name'] = name.text;
    data['about'] = about.text;
    data['img'] = imgUrl;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(docUserLogin)
        .update(data)
        .then((value) => Navigator.pop(context));
  }

  _imageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  _imageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

  UserModelFirebase? userModelFirebase;

  @override
  void initState() {
    super.initState();
    readCurrentProfile(); 
  }

  Future<Null> readCurrentProfile() async {
    await Firebase.initializeApp().then((value) async {
      final userCurrent = FirebaseAuth.instance.currentUser;
      String uidUserCurrent = userCurrent!.uid;
      print('uidUserCurrent ==>> $uidUserCurrent');

      await FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: uidUserCurrent)
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          setState(() {
            docUserLogin = item.id;
            userModelFirebase = UserModelFirebase.fromMap(item.data());
            name.text = userModelFirebase!.name;
            print('about ==> ${userModelFirebase!.about}');

            if (userModelFirebase!.about != null) {
              about.text = userModelFirebase!.about;
            }
          });
        }
      });
    });
  }

  showImageFromFirebase() => NetworkImage(userModelFirebase!.img);

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: buildAppBar(context),
      endDrawer: buildDrawer(context, User),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        userModelFirebase == null
                            ? ShowProgress()
                            : buildAvatar(),
                        SizedBox(
                          height: 30,
                        ),
                        buildName(),
                        SizedBox(
                          height: 15,
                        ),
                        buildAbout(),
                        // buildImage(),
                        Container(margin: EdgeInsets.symmetric(vertical: 36),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.cloud_upload),
                            label: Text('Upload All Image'),
                          ),
                        ),
                        buildSave(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 110,
                left: 200,
                child: RawMaterialButton(
                  elevation: 10,
                  fillColor: Colors.blueGrey,
                  child: Icon(Icons.add_a_photo),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                'Choose Profile Photo',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purpleAccent,
                                ),
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton.icon(
                                    onPressed: () {
                                      _imageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.camera,
                                        color: Colors.purpleAccent),
                                    label: Text('Camera'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      _imageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.purpleAccent,
                                    ),
                                    label: Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  

  Container buildSave() {
    return Container(
      height: 50,
      width: 350,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          uploadDatatoFirestore();
        },
        child: Text(
          'Save',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Container buildAbout() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: about,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter About';
            } else {
              return null;
            }
          },
          maxLines: 10,
          decoration: InputDecoration(
            labelText: "About",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelStyle: GoogleFonts.lato(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar buildAvatar() {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.grey,
      child: CircleAvatar(
        radius: 65,
        backgroundColor: Colors.blueAccent,
        backgroundImage: image == null
            ? userModelFirebase!.img == null
                ? null
                : showImageFromFirebase()
            : FileImage(image!),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text('Eddit Profile'),
    );
  }

  Container buildName() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: name,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter Name';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: "Name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelStyle: GoogleFonts.lato(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context, User User) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              },
              child: DrawerHeader(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 20, backgroundColor: Colors.blue),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          User.email!,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.person_outline,
                ),
                title: Text('Go to services'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommunityPage()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.auto_fix_off,
                ),
                title: Text('Eddit Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EdditProfile()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet_outlined,
                ),
                title: Text('My Wallet'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyWallet()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.notification_important_outlined,
                ),
                title: Text('Notification'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerNotification()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.shopping_bag_outlined,
                ),
                title: Text('Order History'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerOrderHistory()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(Icons.person_pin_circle_sharp),
                title: Text('About Us'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerAboutUs()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.message_outlined,
                ),
                title: Text(
                  'Contact Us',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerContactUs()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.label_important_outlined,
                ),
                title: Text('How to use App'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerHowtoUseApp()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.warning_amber_outlined,
                ),
                title: Text('Term and Conditon'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerTermAndCondiotion()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                ),
                title: Text('SignOut'),
                onTap: () {
                  SocialService().signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PartnerSignin()),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
