class CartegoryModel {
  int? id;
  String? cartegoryName;
  String? avatarPath;

  CartegoryModel({this.id = 0, this.cartegoryName = "", this.avatarPath = "assets/cartegory.png"});

  Map<String, dynamic> toMap() {
    return {
      "cartegoryName": cartegoryName,
      "avatarPath": avatarPath,
    };
  }
}
