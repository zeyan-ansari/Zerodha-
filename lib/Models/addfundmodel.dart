// To parse this JSON data, do
//
//     final addFund = addFundFromJson(jsonString);

import 'dart:convert';

AddFund addFundFromJson(String str) => AddFund.fromJson(json.decode(str));

String addFundToJson(AddFund data) => json.encode(data.toJson());

class AddFund {
  AddFund({
    this.success,
    this.message,
    this.balance,
  });

  final bool success;
  final String message;
  final String balance;

  factory AddFund.fromJson(Map<String, dynamic> json) => AddFund(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    balance: json["balance"] == null ? null : json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "balance": balance == null ? null : balance,
  };
}
