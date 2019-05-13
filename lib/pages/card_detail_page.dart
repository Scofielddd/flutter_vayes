import 'package:flutter/material.dart';

class CardDetailPage extends StatelessWidget {
  static String tag = 'card-detail-page';

  int index;
  CardDetailPage(index){
    this.index = index;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        primary: true,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            primary: true,
            title: Text("Card Detail"),
          ),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Text("Descasdasdasdasd."),
            ),
          ),
        ],
      ),
    );
  }
}
