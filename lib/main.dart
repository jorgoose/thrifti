/*
  This is the main file for the thrifti app. It contains the main app widget and the views for the feed and profile.

  thrifti is a social media app for thrift store enthusiasts. Users can share their finds, follow other users, and discover new thrift stores.
  Users can score thrift stores they've visited on a few different categories ("Selection", "Vibes" and "Prices") and see how other users have scored the same stores.
  Users can also see a feed of finds from people they follow, and can like, comment, and share these finds.
  Lastly, users can set their preferences for the types of items they're interested in, and see a feed of finds that match their preferences.
*/

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // For modern icons

// Flutter map import
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FeedView(),
    ExploreView(), // This is the new explore view
    const Text('Search'),
    const Text('Your Finds'),
    ProfileView(), // This is the new profile view
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.list),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.map),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.magnifier),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.drawer),
              label: 'Your Finds',
            ),
            BottomNavigationBarItem(
              icon: Icon(SimpleLineIcons.user),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                _buildButton(Icons.location_on, "Recs", Colors.purple),
                _buildButton(Icons.trending_up, "Trending", Colors.purple),
                _buildButton(Icons.group, "Friend Recs", Colors.purple),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                String userName = "User $index";
                String itemFound = "Item $index";
                String storeName = "Store $index";
                String timeAgo = "${index + 1} hours ago";

                return _buildFeedItem(userName, itemFound, storeName, timeAgo);
              },
            ),
          ),
        ],
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'found '),
                  TextSpan(
                      text: itemFound,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    style: const TextStyle(fontSize: 14),
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
                              icon: const Icon(SimpleLineIcons.heart),
                              onPressed: () {}),
                          IconButton(
                              icon: const Icon(SimpleLineIcons.bubble),
                              onPressed: () {}),
                          IconButton(
                              icon: const Icon(SimpleLineIcons.paper_plane),
                              onPressed: () {}),
                        ],
                      ),
                      IconButton(
                          icon: const Icon(SimpleLineIcons.plus),
                          onPressed: () {}),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    timeAgo,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Top section with name and share icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Firstname Lastname',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Handle share
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Profile picture placeholder
            CircleAvatar(
              radius: 50, // Adjust the size as needed
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 8.0),
            // Username and membership duration
            const Text(
              '@username',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'Member since December 2023',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            // Edit profile button
            ElevatedButton(
              onPressed: () {
                // Handle edit profile
              },
              child: Text('Edit Profile'),
            ),
            const SizedBox(height: 16.0),
            // Followers and Following counts
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Followers',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('0'), // Placeholder count
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Following',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('0'), // Placeholder count
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Sections: Finds, Visited, Preferences
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSection(Icons.search, 'Finds'),
                _buildSection(Icons.place, 'Visited'),
                _buildSection(Icons.star, 'Preferences'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(IconData icon, String label) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 28),
        Text(label),
      ],
    );
  }
}

// This is the view for "Explore", which shows a map (for now, just a basic map, no functionality yet)
// thrifti is a social media app for thrift store enthusiasts. Users can share their finds, follow other users, and discover new thrift stores.
// Lastly, users can set their preferences for the types of items they're interested in, and see a feed of finds that match their preferences.
// We will start by implementing the map for the user. We will use flutter_map package (v 6.1.0) to implement the map.
class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(40.7128, -74.0060),
          initialZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
