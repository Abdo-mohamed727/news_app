import 'package:flutter/material.dart';
import 'package:newss_app/core/apis/api_service.dart';
import 'package:newss_app/models/news_model.dart';

import 'package:newss_app/widgets/image_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff1877F2),
        title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService.getNews(),
        builder: (context, snapshot) {
          List<Article> articles = snapshot.data?.articles ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error From Api'));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ImageItemWidget(
                image: articles[index].urlToImage ?? dummyImage,
                title: articles[index].title ?? '',
                onTap: () {},
              );
            },
            itemCount: articles.length,
          );
        },
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
