import 'dart:convert';
import 'package:DoctorAppointments/constants/constantStrings.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class FlightDetailsScreen extends StatefulWidget {
  @override
  _FlightDetailsScreenState createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  final String url = "assets/jsonDataBase/patientss.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

// ignore: missing_return
  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/jsonDataBase/patientss.json");
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

  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _PatientSearchCard = Card(
      elevation: 4.0,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.only(top: 0.0),
        height: 60.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.search),
              title: new TextField(
                decoration: InputDecoration(hintText: "Search Patients"),
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color.fromRGBO(34, 82, 160, 1),
        title: ListTile(
          leading: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.network(ConstantString.circleAvatarImg),
            ),
          ),
          title: Text(
            "Welcome Dr.Sciliaris",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.notification_important,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
//color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              color: Color.fromRGBO(34, 82, 160, 1),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    _PatientSearchCard,
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 50,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color.fromRGBO(34, 82, 160, 1),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            _selectedValue = date;
                            getSelectedDateAppointments();
                          });
                          print(_selectedValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    bottom: false,
                    child: Stack(
                      children: <Widget>[
                        DraggableScrollableSheet(
                          maxChildSize: .8,
                          initialChildSize: .6,
                          minChildSize: .6,
                          builder: (context, scrollController) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.only(
                                  left: 19,
                                  right: 19,
                                  top:
                                      16), //symmetric(horizontal: 19, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "HEMA 54-DEAN (4)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        )
                                      ],
                                    ),
                                    appointmentData != null &&
                                            appointmentData.isNotEmpty
                                        ? ListView.separated(
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color: Colors.black,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: appointmentData.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> item =
                                                  appointmentData[index];
                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                leading: Icon(
                                                  Icons.bookmark,
                                                  color: Colors.green,
                                                ),
                                                title:
                                                    Text(item["patientName"]),
                                                subtitle: Text(
                                                    item["providerName"] +
                                                        "\n" +
                                                        item["status"]),
                                                trailing: Column(
                                                  children: [
                                                    Text(item[
                                                        "appointmentTime"]),
                                                    Spacer(),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '• ',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 14),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: 'Dictation' +
                                                                "" +
                                                                "" +
                                                                item[
                                                                    "dictationStatus"],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            child: Text(
                                            "No Appointments",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey),
                                          )),
                                    Divider(
                                      thickness: .5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
