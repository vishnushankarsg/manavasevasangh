import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:manavasevasangh/presentation/screen/DonationCreateScreen.dart';
import 'package:manavasevasangh/presentation/screen/MainScreen.dart';
import 'package:manavasevasangh/presentation/screen/ProfileSetupScreen.dart';
import 'package:manavasevasangh/presentation/screen/ReferalCreation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  static const double maxSlide = 255;
  static const dragRightStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;
  int currentPage = 0;
  String uid = FirebaseAuth.instance.currentUser.uid;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: _HomeScreenState.duration);
    super.initState();
  }

  void close() => _controller.reverse();

  void open() => _controller.forward();

  void toggle() {
    if (_controller.isCompleted) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails startDetails) {
    bool isDraggingFromLeft = _controller.isDismissed &&
        startDetails.globalPosition.dx < dragRightStartVal;
    bool isDraggingFromRight = _controller.isCompleted &&
        startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDraggingFromLeft || isDraggingFromRight;
  }

  void _onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag == false) {
      return;
    }
    double delta = updateDetails.primaryDelta / maxSlide;
    _controller.value += delta;
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }

    double _kMinFlingVelocity = 365.0;
    double dragVelocity = dragEndDetails.velocity.pixelsPerSecond.dx.abs();

    if (dragVelocity >= _kMinFlingVelocity) {
      double visualVelocityInPx = dragEndDetails.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _controller.fling(velocity: visualVelocityInPx);
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final double categoryHeight = size.height * 0.30;

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          double animationVal = _controller.value;
          double translateVal = animationVal * maxSlide;
          double scaleVal = 1 - (animationVal * 0.3);
          return Stack(
            children: <Widget>[
              CustomDrawer(),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..translate(translateVal)
                  ..scale(scaleVal),
                child: GestureDetector(
                    onTap: () {
                      if (_controller.isCompleted) {
                        close();
                      }
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: SafeArea(
                        child: Scaffold(
                            appBar: AppBar(
                              elevation: 3,
                              toolbarHeight: 60,
                              title: Text(
                                'ManavaSevaSangh',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              centerTitle: true,
                              leading: Builder(
                                builder: (BuildContext appBarContext) {
                                  return IconButton(
                                      onPressed: () {
                                        open();
                                      },
                                      icon: Icon(Icons.menu));
                                },
                              ),
                            ),
                            body: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Center(
                                child: _getPage(currentPage),
                              ),
                            ),
                            bottomNavigationBar: FancyBottomNavigation(
                              tabs: [
                                TabData(
                                  iconData: Icons.favorite,
                                  title: "",
                                  onclick: () {
                                    final FancyBottomNavigationState fState =
                                        bottomNavigationKey.currentState
                                            as FancyBottomNavigationState;
                                    fState.setPage(0);
                                  },
                                ),
                                TabData(
                                  iconData: Icons.add,
                                  title: "",
                                  onclick: () {
                                    final FancyBottomNavigationState fState =
                                        bottomNavigationKey.currentState
                                            as FancyBottomNavigationState;
                                    fState.setPage(1);
                                  },
                                ),
                                TabData(
                                  iconData: Icons.comment,
                                  title: "",
                                  onclick: () {
                                    final FancyBottomNavigationState fState =
                                        bottomNavigationKey.currentState
                                            as FancyBottomNavigationState;
                                    fState.setPage(2);
                                  },
                                ),
                              ],
                              initialSelection: 0,
                              key: bottomNavigationKey,
                              barBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              activeIconColor: Colors.white,
                              circleColor: Colors.orange,
                              inactiveIconColor: Colors.orange[600],
                              onTabChangedListener: (position) {
                                setState(() {
                                  currentPage = position;
                                });
                              },
                            )),
                      ),
                    )),
              ),
            ],
          );
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Scaffold(
          appBar: AppBar(
            title: Text('Donation List'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            child: GetCategory(),
          ),
        );
      case 1: //TODO : pagetwo
        return Scaffold(
          appBar: AppBar(
            title: Text('My Application'),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DonationRegister()),
                  (route) => false);
            },
            elevation: 4.sp,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.add),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Donations')
                .where('userUid',
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .orderBy('endDate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return Container(
                padding: EdgeInsets.all(5.sp),
                height: 600.h,
                child: ListView(
                  children: documents
                      .map((doc) => Card(
                            elevation: 3.sp,
                            child: Container(
                              height: 180.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.sp),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    child: Text(doc['title'],
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50.r,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: new SizedBox(
                                            width: 80.w,
                                            height: 80.h,
                                            child: Image.network(
                                              doc['imageUrl'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              Text(
                                                doc['fullName'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Need's : ₹ ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              Text(doc['needs'])
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                        color: Colors.greenAccent,
                                        child: Text('Update',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                            textAlign: TextAlign.center),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DonationRegister()),
                                              (route) => false);
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ),
        );
      default: //TODO : pagethree
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the Communication page"),
            TextButton(
              child: Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            )
          ],
        );
    }
  }
}

class GetCategory extends StatefulWidget {
  @override
  _GetCategoryState createState() => _GetCategoryState();
}

class _GetCategoryState extends State<GetCategory> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    // <1> Use StreamBuilder
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: FirebaseFirestore.instance
              .collection('Categories')
              .where('status', isEqualTo: true)
              .orderBy('itemName', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5.sp),
                  height: 120.h,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: documents
                          .map((doc) => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: 150.w,
                                  height: 150.h,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 2.sp,
                                      child: Center(
                                        child: Text(
                                          doc['itemName'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                Container(
                  padding: EdgeInsets.all(5.sp),
                  height: 550.h,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Donations')
                        .where('isVerified', isEqualTo: true)
                        .orderBy('endDate', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;
                      return ListView(
                        children: documents
                            .map((doc) => Card(
                                  elevation: 3.sp,
                                  child: Container(
                                    height: 180.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5.sp),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          child: Text(doc['title'],
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 50.r,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: ClipOval(
                                                child: new SizedBox(
                                                  width: 80.w,
                                                  height: 80.h,
                                                  child: Image.network(
                                                    doc['imageUrl'],
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Name :',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                    Text(
                                                      doc['fullName'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Need's : ₹ ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                    Text(doc['needs'])
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                  color: Colors.redAccent,
                                                  child: Text(
                                                    'View',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                  onPressed: () {}),
                                            ),
                                            Expanded(
                                              child: MaterialButton(
                                                  color: Colors.greenAccent,
                                                  child: Text('Donate',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3,
                                                      textAlign:
                                                          TextAlign.center),
                                                  onPressed: () {}),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 6.sp,
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 120.w,
                            height: 120.h,
                            child: FutureBuilder<String>(
                              future: SharedPreferencesHelper.getPhotoUrl(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return snapshot.hasData
                                    ? Image.network(snapshot.data,
                                        fit: BoxFit.fitWidth)
                                    : Container();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder<String>(
                      future: SharedPreferencesHelper.getFullName(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return snapshot.hasData
                            ? Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Container();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 0.w, 10.h),
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserProfileRegister()));
                },
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Update'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Transactions'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ReferalCreation()));
                },
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Add Referal'),
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Confirmation',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        content: Text(
                            'Do you want to Logout?\n\nThis may remove your complete profile details.'),
                        actions: <Widget>[
                          new TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('uid');
                              prefs.remove('phoneNumber');
                              prefs.remove('fullName');

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainScreen()));
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.redAccent),
                  title: Text('Logout'),
                ),
              ),
              Divider(
                thickness: 2.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SharedPreferencesHelper {
  static Future<String> getPhotoUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('photoUrl');
  }

  static Future<String> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fullName');
  }

  static Future<String> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}



// Container(
//                 width: 150,
//                 margin: EdgeInsets.only(right: 20),
//                 height: categoryHeight,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 3.0,
//                           offset: Offset(3, 3),
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onPrimary
//                               .withOpacity(0.5)),
//                       BoxShadow(
//                           blurRadius: 3.0,
//                           offset: Offset(-3, -3),
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onSecondary
//                               .withOpacity(0.7))
//                     ]),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "Most\nEmergency",
//                         style: TextStyle(
//                             color: Theme.of(context).textTheme.bodyText1.color,
//                             fontSize:
//                                 Theme.of(context).textTheme.bodyText1.fontSize),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Text(
//                         "25 Needs",
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.orange,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),