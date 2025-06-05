import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:simple/Reusable/color.dart'; // Commented out as it's not provided
import 'package:simple/UI/Home_screen/home_screen.dart';
// ---------------------------------
// Awareness page (white app-bar ➜ banner ➜ grid of thumbnails)
// ---------------------------------
class AwarenessPage extends StatelessWidget {
  final bool isDarkMode; // Added isDarkMode property

  const AwarenessPage({super.key, required this.isDarkMode});

  static const _videos = [
    _VideoItem(id: 'I7-G4rrQyx0', title: 'Awarez', date: '02-04-2025'),
    _VideoItem(id: 'Z1iHVxOCCkA', title: 'Precautions', date: '05-04-2025'),
    _VideoItem(id: 'GLeUJhybJQw', title: 'Dental', date: '02-06-2025'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Calculate columns based on screen width for responsive layout
    final columns = width < 600 ? 1 : 2;
    // Calculate tile width, accounting for padding and spacing
    final tileWidth = (width - 32 - (columns - 1) * 24) / columns;
    // Calculate thumbnail height (16:9 aspect ratio)
    final thumbHeight = tileWidth * 9 / 16;
    // Calculate total card height (thumbnail + text + spacing)
    final cardHeight = thumbHeight + 8 + 26 + 24 + 22;

    // Define colors based on dark mode state
    // These colors would typically come from a theme or global color definition.
    // For this example, they are defined directly.
    // final Color textColor = isDarkMode ? Colors.white : Colors.black; // No longer directly used here, but in _VideoCard
    final Color highlightColor = isDarkMode ? Colors.amber : Colors.pink[900]!;
    final Color scaffoldBackgroundColor = isDarkMode ? Colors.grey[900]! : const Color(0xFFFFEBEE);

    // Returning only the CustomScrollView as the body content
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
        return false;// Prevent default back action
      },
      child: Container( // Wrap with Container to provide a background color to the body
        color: scaffoldBackgroundColor, // Apply the dynamic background color
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 12)), // Top spacing
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/image/awarenessimage.jpg', // Ensure this image path is correct
                    height: MediaQuery.of(context).size.height * .28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget if image fails to load
                      return Container(
                        height: MediaQuery.of(context).size.height * .28,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Image not found', style: TextStyle(color: Colors.black54)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, i) => _VideoCard(item: _videos[i], isDarkMode: isDarkMode), // Pass isDarkMode to video card
                  childCount: _videos.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns, // Number of columns in the grid
                  mainAxisExtent: cardHeight, // Height of each grid item
                  crossAxisSpacing: 24, // Horizontal spacing between grid items
                  mainAxisSpacing: 24, // Vertical spacing between grid items
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final _VideoItem item;
  final bool isDarkMode; // Added isDarkMode property

  // Constructor updated to accept isDarkMode
  const _VideoCard({required this.item, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Define colors for the card based on dark mode state
    final Color cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color highlightColor = isDarkMode ? Colors.amber : Colors.pink[900]!;

    return InkWell(
      borderRadius: BorderRadius.circular(32), // Rounded corners for the tappable area
      onTap: () => Navigator.of(context).push( // Navigate to video player page on tap
        MaterialPageRoute(builder: (_) => VideoPlayerPage(item: item, isDarkMode: isDarkMode)), // Pass isDarkMode
      ),
      child: Material(
        color: cardColor, // Use dynamic card background color
        elevation: 6, // Shadow effect
        borderRadius: BorderRadius.circular(32), // Rounded corners for the card material
        child: Padding(
          padding: const EdgeInsets.all(12), // Inner padding for card content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column takes minimum space needed
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16), // Rounded corners for the thumbnail
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Standard video aspect ratio
                  child: Image.network(
                    'https://img.youtube.com/vi/${item.id}/hqdefault.jpg', // YouTube thumbnail URL
                    fit: BoxFit.cover, // Cover the entire space
                    loadingBuilder: (_, child, progress) =>
                    progress == null ? child : const Center(child: CircularProgressIndicator()), // Loading indicator
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback widget if thumbnail fails to load
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.videocam_off, color: Colors.black54),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8), // Spacing below thumbnail
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: highlightColor, // Use dynamic highlight color for title
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 4), // Spacing below title
              Text(
                'Date: ${item.date}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Times New Roman',
                  color: textColor, // Use dynamic text color for date
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
  final _VideoItem item;
  final bool isDarkMode; // Added isDarkMode property to VideoPlayerPage

  const VideoPlayerPage({required this.item, required this.isDarkMode, super.key}); // Updated constructor

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final YoutubePlayerController _controller; // Controller for YouTube player

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.id, // Set initial video ID from the item
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Auto-play video
        mute: false, // Video not muted by default
        enableCaption: true, // Enable captions if available
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the page is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define colors for the VideoPlayerPage based on dark mode state
    final Color appBarBackgroundColor = widget.isDarkMode ? const Color(0xFF424242) : Colors.blue;
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final Color scaffoldBackgroundColor = widget.isDarkMode ? Colors.grey[900]! : Colors.white;


    return Scaffold(
      backgroundColor: scaffoldBackgroundColor, // Dynamic background color
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor, // Dynamic app bar background
        title: Text(
          widget.item.title,
          style: TextStyle( // Use dynamic text color
            color: textColor,
            fontFamily: 'Times New Roman',
          ),
        ),
        iconTheme: IconThemeData(color: textColor), // Dynamic icon color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // Padding around the player
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24), // Rounded corners for the player
            child: YoutubePlayer(
              controller: _controller, // Assign the controller
              showVideoProgressIndicator: true, // Show video progress bar
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
