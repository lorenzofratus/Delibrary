import 'package:delibrary/src/model/primary/book.dart';
import 'package:delibrary/src/model/primary/exchange.dart';
import 'package:delibrary/src/model/primary/item-list.dart';
import 'package:flutter/material.dart';

@immutable
class ExchangeList extends ItemList<Exchange> {
  ExchangeList({List<Exchange> items}) : super(items: items);

  @override
  bool get isComplete => true;

  @override
  Map<Exchange, bool> getWishedMap(BuildContext context) => {};

  // Both waiting and sent are in the proposed state
  ExchangeList get waiting => _filter(ExchangeStatus.proposed, false);
  ExchangeList get sent => _filter(ExchangeStatus.proposed, true);
  ExchangeList get refused => _filter(ExchangeStatus.refused);
  ExchangeList get agreed => _filter(ExchangeStatus.agreed);
  ExchangeList get happened => _filter(ExchangeStatus.happened);

  ExchangeList _filter(ExchangeStatus status, [bool isBuyer]) {
    return ExchangeList(
      items: items.where(
        (e) {
          if (isBuyer != null)
            return e.isBuyer == isBuyer && e.status == status;
          return e.status == status;
        },
      ).toList(),
    );
  }

  //TODO: needs revision
  bool containsBook(Book book) {
    return items.any((e) => e.involves(book));
  }

  ExchangeList add(Exchange exchange) {
    if (exchange == null || items.contains(exchange)) return this;
    List<Exchange> self = items.toList();
    self.add(exchange);
    return ExchangeList(items: self);
  }

  ExchangeList remove(Exchange exchange) {
    if (exchange == null || !items.contains(exchange)) return this;
    List<Exchange> self = items.toList();
    self.remove(exchange);
    return ExchangeList(items: self);
  }

  ExchangeList refuse(Exchange exchange) {
    if (exchange == null || !items.contains(exchange)) return this;
    List<Exchange> self = items.toList();
    int index = self.indexOf(exchange);
    Exchange newExchange = exchange.setStatus(ExchangeStatus.refused);
    self.remove(exchange);
    self.insert(index, newExchange);
    return ExchangeList(items: self);
  }

  ExchangeList happen(Exchange exchange) {
    if (exchange == null || !items.contains(exchange)) return this;
    List<Exchange> self = items.toList();
    int index = self.indexOf(exchange);
    Exchange newExchange = exchange.setStatus(ExchangeStatus.happened);
    self.remove(exchange);
    self.insert(index, newExchange);
    return ExchangeList(items: self);
  }

  ExchangeList agree(Exchange exchange, Book payment) {
    if (exchange == null || !items.contains(exchange)) return this;
    List<Exchange> self = items.toList();
    int index = self.indexOf(exchange);
    Exchange newExchange = exchange.setPayment(payment);
    self.remove(exchange);
    self.insert(index, newExchange);
    return ExchangeList(items: self);
  }
}
