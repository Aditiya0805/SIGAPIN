import 'package:geolocator/geolocator.dart';
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

class LocationService {
  Future<Either<Failure, Position>> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Left(ServerFailure('Location services are disabled.'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left(ServerFailure('Location permissions are denied'));
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return const Left(ServerFailure('Location permissions are permanently denied, we cannot request permissions.'));
    } 

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        )
      );
      return Right(position);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
