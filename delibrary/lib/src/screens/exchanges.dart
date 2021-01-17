import 'package:delibrary/src/components/page-title.dart';
import 'package:delibrary/src/components/section-container.dart';
import 'package:delibrary/src/controller/property-services.dart';
import 'package:delibrary/src/controller/wish-services.dart';
import 'package:delibrary/src/model/action.dart';
import 'package:delibrary/src/model/book-list.dart';
import 'package:delibrary/src/model/book.dart';
import 'package:delibrary/src/routes/book-details.dart';
import 'package:delibrary/src/shortcuts/padded-list-view.dart';
import 'package:flutter/material.dart';

class ExchangesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends State<ExchangesScreen> {
  final PropertyServices _propertyServices = PropertyServices();
  final WishServices _wishServices = WishServices();
  BookList _waitingList;
  BookList _sentList;
  BookList _refusedList;
  BookList _completedList;

  @override
  void initState() {
    //TODO: fetch the book lists
    super.initState();
    _waitingList = BookList();
    _sentList = BookList();
    _refusedList = BookList();
    _completedList = BookList();
  }

  //TODO: change selected functions to go to the profile page of the other user

  Future<void> _selectedWaiting(Book book) async {
    //TODO: manage actions
    int selectedAction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          book: book,
          primaryAction: _propertyServices.removeProperty(book),
          secondaryAction: _propertyServices.movePropertyToWishList(book),
        ),
      ),
    );
    print(selectedAction);
  }

  Future<void> _selectedSent(Book book) async {
    //TODO: manage actions
    int selectedAction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          book: book,
          primaryAction: _wishServices.removeWish(book),
          secondaryAction: _wishServices.moveWishToLibrary(book),
        ),
      ),
    );
    print(selectedAction);
  }

  Future<void> _selectedRefused(Book book) async {
    //TODO: manage actions
    int selectedAction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          book: book,
          primaryAction: _wishServices.removeWish(book),
          secondaryAction: _wishServices.moveWishToLibrary(book),
        ),
      ),
    );
    print(selectedAction);
  }

  Future<void> _selectedCompleted(Book book) async {
    //TODO: manage actions
    int selectedAction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          book: book,
          primaryAction: _wishServices.removeWish(book),
          secondaryAction: _wishServices.moveWishToLibrary(book),
        ),
      ),
    );
    print(selectedAction);
  }

  @override
  Widget build(BuildContext context) {
    return PaddedListView(
      children: [
        PageTitle("I tuoi scambi"),
        BooksSectionContainer(
          title: "In attesa",
          bookList: _waitingList,
          onTap: _selectedWaiting,
        ),
        BooksSectionContainer(
          title: "Inviati",
          bookList: _sentList,
          onTap: _selectedSent,
        ),
        BooksSectionContainer(
          title: "Rifiutati",
          bookList: _refusedList,
          onTap: _selectedRefused,
        ),
        BooksSectionContainer(
          title: "Completati",
          bookList: _completedList,
          onTap: _selectedCompleted,
        ),
      ],
    );
  }
}
