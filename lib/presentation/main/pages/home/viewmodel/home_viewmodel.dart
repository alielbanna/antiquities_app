import 'dart:async';
import 'dart:ffi';
import 'package:antiquities/domain/models/models.dart';
import 'package:antiquities/domain/usecase/home_usecase.dart';
import 'package:antiquities/presentation/base/baseviewmodel.dart';
import 'package:antiquities/presentation/common/state_renderer/state_renderer.dart';
import 'package:antiquities/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    if (_dataStreamController.isClosed) {
      return;
    }

    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              if (!_dataStreamController.isClosed)
                {
                  inputState.add(ErrorState(
                      StateRendererType.fullScreenErrorState, failure.message))
                }
            }, (homeObject) {
      // right -> data (success)
      if (!_dataStreamController.isClosed) {
        inputState.add(ContentState());
        inputHomeData.add(HomeViewObject(homeObject.data.products,
            homeObject.data.categories, homeObject.data.banners));
      }
    });
  }

  @override
  void dispose() {
    if (!_dataStreamController.isClosed) {
      _dataStreamController.close();
    }
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Product> products;
  List<Category> categories;
  List<BannerAd> banners;

  HomeViewObject(this.products, this.categories, this.banners);
}
