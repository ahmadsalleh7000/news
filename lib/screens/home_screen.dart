import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/widgets/app_bar.dart';
import 'package:news/widgets/tab_item.dart';
import 'package:news/widgets/news_card.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  Map<String, dynamic>? arguments;
  String? category;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        category = arguments?['categoryIndex'];
        // Fetch sources after getting the category
        Provider.of<NewsProvider>(context, listen: false).fetchSources(category ?? 'general');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: const ApplicationBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSourcesTabs(newsProvider),
          Expanded(
            child: _buildNewsBySourceList(newsProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesTabs(NewsProvider newsProvider) {
    final sources = newsProvider.sources;
    if (sources == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final sourceList = sources.sources;
      return DefaultTabController(
        length: sourceList!.length,
        child: TabBar(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          tabs: sourceList
              .map((source) => TabItem(title: source.name!, isSelected: _selectedTab == sourceList.indexOf(source)))
              .toList(),
          isScrollable: true,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          onTap: (index) {
            setState(() {
              _selectedTab = index;
              newsProvider.setSourceId(sourceList[index].id!);
            });
          },
        ),
      );
    }
  }

  Widget _buildNewsBySourceList(NewsProvider newsProvider) {
  return FutureBuilder(
    future: newsProvider.newsItems,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 50.0),
            Text('Error fetching news articles: ${snapshot.error}'),
            ElevatedButton(onPressed: () {}, child: const Text('Retry')),
          ],
        );
      } else if (snapshot.hasData && snapshot.data?.articles != null) {
        final articles = snapshot.data?.articles ?? [];

        if (articles.isEmpty) {
          return const Center(child: Text("No articles available"));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
              indent: MediaQuery.of(context).size.width * 0.3,
              endIndent: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return NewsCard(
              imageUrl: articles[index].urlToImage,
              headline: articles[index].title,
              author: articles[index].author,
              date: articles[index].publishedAt,
            );
          },
        );
      } else {
        return const Center(child: Text("loading data ..."));
      }
    },
  );
}

}