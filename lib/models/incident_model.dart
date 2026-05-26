class IncidentModel {

  final String title;

  final String date;

  final String time;

  final String latitude;

  final String longitude;

  IncidentModel({

    required this.title,

    required this.date,

    required this.time,

    required this.latitude,

    required this.longitude,
  });

  Map<String, dynamic> toMap() {

    return {

      "title": title,

      "date": date,

      "time": time,

      "latitude": latitude,

      "longitude": longitude,
    };
  }

  factory IncidentModel.fromMap(
    Map<String, dynamic> map,
  ) {

    return IncidentModel(

      title: map["title"],

      date: map["date"],

      time: map["time"],

      latitude: map["latitude"],

      longitude: map["longitude"],
    );
  }
}