import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // For modern icons

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'thrifti',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search a store, member, etc.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0), // Reduced height
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  children: [
                    _buildButton(Icons.location_on, "Recs",
                        Colors.purple), // Changed icon
                    _buildButton(Icons.trending_up, "Trending", Colors.purple),
                    _buildButton(Icons.group, "Friend Recs", Colors.purple),
                  ],
                ),
              ),
              SingleChildScrollView(
                // Making the feed section scrollable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                      child: Text(
                        'Your Feed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    _buildFeedItem("Taylor", "Green Sweater", "Thrift Store X",
                        "7 hours ago"),
                    _buildFeedItem(
                        "Alex", "Vintage Jacket", "Retro Finds", "1 day ago"),
                    _buildFeedItem(
                        "Jordan", "Leather Boots", "Bargain Bin", "2 days ago"),
                    // Add more feed items here
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
        backgroundColor: Colors.white,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(SimpleLineIcons.list), // Updated icon
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(SimpleLineIcons.bag), // Updated icon
          label: 'Your Finds',
        ),
        BottomNavigationBarItem(
          icon: Icon(SimpleLineIcons.magnifier), // Updated icon
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(SimpleLineIcons.heart), // Updated icon
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(SimpleLineIcons.user), // Updated icon
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label, Color color) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildFeedItem(
      String userName, String itemFound, String storeName, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('$userName found $itemFound',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Bought from $storeName',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(SimpleLineIcons.heart), // Changed icon
                              onPressed: () {}),
                          IconButton(
                              icon:
                                  Icon(SimpleLineIcons.bubble), // Changed icon
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                  SimpleLineIcons.paper_plane), // Changed icon
                              onPressed: () {}),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.bookmark_outline), onPressed: () {}),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    timeAgo,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
