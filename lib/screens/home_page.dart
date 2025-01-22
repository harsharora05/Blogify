import 'package:blog/data/post_data.dart';
import 'package:blog/httpRequests/postsRequest.dart';
import 'package:blog/model/post_model.dart';
import 'package:blog/provider/postProvider.dart';
import 'package:blog/screens/display_post.dart';
import 'package:blog/widgets/PopularPostCard.dart';
import 'package:blog/widgets/RecentPostCard.dart';
import 'package:blog/widgets/drawerHome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Post> nextPosts = await loadMorePosts();
    // print(nextPosts);
    context.read<RecentPostProvider>().AddNextRecentPosts(nextPosts);
  }

  int? _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerHome(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Blogify",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top 10 Popular Blogs",
                style: GoogleFonts.notoSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Consumer<PopularPostProvider>(
                builder: (ctx, popularPostProvider, child) {
              if (popularPostProvider.isLoading) {
                return SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()));
              } else if (popularPostProvider.errorMessage != null) {
                return Center(child: Text(popularPostProvider.errorMessage!));
              } else if (popularPostProvider.popularPosts.isEmpty) {
                return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(child: Text("No Popular posts available")));
              } else {
                return SizedBox(
                    height: 210,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: popularPostProvider.popularPosts.length,
                        itemBuilder: (context, index) {
                          final post = popularPostProvider.popularPosts[index];
                          return Container(
                            padding: const EdgeInsets.all(5),
                            height: double.infinity,
                            width: 200,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Displaypost(
                                      post: post,
                                    );
                                  }));
                                },
                                child: PopularPostCard(post: post)),
                          );
                        }));
              }
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recent Blogs",
                style: GoogleFonts.notoSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                        showCheckmark: false,
                        selected: _value == index,
                        selectedColor: Colors.black,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                          });
                          if (_value == 0) {
                            context
                                .read<RecentPostProvider>()
                                .InitialRecentPosts();
                          } else {
                            context
                                .read<RecentPostProvider>()
                                .tagsPost(tags[_value!]);
                          }
                        },
                        label: Text(
                          tag,
                          style: TextStyle(color: Colors.deepPurpleAccent),
                        )),
                  );
                },
              ),
            ),
            Consumer<RecentPostProvider>(
              builder: (ctx, recentPostProvider, child) {
                if (recentPostProvider.isLoading) {
                  return SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Center(child: CircularProgressIndicator()));
                } else if (recentPostProvider.errorMessage != null) {
                  return Center(child: Text(recentPostProvider.errorMessage!));
                } else if (recentPostProvider.recentPosts.isEmpty) {
                  return SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Center(child: Text("No recent posts available")));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: recentPostProvider.recentPosts.length,
                      itemBuilder: (context, index) {
                        final post = recentPostProvider.recentPosts[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Displaypost(post: post),
                            ));
                          },
                          child: RecentPostCard(post: post),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
