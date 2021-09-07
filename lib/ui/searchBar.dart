import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../sizeconfig.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static const historyLength = 5;

// The "raw" history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = [
    'KHADIM',
    'AGARIND',
    'RELCAPITAL',
    'RECLTD',
  ];

// The filtered & ordered history that's accessed from the UI
  List<String> filteredSearchHistory;

// The currently searched-for term
  String selectedTerm;

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }


  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: FloatingSearchBar(
        transition: CircularFloatingSearchBarTransition(),
// Bouncing physics for the search history
        physics: BouncingScrollPhysics(),
// Title is displayed on an unopened (inactive) search bar
        title: Text(
          selectedTerm ?? 'Search eg: infy bse, nifty fut',
          style: TextStyle(color: Colors.grey),
        ),
// Hint gets displayed once the search bar is tapped and opened
        hint: 'Search eg: infy bse, nifty fut',

        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
      controller: controller,
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  }else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(AntDesign.search1,color:Colors.grey ,size: 22,),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  }else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                          title: Text(
                            term,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.3),

                            ),
                            child: Text('BSE',style: TextStyle(color: Colors.blueAccent,fontSize: 12),),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                deleteSearchTerm(term);
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              putSearchTermFirst(term);
                              selectedTerm = term;
                            });
                            controller.close();
                          },
                        ),
                      )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      body: FloatingSearchBarScrollNotifier(

        child: SearchResultsListView(
          searchTerm: selectedTerm,
        ),
      ) ,
    ));
  }
  
}

class SearchResultsListView extends StatelessWidget {
final String searchTerm;

  const SearchResultsListView({Key key, this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(searchTerm==null){
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AntDesign.search1,color:Colors.grey ,size: 22,),
            SizedBox(height: 25,),
            Text('Start Searching',style: TextStyle(color: Colors.grey),)
            
          ],
        ),
      );
    }


  final fsb = FloatingSearchBar.of(context);

  return ListView(
  padding: EdgeInsets.only(top: 20 ),
  children: List.generate(
  50,
  (index) => ListTile(
    leading: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.3),

      ),
      child: Text('BSE',style: TextStyle(color: Colors.blueAccent,fontSize: 12),),
    ),
  title: Text('$searchTerm'.toUpperCase(),),
  subtitle: Text(index.toString().toUpperCase()),
    trailing: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(

        border: Border.all(color: Colors.blueAccent,)

      ),
      child: Icon(Icons.add,color: Colors.blueAccent,size: 15,),
    ),
  ),
  ),
  );
  }
}