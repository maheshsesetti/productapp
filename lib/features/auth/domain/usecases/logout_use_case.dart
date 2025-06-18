import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/error/failures.dart';
import 'package:flutter_riverpod_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod_clean_architecture/features/auth/data/repositories/auth_repository_impl.dart';

class LogoutUseCase {
  final AuthRepository _repository;
  
  LogoutUseCase(this._repository);
  
  Future<Either<Failure, void>> execute() {
    return _repository.logout();
  }
}

// Provider
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repositoryAsync = ref.watch(authRepositoryProvider);
  return repositoryAsync.maybeWhen(
    data: (repository) => LogoutUseCase(repository),
    orElse: () => throw Exception('AuthRepository not available'),
  );
});
