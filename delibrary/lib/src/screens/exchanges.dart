import 'package:delibrary/src/components/utils/page-title.dart';
import 'package:delibrary/src/components/sections/items.dart';
import 'package:delibrary/src/model/primary/exchange-list.dart';
import 'package:delibrary/src/model/session.dart';
import 'package:delibrary/src/components/utils/padded-list-view.dart';
import 'package:delibrary/src/components/utils/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:delibrary/src/controller/internal/exchange-services.dart';
import 'package:provider/provider.dart';

class ExchangesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends State<ExchangesScreen> {
  final ExchangeServices _exchangeServices = ExchangeServices();

  @override
  void initState() {
    super.initState();
    _downloadLists();
  }

  void _openArchive() {
    Navigator.pushNamed(context, "/archive");
  }

  Future<void> _downloadLists() async {
    _exchangeServices.updateSession(context);
  }

  @override
  Widget build(BuildContext context) {
    return Refreshable(
      onRefresh: _downloadLists,
      child: PaddedListView(
        children: [
          PageTitle(
            "I tuoi scambi attivi",
            action: _openArchive,
            actionIcon: Icons.archive_outlined,
          ),
          ItemsSectionContainer(
            title: "In attesa",
            provider: (context) =>
                context.select<Session, ExchangeList>((s) => s.waiting),
          ),
          ItemsSectionContainer(
            title: "Inviati",
            provider: (context) =>
                context.select<Session, ExchangeList>((s) => s.sent),
          ),
          ItemsSectionContainer(
            title: "Confermati",
            provider: (context) =>
                context.select<Session, ExchangeList>((s) => s.agreed),
          ),
        ],
      ),
    );
  }
}
