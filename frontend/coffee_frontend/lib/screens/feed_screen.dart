import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/post.dart';
import '../widgets/post_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await _apiService.getPosts();
      final List data = response.data;
      setState(() {
        _posts = data.map((json) => Post.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('COFFEE')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchPosts,
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return PostWidget(post: _posts[index]);
                },
              ),
            ),
    );
  }
}
