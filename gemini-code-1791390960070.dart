import 'package:flutter/material.dart';

class LiveTvShortsScreen extends StatefulWidget {
  const LiveTvShortsScreen({super.key});

  @override
  State<LiveTvShortsScreen> createState() => _LiveTvShortsScreenState();
}

class _LiveTvShortsScreenState extends State<LiveTvShortsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live TV & Shorts Reels'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.live_tv), text: '24x7 Live TV'),
            Tab(icon: Icon(Icons.play_circle_filled), text: 'शॉर्ट्स वीडियो'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  margin: const EdgeInsets.all(16),
                  color: Colors.black,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_outline, size: 64, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          'News 7 India 24x7 Live Broadcast',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'लाइव स्ट्रीमिंग जल्द उपलब्ध होगी',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              Card(
                child: ListTile(
                  leading: Icon(Icons.movie_filter, color: Color(0xFFD32F2F)),
                  title: Text('कटनी समाचार वीडियो बुलेटिन'),
                  subtitle: Text('पसंद: 1.2k Likes'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.movie_filter, color: Color(0xFFD32F2F)),
                  title: Text('बड़वारा स्थानीय जनसमस्या रिपोर्ट'),
                  subtitle: Text('पसंद: 895 Likes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}