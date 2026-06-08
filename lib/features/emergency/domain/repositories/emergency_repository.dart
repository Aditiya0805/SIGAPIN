import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/emergency_signal.dart';

abstract class EmergencyRepository {
  Future<Either<Failure, void>> sendEmergencySignal(EmergencySignal signal);
  Future<Either<Failure, List<EmergencySignal>>> getUnsyncedSignals();
  Future<Either<Failure, void>> syncOfflineSignals();
}
