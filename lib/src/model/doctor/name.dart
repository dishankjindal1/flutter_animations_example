import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Name {
	final String? title;
	final String? firstName;
	final String? middleName;
	final String? lastName;

	const Name({this.title, this.firstName, this.middleName, this.lastName});

	@override
	String toString() {
		return 'Name(title: $title, firstName: $firstName, middleName: $middleName, lastName: $lastName)';
	}

	factory Name.fromModel(Map<String, dynamic> data) => Name(
				title: data['title'] as String?,
				firstName: data['first_name'] as String?,
				middleName: data['middle_name'] as String?,
				lastName: data['last_name'] as String?,
			);

	Map<String, dynamic> toModel() => {
				'title': title,
				'first_name': firstName,
				'middle_name': middleName,
				'last_name': lastName,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Name].
	factory Name.fromJson(String data) {
		return Name.fromModel(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Name] to a JSON string.
	String toJson() => json.encode(toModel());

	Name copyWith({
		String? title,
		String? firstName,
		String? middleName,
		String? lastName,
	}) {
		return Name(
			title: title ?? this.title,
			firstName: firstName ?? this.firstName,
			middleName: middleName ?? this.middleName,
			lastName: lastName ?? this.lastName,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Name) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toModel(), toModel());
	}

	@override
	int get hashCode =>
			title.hashCode ^
			firstName.hashCode ^
			middleName.hashCode ^
			lastName.hashCode;
}
