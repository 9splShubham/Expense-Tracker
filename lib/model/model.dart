class SignUpModel {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? password;

  SignUpModel({this.id, this.userId, this.name, this.email, this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

/// ADD DATA

class AddDataModel {
  int? id;
  String? userId;
  String? date;
  String? time;
  String? type;
  int? amount;
  String? category;
  String? paymentMethod;
  String? status;
  String? note;

  AddDataModel(
      {this.id,
      this.userId,
      this.date,
      this.time,
      this.type,
      this.amount,
      this.category,
      this.paymentMethod,
      this.status,
      this.note});

  AddDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    amount = json['amount'];
    category = json['category'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['note'] = this.note;
    return data;
  }
}
