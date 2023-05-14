import 'package:antiquities/data/network/failure.dart';
import 'package:antiquities/domain/models/models.dart';
import 'package:antiquities/domain/repository/repository.dart';
import 'package:antiquities/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
