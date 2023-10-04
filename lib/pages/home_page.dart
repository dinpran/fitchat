import 'package:fitchat/auth/login_page.dart';
import 'package:fitchat/auth/profile_page.dart';
import 'package:fitchat/helper/helper_function.dart';
import 'package:fitchat/pages/back_page.dart';
import 'package:fitchat/pages/bicep_page.dart';
import 'package:fitchat/pages/calesthics_page.dart';
import 'package:fitchat/pages/chat_pages.dart';
import 'package:fitchat/pages/leg_page.dart';
import 'package:fitchat/pages/rest_page.dart';
import 'package:fitchat/pages/shouler_page.dart';
import 'package:fitchat/pages/tricep_page.dart';
import 'package:fitchat/services/auth_service.dart';
import 'package:fitchat/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusername();
    _initBannerAd();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-8996334303873561/1669351107',
        listener: BannerAdListener(
            onAdLoaded: (ad) {
              setState(() {
                _isAdLoaded = true;
              });
            },
            onAdFailedToLoad: ((ad, error) {})),
        request: AdRequest());
    _bannerAd.load();
  }

  getusername() {
    HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authservice = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    nextScreen(context, ChatPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/chest.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Chest")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, BackPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/back.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Back")
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    nextScreen(context, Shoulder());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/shoulders.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Shoulder")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, TricepPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/triceps.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Triceps")
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    nextScreen(context, BicepPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/biceps.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Biceps")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, LegPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/legs.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Legs")
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    nextScreen(context, RestPage());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          "Rest\n  &\nChill",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        )),
                        height: 250,
                        width: 200,
                      ),
                      Text("Rest")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, Calesthics());
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/calesthenics.jpeg",
                          height: 250,
                          width: 200,
                        ),
                      ),
                      Text("Calisthenics")
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Icon(
                Icons.person,
                size: 155,
                color: Colors.grey,
              ),
            ),
            Text(username),
            ListTile(
              onTap: () {
                nextScreen(context, ProfilePage());
              },
              title: Text("Profile"),
              leading: Icon(Icons.person),
            ),
            ListTile(
              onTap: () async {
                await _authservice.signout();
                nextScreenReplacement(context, LoginPage());
              },
              title: Text("Logout"),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      bottomNavigationBar: _isAdLoaded
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
    );
  }
}

// GestureDetector(
//               onTap: () {
//                 nextScreen(context, ChatPage());
//               },
//               child: SizedBox(
//                   width: double.infinity,
//                   child: Container(
//                     child: Text("CHEST"),
//                   ))),