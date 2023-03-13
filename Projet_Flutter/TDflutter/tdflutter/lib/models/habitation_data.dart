import 'habitation.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';

class HabitationData {
  static final data = [{}, {}];
  static List<Habitation> buildList() {
    List<Habitation> list =
        data.map((item) => Habitation.fromJson(item)).toList();
    return list;
  }
}
