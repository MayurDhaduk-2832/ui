import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/database_helper.dart';
import 'package:ui/screens/add_data.dart';
import 'package:ui/screens/splash_screen.dart';
import 'package:ui/screens/update_screen.dart';

import 'login_screen.dart';

class PrintData extends StatefulWidget {
  const PrintData({super.key});

  @override
  State<PrintData> createState() => _PrintDataState();
}

class _PrintDataState extends State<PrintData> {
  List<Map<String, dynamic>>? result = [];

  @override
  void initState() {
    super.initState();
    query();
  }

  Future<List<Map<String, dynamic>>> query() async {
    final dbHelper = DBHelper();
    return result = await dbHelper.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students Data'), actions: [
        IconButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
              var pref = await SharedPreferences.getInstance();
              pref.setBool(SplashScreenState.LOGINKEY, false);
              setState(() {});
            },
            icon: const Icon(Icons.logout))
      ]),
      body: FutureBuilder(
        future: query(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: result!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {});
                    showDialog(
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NAME : ${result![index]['name']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Age : ${result![index]['age']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "ADDRESS : ${result![index]['address']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "MATH : ${result![index]['math']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "SCIENCE : ${result![index]['sci']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "ENGLISH : ${result![index]['eng']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "COMPUTER : ${result![index]['comp']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                  child: ListTile(
                      leading: CircleAvatar(
                          child: Text(result![index]['id'].toString())),
                      title: Text(
                        result![index]['name'],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      trailing: Wrap(
                        spacing: 5,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateScreen(
                                          result![index]['id'],
                                          result![index]['name'],
                                          result![index]['address'],
                                          result![index]['math'],
                                          result![index]['sci'],
                                          result![index]['eng'],
                                          result![index]['comp'],
                                          result![index]['age']),
                                    ));
                              },
                              icon: const Icon(Icons.edit_outlined)),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      height: 150,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Are you sure ??',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    final dbHelper = DBHelper();
                                                    await dbHelper.deleteData(
                                                        result![index]['id']);
                                                    result!
                                                        .remove(result![index]);
                                                    setState(() {});
                                                  },
                                                  child: const Text('YES')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: const Text('NO'))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InsertData(),
              ));
        },
      ),
    );
  }

  void getVal() async {
    var pref = await SharedPreferences.getInstance();
    var getEmail = pref.getString('email');
    setState(() {});
  }
}
