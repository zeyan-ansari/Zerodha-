class Eod {
  Pagination pagination;
  List<Data> data;

  Eod({this.pagination, this.data});

  Eod.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int limit;
  int offset;
  int count;
  int total;

  Pagination({this.limit, this.offset, this.count, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['count'] = this.count;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  double open;
  double high;
  double low;
  double close;
  double volume;
  Null adjHigh;
  Null adjLow;
  double adjClose;
  Null adjOpen;
  Null adjVolume;
  double splitFactor;
  String symbol;
  String exchange;
  String date;

  Data(
      {this.open,
        this.high,
        this.low,
        this.close,
        this.volume,
        this.adjHigh,
        this.adjLow,
        this.adjClose,
        this.adjOpen,
        this.adjVolume,
        this.splitFactor,
        this.symbol,
        this.exchange,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
    adjHigh = json['adj_high'];
    adjLow = json['adj_low'];
    adjClose = json['adj_close'];
    adjOpen = json['adj_open'];
    adjVolume = json['adj_volume'];
    splitFactor = json['split_factor'];
    symbol = json['symbol'];
    exchange = json['exchange'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['adj_high'] = this.adjHigh;
    data['adj_low'] = this.adjLow;
    data['adj_close'] = this.adjClose;
    data['adj_open'] = this.adjOpen;
    data['adj_volume'] = this.adjVolume;
    data['split_factor'] = this.splitFactor;
    data['symbol'] = this.symbol;
    data['exchange'] = this.exchange;
    data['date'] = this.date;
    return data;
  }
}
