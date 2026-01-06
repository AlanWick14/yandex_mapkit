part of '../../../yandex_mapkit.dart';

/// Options to fine-tune suggest request.
class SuggestOptions extends Equatable {
  /// What type of suggestions to look for
  /// If suggestType is empty, it means to use server-defined types
  final SuggestType suggestType;

  /// Enable word-by-word suggestion items.
  final bool suggestWords;

  /// The server uses the user position to calculate the distance from the user to suggest results.
  final Point? userPosition;

  /// If true, the suggest will return only items from the specified bounds.
  final bool strictBounds;

  const SuggestOptions({
    required this.suggestType,
    this.suggestWords = true,
    this.userPosition,
    this.strictBounds = false,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'suggestWords': suggestWords,
      'userPosition': userPosition?.toJson(),
      'suggestType': suggestType.index,
      'strictBounds': strictBounds,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    suggestType,
    userPosition,
    suggestWords,
    strictBounds,
  ];

  @override
  bool get stringify => true;
}
