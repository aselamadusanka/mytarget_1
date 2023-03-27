import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/target/create.dart';
import 'package:flutter_application_1/tabs/ChartPage.dart';
import 'package:flutter_application_1/tabs/HistoryPage.dart';
import 'package:flutter_application_1/tabs/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyTarget',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  List<Widget> tabs = [];
  late Widget page;
  bool pageAssigned = false;

  @override
  Widget build(BuildContext context) {
    tabs.add(const HomePage());
    tabs.add(ChartPage());
    tabs.add(const HistoryPage());

    return Scaffold(
      appBar: AppBar(
        title: const Text("MY TARGET"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            page = const TargetCreate();
            pageAssigned = true;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("YOUR NAME HERE"),
              decoration: BoxDecoration(
                  color: Colors
                      .amber), //com.industrialmaster.flutter_application_1
            ),
            ListTile(
              title: const Text("Collection History"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("My Profile"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Log Out"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: pageAssigned ? page : tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            pageAssigned = false;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "CHARTS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "HISTORY",
          ),
        ],
      ),
    );
  }
}
