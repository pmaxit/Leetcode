import 'package:flutter/material.dart';

abstract class FetchProvider {
  void fetch([int offset]);
}


mixin ListScrollMixin<T extends StatefulWidget> on State<T>
implements FetchProvider {
  final ScrollController scrollController = ScrollController();
  final double scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    fetch();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - scrollThreshold) {
      fetch();
    }
  }
}

// Usage
// Just add 'with ...' to the class declaration
// class MyWidget extends StatefulWidget with ListScrollMixin {
  // remove most of the old code

  // and implement fetch method 
  // void fetch([int offset]) {
    // print('Fetching items, starting at ${offset ?? dummyWinesData.data.length}');
    // ...
    // Here can be a direct api call something like api.fetchWines(...)
    // or you can dispatch some redux actions --> store.dispatch(FetchWinesAction())
    // etc

    // Also don't forget to lock / canFetch = false; / while loading new data 
    // to prevent triggering fetch event multiple times
    // (you can do it in a reducer if you use redux)
//   }
  
//   @override
//   Widget build(BuildContext context) => SomeWidgetWithTheListOfItems() 
// }