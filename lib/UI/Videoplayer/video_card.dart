import 'package:flutter/material.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:simple/UI/Videoplayer/videoplayer.dart';

class VideoCard extends StatelessWidget {
  final VideoItem item;
  final bool isDarkMode; // Added isDarkMode property

  // Constructor updated to accept isDarkMode
  const VideoCard({required this.item, required this.isDarkMode});

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