import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'availability.dart';
import 'name.dart';

@immutable
class Doctor {
  final Name? name;
  final String? phone;
  final Availability? availability;
  final String? profile;

  const Doctor({this.name, this.phone, this.availability, this.profile});

  @override
  String toString() {
    return 'Doctor(name: $name, phone: $phone, availability: $availability, profile: $profile)';
  }

  factory Doctor.fromModal(Map<String, dynamic> data) => Doctor(
        name: data['name'] == null
            ? null
            : Name.fromModel(data['name'] as Map<String, dynamic>),
        phone: data['phone'] as String?,
        availability: data['availability'] == null
            ? null
            : Availability.fromModel(
                data['availability'] as Map<String, dynamic>),
        profile: data['profile'] as String?,
      );

  Map<String, dynamic> toModel() => {
        'name': name?.toModel(),
        'phone': phone,
        'availability': availability?.toModel(),
        'profile': profile,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Doctor].
  factory Doctor.fromJson(String data) {
    return Doctor.fromModal(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Doctor] to a JSON string.
  String toJson() => json.encode(toModel());

  Doctor copyWith({
    Name? name,
    String? phone,
    Availability? availability,
    String? profile,
  }) {
    return Doctor(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      availability: availability ?? this.availability,
      profile: profile ?? this.profile,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Doctor) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toModel(), toModel());
  }

  @override
  int get hashCode =>
      name.hashCode ^ phone.hashCode ^ availability.hashCode ^ profile.hashCode;
}
