import 'package:flutter/material.dart';
import '../models/post.dart';
import 'reel_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.brown[300], radius: 18),
              const SizedBox(width: 8),
              Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
        if (post.videoUrl != null)
          ReelWidget(videoUrl: post.videoUrl!)
        else if (post.imageUrl != null)
          CachedNetworkImage(
            imageUrl: post.imageUrl!,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.white10),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        else
          Container(
            height: 200,
            color: Colors.white10,
            child: const Center(child: Text('No media')),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(post.isLiked ? Icons.favorite : Icons.favorite_border,
                   color: post.isLiked ? Colors.red : Colors.white),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline),
              const SizedBox(width: 16),
              const Icon(Icons.send_outlined),
              const Spacer(),
              const Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${post.likesCount} likes', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${post.username} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const Divider(color: Colors.white12),
      ],
    );
  }
}
