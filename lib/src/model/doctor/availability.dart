import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Availability {
  final bool? whatsapp;

  const Availability({this.whatsapp});

  @override
  String toString() => 'Availability(whatsapp: $whatsapp)';

  factory Availability.fromModel(Map<String, dynamic> data) => Availability(
        whatsapp: data['whatsapp'] as bool?,
      );

  Map<String, dynamic> toModel() => {
        'whatsapp': whatsapp,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Availability].
  factory Availability.fromJson(String data) {
    return Availability.fromModel(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Availability] to a JSON string.
  String toJson() => json.encode(toModel());

  Availability copyWith({
    bool? whatsapp,
  }) {
    return Availability(
      whatsapp: whatsapp ?? this.whatsapp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Availability) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toModel(), toModel());
  }

  @override
  int get hashCode => whatsapp.hashCode;
}
