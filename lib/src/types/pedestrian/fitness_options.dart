part of '../../../yandex_mapkit.dart';

/// Options for fitness routing (pedestrian/bicycle).
class FitnessOptions extends Equatable {
  /// Avoid steep slopes when building routes.
  final bool? avoidSteep;

  /// Avoid stairs when building routes.
  final bool? avoidStairs;

  const FitnessOptions({this.avoidSteep, this.avoidStairs});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avoidSteep': avoidSteep,
      'avoidStairs': avoidStairs,
    };
  }

  @override
  List<Object?> get props => <Object?>[avoidSteep, avoidStairs];

  @override
  bool get stringify => true;
}
