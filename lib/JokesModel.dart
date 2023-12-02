// To parse this JSON data, do
//
//     final jokesModel = jokesModelFromJson(jsonString);

import 'dart:convert';

JokesModel jokesModelFromJson(String str) => JokesModel.fromJson(json.decode(str));

String jokesModelToJson(JokesModel data) => json.encode(data.toJson());

class JokesModel {
  final String? id;
  final String? status;
  final String? jokeContent;
  final int? jokeNo;
  final List<Usage>? usage;
  final String? createdBy;

  JokesModel({
    this.id,
    this.status,
    this.jokeContent,
    this.jokeNo,
    this.usage,
    this.createdBy,
  });

  factory JokesModel.fromJson(Map<String, dynamic> json) => JokesModel(
    id: json["_id"],
    status: json["status"],
    jokeContent: json["jokeContent"],
    jokeNo: json["jokeNo"],
    usage: json["usage"] == null ? [] : List<Usage>.from(json["usage"]!.map((x) => Usage.fromJson(x))),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "jokeContent": jokeContent,
    "jokeNo": jokeNo,
    "usage": usage == null ? [] : List<dynamic>.from(usage!.map((x) => x.toJson())),
    "created_by": createdBy,
  };
}

class Usage {
  final DateTime? date;
  final int? count;

  Usage({
    this.date,
    this.count,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "count": count,
  };
}
