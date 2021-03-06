import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joelfindtechnician/partner_state/eddit_profile.dart';
import 'package:joelfindtechnician/partner_state/mywallet.dart';
import 'package:joelfindtechnician/partner_state/partner_aboutus.dart';
import 'package:joelfindtechnician/partner_state/partner_contactus.dart';
import 'package:joelfindtechnician/partner_state/partner_howtouseapp.dart';
import 'package:joelfindtechnician/partner_state/partner_notification.dart';
import 'package:joelfindtechnician/partner_state/partner_orderhistory.dart';
import 'package:joelfindtechnician/partner_state/partner_termandconditon.dart';

import 'package:joelfindtechnician/partner_state/social_service.dart';
import 'package:joelfindtechnician/partner_state/partner_signin.dart';
import 'package:joelfindtechnician/state/my_referance.dart';
import 'package:joelfindtechnician/state/show_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(height: 8),
                Text(
                  ' ' + User.email!,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 40),
                buildMyProfile(context),
                buildMyRefer(context),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EdditProfile()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_fix_off,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Eddit Profile',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyWallet()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'My Wallet',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerNotification()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.notification_important_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Notification',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerOrderHistory()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Order History',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerAboutUs()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_pin_circle_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'About Us',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerContactUs()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Contact Us',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerHowtoUseApp()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.label_important_outline,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'How to use App',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PartnerTermAndCondiotion()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Term and condition',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        SocialService().signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerSignin()),
                            (route) => false);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'SignOut',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildMyProfile(BuildContext context) {
    return Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowProfile()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'My Profile',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              );
  } // ??????????????????

  Container buildMyRefer(BuildContext context) {
    return Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyReferance()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.build,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'My Referance',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              );
  } // ??????????????????



}
