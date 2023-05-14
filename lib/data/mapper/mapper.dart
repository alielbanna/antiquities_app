import 'package:antiquities/core/extensions.dart';
import 'package:antiquities/core/constants.dart';
import 'package:antiquities/data/response/responses.dart';
import 'package:antiquities/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.EMPTY,
      this?.name.orEmpty() ?? Constants.EMPTY,
      this?.numOfNotifications.orZero() ?? Constants.ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.EMPTY,
      this?.email.orEmpty() ?? Constants.EMPTY,
      this?.link.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension CategoriesResponseMapper on CategoryResponse? {
  Category toDomain() {
    return Category(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension ProductResponseMapper on ProductResponse? {
  Product toDomain() {
    return Product(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.price.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Category> categories = (this
                ?.data
                ?.categories
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Category>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Product> productes = (this
                ?.data
                ?.products
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Product>()
        .toList();

    var data = HomeData(categories, banners, productes);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.id?.orZero() ?? Constants.ZERO,
      this?.title?.orEmpty() ?? Constants.empty,
      this?.image?.orEmpty() ?? Constants.empty,
      this?.details?.orEmpty() ?? Constants.empty,
      this?.services?.orEmpty() ?? Constants.empty,
      this?.about?.orEmpty() ?? Constants.empty,
    );
  }
}
