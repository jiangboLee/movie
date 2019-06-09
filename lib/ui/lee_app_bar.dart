import 'package:flutter/material.dart';
import 'package:movie/assets.dart';
import 'theater_list/theater_selector_popup.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:core/core.dart';

class LeeAppBar extends StatefulWidget {
  @override
  _LeeAppBarState createState() => _LeeAppBarState();
}

class _LeeAppBarState extends State<LeeAppBar> with SingleTickerProviderStateMixin {

  TextEditingController _searchQuery;
  LocalHistoryEntry _searchEntry;

  bool _isSearching = false;
  bool _theatersOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchQuery = TextEditingController();
    _searchEntry = LocalHistoryEntry(onRemove: _stopSearching);
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search movies & showtimes...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: _updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          color: Colors.white70,
          icon: Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }

            _clearSearchQuery();
          },
        ),
      ];
    }

    return [
      _TheaterIconButton(_theatersOpen, _toggleTheaters),
      IconButton(
        color: Colors.white70,
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: _isSearching ? const BackButton() : null,
      title: _isSearching ? _buildSearchField() : _Title(_toggleTheaters),
      actions: _buildActions(),
    );
  }

  void _toggleTheaters() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      _setTheatersOpenFlag(false);
    } else {
      _setTheatersOpenFlag(true);

      await Navigator.push(context, TheaterSelectorPopup());
      _setTheatersOpenFlag(false);
    }
  }

  void _setTheatersOpenFlag(bool open) {
    setState(() {
      _theatersOpen = open;
    });
  }


  void _startSearch() {
    ModalRoute.of(context).addLocalHistoryEntry(_searchEntry);

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      _updateSearchQuery(null);
    });
  }

  void _updateSearchQuery(String newQuery) {

  }
}

class _Title extends StatelessWidget {

  final VoidCallback toggleTheaters;

   _Title(this.toggleTheaters);

  @override
  Widget build(BuildContext context) {

    final subTitle = StoreConnector<AppState, Theater>(
      builder: (BuildContext context, Theater theater) {
        return Text(
          theater?.name ?? '',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        );
      },
      converter: (store) => store.state.theaterState.currentTheater,
    );

    final title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('LEE'),
        subTitle,
      ],
    );

    return GestureDetector(
      onTap: toggleTheaters,
      child: Row(
        children: <Widget>[
          Image.asset(
              ImageAssets.logoImage,
            width: 28.0,
            height: 28.0,
          ),
          const SizedBox(width: 8),
          title,
        ],
      ),
    );
  }
}

class _TheaterIconButton extends StatelessWidget {

  final bool theatersOpen;
  final VoidCallback toggleTheaters;

  _TheaterIconButton(this.theatersOpen, this.toggleTheaters);

  @override
  Widget build(BuildContext context) {

    final backgroundColor = theatersOpen ? const Color(0xFF152451) : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 175),
      color: backgroundColor,
      child: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.place,
            color: Colors.white70,
            size: 24.0,
          ),
        ),
        onTap: toggleTheaters,
      ),
    );
  }
}

