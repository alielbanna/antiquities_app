//onBoarding models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
    this.title,
    this.subTitle,
    this.image,
  );
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(
    this.sliderObject,
    this.numOfSlides,
    this.currentIndex,
  );
}

// login models

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

//HOME MODELS

class Category {
  int id;
  String title;
  String image;

  Category(this.id, this.title, this.image);
}

class Product {
  int id;
  String title;
  String price;
  String image;

  Product(this.id, this.title, this.price, this.image);
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image, this.link);
}

class HomeData {
  List<Category> categories;
  List<BannerAd> banners;
  List<Product> products;

  HomeData(this.categories, this.banners, this.products);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}
