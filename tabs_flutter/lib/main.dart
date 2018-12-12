import 'package:flutter/material.dart';
import './first.dart' as first;
import './second.dart' as second;
import './third.dart' as third;

void main() {
  runApp(new MaterialApp(
    home: new tabs(),
  ));
}

class tabs extends StatefulWidget {
  @override
  tabsState createState() => new tabsState();
}

class tabsState extends State<tabs> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Tabs"),
        backgroundColor: Colors.teal,
        bottom: new TabBar(
          controller: controller,
            tabs: <Tab>[
              new Tab(text: "View Data",),
              new Tab(text: "Send Data",),
              new Tab(text: "Update Data",),
            ]
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new first.StarWarsData() ,
          new second.Second(),
          new third.Third(),
        ],
      )
    );
  }
}