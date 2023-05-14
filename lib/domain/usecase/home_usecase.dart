import 'package:antiquities/data/network/failure.dart';
import 'package:antiquities/domain/models/models.dart';
import 'package:antiquities/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
