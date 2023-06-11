import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Geo {
	final double? lat;
	final double? lng;

	const Geo({this.lat, this.lng});

	@override
	String toString() => 'Geo(lat: $lat, lng: $lng)';

	factory Geo.fromModal(Map<String, dynamic> data) => Geo(
				lat: (data['lat'] as num?)?.toDouble(),
				lng: (data['lng'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toModal() => {
				'lat': lat,
				'lng': lng,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Geo].
	factory Geo.fromJson(String data) {
		return Geo.fromModal(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Geo] to a JSON string.
	String toJson() => json.encode(toModal());

	Geo copyWith({
		double? lat,
		double? lng,
	}) {
		return Geo(
			lat: lat ?? this.lat,
			lng: lng ?? this.lng,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Geo) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toModal(), toModal());
	}

	@override
	int get hashCode => lat.hashCode ^ lng.hashCode;
}
