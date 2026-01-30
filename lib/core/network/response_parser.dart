import 'package:dio/dio.dart';

/// response.asList(Model.fromJson) / response.asObject(Model.fromJson)
extension ResponseParser on Response {
  List<T> asList<T>(T Function(Map<String, dynamic>) fromJson) {
    final list = data;
    if (list == null) return [];
    return (list as List).map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  T asObject<T>(T Function(Map<String, dynamic>) fromJson) {
    final map = data as Map<String, dynamic>?;
    if (map == null) throw Exception('Empty response');
    return fromJson(map);
  }
}
