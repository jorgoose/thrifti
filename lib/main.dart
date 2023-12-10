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
          actions: <Widget>[
            IconButton(
              icon: Icon(SimpleLineIcons.bell, color: Colors.black),
              onPressed: () {
                // Handle notification bell press
              },
            ),
          ],
        ),
        body: Column(
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
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0), // Adjusted padding
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  _buildButton(
                      Icons.location_on, "Recs", Colors.purple), // Changed icon
                  _buildButton(Icons.trending_up, "Trending", Colors.purple),
                  _buildButton(Icons.group, "Friend Recs", Colors.purple),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Adjust the number of feed items
                itemBuilder: (context, index) {
                  // Replace these values with actual data or a data model
                  String userName = "User $index";
                  String itemFound = "Item $index";
                  String storeName = "Store $index";
                  String timeAgo = "${index + 1} hours ago";

                  return _buildFeedItem(
                      userName, itemFound, storeName, timeAgo);
                },
              ),
            ),
          ],
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
        padding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Adjusted padding
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
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '$userName ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'found '),
                  TextSpan(
                      text: '$itemFound',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
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
                          icon: Icon(SimpleLineIcons.plus), onPressed: () {}),
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
