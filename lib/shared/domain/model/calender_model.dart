

import 'package:equatable/equatable.dart';

class CalendarModel extends Equatable {
  int? id;
  String? title;
  String? description;
  String? location;
  int? day;
  int? month;
  int? year;
  int? color;
  int? millisecond;
  String? startTime;
  String? endTime;

  CalendarModel({
    this.id,
    this.title,
    this.description,
    this.day,
    this.month,
    this.year,
    this.color,
    this.millisecond,
    this.startTime,
    this.endTime,
    this.location,
  });

  // copyWith method
  CalendarModel copyWith({
    int? id,
    String? title,
    String? description,
    int? day,
    int? month,
    int? year,
    int? color,
    int? millisecond,
    String? startTime,
    String? endTime,
    String? location,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      color: color ?? this.color,
      millisecond: millisecond ?? this.millisecond,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'day': day,
      'month': month,
      'year': year,
      'color': color,
      'millisecond': millisecond,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
    };
  }

  // fromJson method
  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      day: json['day'] ?? 0,
      month: json['month'] ?? 0,
      year: json['year'] ?? 0,
      color: json['color'] ?? 0,
      millisecond: json['millisecond'] ?? 0,
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "0",
      location: json['location'] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    day,
    month,
    year,
    color,
    millisecond,
    startTime,
    endTime,
    location
  ];
}
