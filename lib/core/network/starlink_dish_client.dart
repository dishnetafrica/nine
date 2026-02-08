import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class StarlinkDishTelemetry {
  const StarlinkDishTelemetry({
    required this.uptimeSeconds,
    required this.downlinkMbps,
    required this.uplinkMbps,
    required this.latencyMs,
    required this.packetLoss,
  });

  final int uptimeSeconds;
  final double downlinkMbps;
  final double uplinkMbps;
  final double latencyMs;
  final double packetLoss;
}

class StarlinkDishClient {
  const StarlinkDishClient();

  Future<Result<StarlinkDishTelemetry>> fetchTelemetry({
    required bool isOnStarlinkLan,
  }) async {
    if (!isOnStarlinkLan) {
      return const Failure(
        NetworkException('Starlink dish endpoint is reachable only on local Starlink LAN.'),
      );
    }

    // Placeholder for gRPC-web call implementation using dish gRPC endpoints.
    return const Success(
      StarlinkDishTelemetry(
        uptimeSeconds: 45210,
        downlinkMbps: 164.2,
        uplinkMbps: 18.8,
        latencyMs: 43,
        packetLoss: 0.01,
      ),
    );
  }

  String get endpointHint =>
      '${AppConstants.starlinkDishHost}:${AppConstants.starlinkGrpcPortPrimary}/${AppConstants.starlinkGrpcPortSecondary}';
}
