class FoodItem {
  String description;
  String name;
  String photo;
  String price;

  FoodItem({
    this.description,
    this.name,
    this.photo,
    this.price,
  });
  FoodItem.fromMap(Map map) {
    description = map['description'];
    name = map['name'];
    photo = map['photo'];
    price = map['price'];
  }
}
