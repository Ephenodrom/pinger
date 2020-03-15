import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinger/model/user_settings.dart';

part 'ping_session.freezed.dart';
part 'ping_session.g.dart';

@freezed
abstract class PingHost with _$PingHost {
  factory PingHost({
    @required String name,
    String ip,
  }) = _PingHost;

  factory PingHost.fromJson(Map<String, dynamic> json) =>
      _$PingHostFromJson(json);
}

@freezed
abstract class PingSession with _$PingSession {
  factory PingSession({
    @required int id,
    @required PingHost host,
    @required DateTime timestamp,
    @required Duration duration,
    @required PingResults results,
    @required PingSettings settings,
  }) = _PingSession;

  factory PingSession.fromJson(Map<String, dynamic> json) =>
      _$PingSessionFromJson(json);
}

@freezed
abstract class PingResults with _$PingResults {
  factory PingResults({
    @required List<double> values,
    @required PingStats stats,
  }) = _PingResults;

  static PingResults fromValues(List<double> values) {
    if (values?.isNotEmpty != true)
      throw ArgumentError("Ping values cannot be null or empty");
    double min = double.infinity;
    double max = double.negativeInfinity;
    double sum = 0.0;
    values.forEach((it) {
      sum += it;
      min = math.min(min, it);
      max = math.max(max, it);
    });
    return PingResults(
      values: values,
      stats: PingStats(
        min: min,
        max: max,
        mean: sum / values.length,
      ),
    );
  }

  factory PingResults.fromJson(Map<String, dynamic> json) =>
      _$PingResultsFromJson(json);
}

@freezed
abstract class PingStats with _$PingStats {
  factory PingStats({
    @required double min,
    @required double max,
    @required double mean,
  }) = _PingStats;

  factory PingStats.fromJson(Map<String, dynamic> json) =>
      _$PingStatsFromJson(json);
}
