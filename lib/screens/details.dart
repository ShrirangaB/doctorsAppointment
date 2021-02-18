import 'dart:convert';

import 'package:DoctorAppointments/constants/constantStrings.dart';
import 'package:DoctorAppointments/constants/constantcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

// ignore: missing_return
  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/appointmentList.json");
    final jsonResult = json.decode(jsonData);

// print(jsonResult)
    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

  getSelectedDateAppointments() {
    appointmentData = allData.where((element) {
      print(element);
      Map<String, dynamic> appItem = element;
      return appItem['appointmentDate'] == _selectedValue.toString();
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ConstantColors.oneContainerBlue,
        child: Icon(Icons.add),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                color: ConstantColors.oneContainerBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
//--------------------Icon ham Button
                    IconButton(
                      icon: Icon(Icons.menu_sharp),
                      onPressed: () {},
                      color: Colors.white,
                    ),
//-----------------CircleAvatar
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(ConstantString.circleAvatarImg),
                    ),
//-----------Doctor Name
                    Text(
                      ConstantString.welcome + ' ' + ConstantString.drName,
                      style: GoogleFonts.montserrat(
                          color: ConstantColors.titlewhite, fontSize: 15),
                    ),
//---------------Icon filter Button
                    IconButton(
                      icon: Icon(Icons.filter_list_rounded),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width,
                color: ConstantColors.twoContainerwhite,
                child: ListView(
                  //  physics: NeverScrollableScrollPhysics(),
                  children: [
//--------------------------------DatePicker from Package
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: ConstantColors.calenderBlue,
                      selectedTextColor: ConstantColors.calenderwhite,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          _selectedValue = date;
                          print(_selectedValue);
                          getSelectedDateAppointments();
                        });
                      },
                    ),
//------------------------bottom details card
                    Card(
                      elevation: 30,
                      color: ConstantColors.cardWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: Container(
                        height: 470,
                        child: Center(
                          child: FutureBuilder(
                            future: DefaultAssetBundle.of(context).loadString(
                                "assets/jsonDataBase/patients.json"),
                            builder: (context, snapshot) {
                              // Decode the JSON file
                              var newData =
                                  json.decode(snapshot.data.toString());

                              return ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                newData[index]['name'],
                                                //'Note Title',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                newData[index]['doctorname'],
                                                //'Note Text',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                              Text(
                                                newData[index]['hospital'],
                                                //'Note Text',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                              Text(
                                                newData[index]['date'],
                                                //'Note Text',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            newData[index]['time'],
                                            //'Note Text',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: newData == null ? 0 : newData.length,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
//---------------------------------card for seach bar
          Positioned(
            top: MediaQuery.of(context).size.height * 0.167,
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
                color: ConstantColors.twoContainerwhite,
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.youtube_searched_for),
                            onPressed: () {},
                          ),
                          border: InputBorder.none,
                          hintText: ConstantString.hintTextSP),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card(
//   child: Row(
//     mainAxisAlignment:
//         MainAxisAlignment
//             .spaceBetween,
//     children: <Widget>[
//       Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             newData[index]['name'],
//             //'Note Title',
//             style: TextStyle(
//                 fontWeight:
//                     FontWeight.bold,
//                 fontSize: 22),
//           ),
//           Text(
//             newData[index]['doctorname'],
//             //'Note Text',
//             style: TextStyle(
//                 color: Colors
//                     .grey.shade600),
//           ),
//         ],
//       ),
//       //SizedBox(width: 20),
//       // Container(
//       //   height: 50,
//       //   width: 50,
//       //   child: Image.asset(
//       //       newData[index]['img']),
//       // )
//     ],
//   ),
// );
