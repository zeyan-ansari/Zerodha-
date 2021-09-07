// To parse this JSON data, do
//
//     final portfolioUser = portfolioUserFromJson(jsonString);

import 'dart:convert';

PortfolioUser portfolioUserFromJson(String str) => PortfolioUser.fromJson(json.decode(str));

String portfolioUserToJson(PortfolioUser data) => json.encode(data.toJson());

class PortfolioUser {
  PortfolioUser({
    this.success,
    this.data,
  });

  final bool success;
  final Data data;

  factory PortfolioUser.fromJson(Map<String, dynamic> json) => PortfolioUser(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int currentPage;
  final List<Datum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "links": links == null ? null : List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl == null ? null : nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class Datum {
  Datum({
    this.id,
    this.tradingsymbol,
    this.status,
    this.dateAdded,
    this.dateUpdated,
    this.exchange,
    this.transactionType,
    this.orderType,
    this.quantity,
    this.product,
    this.price,
  });

  final int id;
  final Tradingsymbol tradingsymbol;
  final Status status;
  final DateTime dateAdded;
  final DateTime dateUpdated;
  final Exchange exchange;
  final TransactionType transactionType;
  final String orderType;
  final String quantity;
  final Product product;
  final String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    tradingsymbol: json["tradingsymbol"] == null ? null : tradingsymbolValues.map[json["tradingsymbol"]],
    status: json["status"] == null ? null : statusValues.map[json["status"]],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateUpdated: json["date_updated"] == null ? null : DateTime.parse(json["date_updated"]),
    exchange: json["exchange"] == null ? null : exchangeValues.map[json["exchange"]],
    transactionType: json["transaction_type"] == null ? null : transactionTypeValues.map[json["transaction_type"]],
    orderType: json["order_type"] == null ? null : json["order_type"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    product: json["product"] == null ? null : productValues.map[json["product"]],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "tradingsymbol": tradingsymbol == null ? null : tradingsymbolValues.reverse[tradingsymbol],
    "status": status == null ? null : statusValues.reverse[status],
    "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
    "date_updated": dateUpdated == null ? null : dateUpdated.toIso8601String(),
    "exchange": exchange == null ? null : exchangeValues.reverse[exchange],
    "transaction_type": transactionType == null ? null : transactionTypeValues.reverse[transactionType],
    "order_type": orderType == null ? null : orderType,
    "quantity": quantity == null ? null : quantity,
    "product": product == null ? null : productValues.reverse[product],
    "price": price == null ? null : price,
  };
}

enum Exchange { BSE, XNSE }

final exchangeValues = EnumValues({
  "BSE": Exchange.BSE,
  "XNSE": Exchange.XNSE
});

enum Product { RELIANCE, RELIANCE_XNSE }

final productValues = EnumValues({
  "Reliance": Product.RELIANCE,
  "RELIANCE.XNSE": Product.RELIANCE_XNSE
});

enum Status { PENDING }

final statusValues = EnumValues({
  "pending": Status.PENDING
});

enum Tradingsymbol { ITC_XBOM, RELIANCE_XNSE }

final tradingsymbolValues = EnumValues({
  "ITC.XBOM": Tradingsymbol.ITC_XBOM,
  "RELIANCE.XNSE": Tradingsymbol.RELIANCE_XNSE
});

enum TransactionType { SELL, BUY }

final transactionTypeValues = EnumValues({
  "Buy": TransactionType.BUY,
  "Sell": TransactionType.SELL
});

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  final String url;
  final String label;
  final bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"] == null ? null : json["label"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label == null ? null : label,
    "active": active == null ? null : active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
