import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:manavasevasangh/domain/entities/user_entity.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity userInfo;
  const HomeScreen({Key key, this.userInfo}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Theme',
            style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          FlutterSwitch(
            width: 70.0,
            height: 35.0,
            toggleSize: 25.0,
            value: status,
            borderRadius: 20.0,
            padding: 1.0,
            activeToggleColor: Color(0xFF6E40C9),
            inactiveToggleColor: Color(0xFF2F363D),
            activeSwitchBorder: Border.all(
              color: Color(0xFF3C1E70),
              width: 4.0,
            ),
            inactiveSwitchBorder: Border.all(
              color: Color(0xFFD1D5DA),
              width: 4.0,
            ),
            activeColor: Color(0xFF271052),
            inactiveColor: Colors.white,
            activeIcon: Icon(
              Icons.nightlight_round,
              size: 18,
              color: Color(0xFFF8E3A1),
            ),
            inactiveIcon: Icon(
              Icons.wb_sunny,
              size: 18,
              color: Color(0xFFFFDF5D),
            ),
            onToggle: (val) {
              setState(() {
                status = val;
                if (val) {
                } else {}
              });
            },
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(10.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 45.0,
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Vishnushankar',
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Theme.of(context).dividerColor,
              ),
              Container(
                height: 100,
                color: Theme.of(context).scaffoldBackgroundColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
