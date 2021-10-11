class HomeModel {
  late final bool status;
  late final Null message;
  late final Data data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final List<Banners> banners;
  late final List<Products> products;
  late final String ad;

  Data.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    ad = json['ad'];
  }
}

class Banners {
  late final int id;
  late final String image;
  late final Null category;
  late final Null product;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = null;
    product = null;
  }
}

class Products {
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final String description;
  late final List<String> images;
  late final bool inFavorites;
  late final bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
