// To parse this JSON data, do
//
//     final fundUser = fundUserFromJson(jsonString);

import 'dart:convert';

FundUser fundUserFromJson(String str) => FundUser.fromJson(json.decode(str));

String fundUserToJson(FundUser data) => json.encode(data.toJson());

class FundUser {
  FundUser({
    this.success,
    this.balance,
    this.transactions,
  });

  final bool success;
  final String balance;
  final Transactions transactions;

  factory FundUser.fromJson(Map<String, dynamic> json) => FundUser(
    success: json["success"] == null ? null : json["success"],
    balance: json["balance"] == null ? null : json["balance"],
    transactions: json["transactions"] == null ? null : Transactions.fromJson(json["transactions"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "balance": balance == null ? null : balance,
    "transactions": transactions == null ? null : transactions.toJson(),
  };
}

class Transactions {
  Transactions({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  final int currentPage;
  final List<dynamic> data;
  final String firstPageUrl;
  final dynamic from;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from,
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
  };
}
