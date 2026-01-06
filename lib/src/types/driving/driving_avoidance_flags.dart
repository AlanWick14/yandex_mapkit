part of '../../../yandex_mapkit.dart';

/// Flags to control route avoidance.
class DrivingAvoidanceFlags extends Equatable {
  /// Instructs the router to return routes that avoid toll roads when possible.
  final bool? avoidTolls;

  /// Instructs the router to return routes that avoid unpaved roads when possible.
  final bool? avoidUnpaved;

  /// Instructs the router to return routes that avoid roads in poor conditions when possible.
  final bool? avoidPoorCondition;

  /// Instructs the router to return routes that avoid railway crossings when possible.
  final bool? avoidRailwayCrossing;

  /// Instructs the router to return routes that avoid boat ferries when possible.
  final bool? avoidBoatFerry;

  /// Instructs the router to return routes that avoid ford crossings when possible.
  final bool? avoidFordCrossing;

  /// Instructs the router to return routes that avoid tunnels when possible.
  final bool? avoidTunnel;

  /// Instructs the router to return routes that avoid highways when possible.
  final bool? avoidHighway;

  const DrivingAvoidanceFlags({
    this.avoidTolls,
    this.avoidUnpaved,
    this.avoidPoorCondition,
    this.avoidRailwayCrossing,
    this.avoidBoatFerry,
    this.avoidFordCrossing,
    this.avoidTunnel,
    this.avoidHighway,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'avoidTolls': avoidTolls,
      'avoidUnpaved': avoidUnpaved,
      'avoidPoorCondition': avoidPoorCondition,
      'avoidRailwayCrossing': avoidRailwayCrossing,
      'avoidBoatFerry': avoidBoatFerry,
      'avoidFordCrossing': avoidFordCrossing,
      'avoidTunnel': avoidTunnel,
      'avoidHighway': avoidHighway,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    avoidTolls,
    avoidUnpaved,
    avoidPoorCondition,
    avoidRailwayCrossing,
    avoidBoatFerry,
    avoidFordCrossing,
    avoidTunnel,
    avoidHighway,
  ];

  @override
  bool get stringify => true;
}
