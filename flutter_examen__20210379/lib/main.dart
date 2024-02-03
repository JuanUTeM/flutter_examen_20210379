import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<String> _tabTitles = ["Today", "Games", "Apps", "Arcade", "Search"];
  final List<String> _gameNames = ["Plantas vs Zombies", "Free Fire", "Clash Royal", "COD MOBILE"];
  final List<String> _searchHistory = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            _tabTitles[_currentIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueGrey, 
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.grey[800], 
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Apps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Arcade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return TodayScreen();
    } else if (_currentIndex == 4) {
      return SearchScreen(gameNames: _gameNames, searchHistory: _searchHistory);
    } else {
      return Container(
        color: Colors.indigoAccent, 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://i.ibb.co/tzgjn6M/netflix-juegos-anuncios-compras.jpg',
                height: 200,
                width: 250,
              ),
            ],
          ),
        ),
      );
    }
  }
}

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.deepOrangeAccent, 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://i.ibb.co/SKz3h1n/MWII-NEXT-COD-WZM-TOUT.jpg',
                height: 300,
                width: 350,
              ),
              SizedBox(height: 20),
              Image.network(
                'https://i.ibb.co/gzKh7Ch/maxresdefault.jpg',
                fit: BoxFit.contain,
                height: 300,
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final List<String> gameNames;
  final List<String> searchHistory;

  SearchScreen({required this.gameNames, required this.searchHistory});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _filteredNames = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredNames.addAll(widget.gameNames);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              _filterNames(value);
            },
            onSubmitted: (value) {
              _addToHistory(value);
            },
            decoration: InputDecoration(
              labelText: 'Buscar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredNames[index]),
                leading: Icon(Icons.sports_esports),
                onTap: () {
                  _addToHistory(_filteredNames[index]);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'HISTORIAL:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.searchHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.searchHistory[index]),
                leading: Icon(Icons.history),
              );
            },
          ),
        ),
      ],
    );
  }

  void _filterNames(String query) {
    setState(() {
      _filteredNames = widget.gameNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addToHistory(String value) {
    setState(() {
      if (!_filteredNames.contains(value)) {
        _filteredNames.add(value);
      }
      widget.searchHistory.insert(0, value);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
