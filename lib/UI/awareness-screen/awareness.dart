import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Awareness Videos',
      debugShowCheckedModeBanner: false,
      home: AwarenessPage(),
    );
  }
}

// ---------------------------------
// Awareness page (white app-bar ➜ banner ➜ grid of thumbnails)
// ---------------------------------
class AwarenessPage extends StatelessWidget {
  const AwarenessPage({super.key});

  static const _videos = [
    _VideoItem(id: 'I7-G4rrQyx0', title: 'Awarez', date: '02-04-2025'),
    _VideoItem(id: 'Z1iHVxOCCkA', title: 'Precautions', date: '05-04-2025'),
    _VideoItem(id: 'GLeUJhybJQw', title: 'Dental', date: '02-06-2025'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 1 : 2;
    final tileWidth = (width - 32 - (columns - 1) * 24) / columns;
    final thumbHeight = tileWidth * 9 / 16;
    final cardHeight = thumbHeight + 8 + 26 + 24 + 22;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Awareness',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFFFEBEE),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/image/awarenessimage.jpg',
                  height: MediaQuery.of(context).size.height * .28,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => _VideoCard(item: _videos[i]),
                childCount: _videos.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisExtent: cardHeight,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.item});
  final _VideoItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VideoPlayerPage(item: item)),
      ),
      child: Material(
        color: Colors.white,
        elevation: 6,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    'https://img.youtube.com/vi/${item.id}/hqdefault.jpg',
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) =>
                    progress == null ? child : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.pink[900],
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Date: ${item.date}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({required this.item, super.key});
  final _VideoItem item;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.item.title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoItem {
  final String id;
  final String title;
  final String date;
  const _VideoItem({required this.id, required this.title, required this.date});
}
