import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'geo.dart';

@immutable
class Hospital {
  final String? name;
  final String? address;
  final String? phone;
  final Geo? geo;
  final String? logo;
  final List<String>? image;

  const Hospital({
    this.name,
    this.address,
    this.phone,
    this.geo,
    this.logo,
    this.image,
  });

  @override
  String toString() {
    return 'Hospital(name: $name, address: $address, phone: $phone, geo: $geo, logo: $logo, image: $image)';
  }

  factory Hospital.fromModal(Map<String, dynamic> data) => Hospital(
        name: data['name'] as String?,
        address: data['address'] as String?,
        phone: data['phone'] as String?,
        geo: data['geo'] == null
            ? null
            : Geo.fromModal(data['geo'] as Map<String, dynamic>),
        logo: data['logo'] as String?,
        image: (data['image'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toModal() => {
        'name': name,
        'address': address,
        'phone': phone,
        'geo': geo?.toModal(),
        'logo': logo,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hospital].
  factory Hospital.fromJson(String data) {
    return Hospital.fromModal(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hospital] to a JSON string.
  String toJson() => json.encode(toModal());

  Hospital copyWith({
    String? name,
    String? address,
    String? phone,
    Geo? geo,
    String? logo,
    List<String>? image,
  }) {
    return Hospital(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      geo: geo ?? this.geo,
      logo: logo ?? this.logo,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Hospital) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toModal(), toModal());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      geo.hashCode ^
      logo.hashCode ^
      image.hashCode;
}
