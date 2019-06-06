import 'package:flutter/material.dart';
import 'package:movie/assets.dart';
import 'package:movie/ui/lee_app_bar.dart';
import 'package:movie/ui/lee_bottom_bar.dart';
import 'package:movie/message_localization.dart';

class MainPage extends StatefulWidget {
  const MainPage();
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildTabContent() {
    return Positioned.fill(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          new Container(),
          new Container(),
          new Container(),
        ],
      ),
    );
  }

  void _tabSelected(int newIndex) {
    setState(() {
      _selectedTab = newIndex;
      _tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final backgroundImage = Image.asset(
      ImageAssets.backgroundImage,
      fit: BoxFit.cover,
    );
    
    final content = Scaffold(
      appBar: PreferredSize(
        child: LeeAppBar(),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: <Widget>[
          _buildTabContent(),
          _BottomTabs(
            selectedTab: _selectedTab,
            onTap: _tabSelected,
          ),
        ],
      ),
    );
    
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        backgroundImage,
        content,
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {

  final int selectedTab;
  final ValueChanged<int> onTap;

  const _BottomTabs({Key key,@required this.selectedTab,@required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final messages = MessageIntl.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: LeeBottomBar(
        currentIndex: selectedTab,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            title: Text(messages.nowInTheaters),
            icon: const Icon(Icons.theaters),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            title: Text(messages.showtimes),
            icon: const Icon(Icons.schedule),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            title: Text(messages.comingSoon),
            icon: const Icon(Icons.whatshot),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

