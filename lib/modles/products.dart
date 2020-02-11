class Product {
  int id;
  String name;
  String pharmacyId;
  String price;
  String description;
  String image;
  String createdAt;
  String updatedAt;
  Pharmacy pharmacy;

  Product(
      {this.id,
        this.name,
        this.pharmacyId,
        this.price,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.pharmacy});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pharmacyId = json['pharmacyId'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pharmacy = json['pharmacy'] != null
        ? new Pharmacy.fromJson(json['pharmacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pharmacyId'] = this.pharmacyId;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pharmacy != null) {
      data['pharmacy'] = this.pharmacy.toJson();
    }
    return data;
  }
}

class Pharmacy {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String phone;
  String image;
  String userType;
  String location;
  String lat;
  String long;
  String license;
  String createdAt;
  String updatedAt;

  Pharmacy(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.image,
        this.userType,
        this.location,
        this.lat,
        this.long,
        this.license,
        this.createdAt,
        this.updatedAt});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    image = json['image'];
    userType = json['userType'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    license = json['license'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['userType'] = this.userType;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['license'] = this.license;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}