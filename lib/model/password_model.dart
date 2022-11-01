class PasswordModel {
  int id;
  String? name;
  String? siteIcon;
  String? site;
  String? user;
  String? pass;
  int? cartegory;
  String? dateAdded;

  PasswordModel(
      {this.id = 0,
      this.name = "",
      this.siteIcon = "assets/computer.png",//need to add a default icon
      this.site = "",
      this.user = "",
      this.pass = "",
      this.cartegory = 0,
      this.dateAdded = ""});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "site": site,
      "siteIcon": siteIcon,
      "user": user,
      "pass": pass,
      "cartegory": cartegory,
      "dateAdded": dateAdded,
    };
  }
}
