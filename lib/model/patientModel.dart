class PatientModel {
  int id;
  String name;
  String doctorname;
  String time;
  String hospital;

  PatientModel({this.id, this.name, this.doctorname, this.time, this.hospital});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorname = json['doctorname'];
    time = json['time'];
    hospital = json['hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['doctorname'] = this.doctorname;
    data['time'] = this.time;
    data['hospital'] = this.hospital;
    return data;
  }
}
