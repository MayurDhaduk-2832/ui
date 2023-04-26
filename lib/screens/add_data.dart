import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/database_helper.dart';
import 'package:ui/screens/print_data.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => InsertDataState();
}

class InsertDataState extends State<InsertData> {
  TextEditingController stName = TextEditingController();
  TextEditingController stAge = TextEditingController();
  TextEditingController stAddress = TextEditingController();
  TextEditingController stMath = TextEditingController();
  TextEditingController stScience = TextEditingController();
  TextEditingController stEnglish = TextEditingController();
  TextEditingController stComputer = TextEditingController();

  bool nvalidate = false;
  bool avalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(top: 28, left: 28.0),
            child: Text(
              'Enter Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 28, right: 28),
            child: TextField(
              controller: stName,
              maxLength: 20,
              decoration: InputDecoration(
                  errorText: nvalidate ? "Enter Name" : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 28),
            child: Text('Enter Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28, top: 28),
            child: TextField(
              maxLength: 100,
              controller: stAddress,
              decoration: InputDecoration(
                  errorText: avalidate ? "Enter Address" : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SubList({'name': 'age', 'stName': stAge}),
          const Padding(
            padding: EdgeInsets.only(top: 28, left: 28),
            child: Text(
              'Enter Subjects Marks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SubList({
            'name': 'Math',
            'stName': stMath,
          }),
          SubList({
            'name': 'Science',
            'stName': stScience,
          }),
          SubList({
            'name': 'English',
            'stName': stEnglish,
          }),
          SubList({
            'name': 'Computer',
            'stName': stComputer,
          }),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  stName.text.isEmpty ? nvalidate = true : nvalidate = false;
                  stAddress.text.isEmpty ? avalidate = true : avalidate = false;
                  setState(() {});
                  if (!nvalidate && !avalidate) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrintData(),
                      ),
                    );
                    String name = stName.text.toString();
                    String age = stAge.text.toString();
                    String address = stAddress.text.toString();
                    String math = stMath.text.toString();
                    String sci = stScience.text.toString();
                    String eng = stEnglish.text.toString();
                    String comp = stComputer.text.toString();
                    final dbHelper = DBHelper();
                    await dbHelper.insertData({
                      'name': name,
                      'age': age,
                      'address': address,
                      'math': math,
                      'sci': sci,
                      'eng': eng,
                      'comp': comp
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Enter Your Details")));
                  }
                },
                child: const Text('Add')),
          ),
        ]),
      ),
    );
  }
}

class SubList extends StatelessWidget {
  Map<String, dynamic> data;

  SubList(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, top: 28, right: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data['name'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.only(bottom: 3, left: 7),
            height: 35,
            width: 100,
            child: Center(
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],
                keyboardType: TextInputType.number,
                controller: data['stName'],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
