import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/FormAppBar.dart';
import 'package:flutter_application_1/common/SlidePageTransition.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final String author;
  final String hoursAgo;
  final String url;
  final String imageUrl;

  NewsCard({
    @required this.title,
    @required this.author,
    @required this.hoursAgo,
    @required this.url,
    @required this.imageUrl,
  });

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with TickerProviderStateMixin {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  void changeOpacity() {
    Future.delayed(Duration(milliseconds: 225), () {
      setState(() {
        this.opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, SlidePageTransition(page: WebPage(url: widget.url))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(7, 10, 5, 10),
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: AnimatedOpacity(
              opacity: this.opacity,
              duration: Duration(milliseconds: 1250),
              child: Container(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: const_black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  "${widget.author} \u2022 ${widget.hoursAgo} ",
                  style: TextStyle(
                    color: const_grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class WebPage extends StatefulWidget {
  final String url;

  WebPage({
    @required this.url,
  });

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: formAppBar(context, ""),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onPageFinished: (String finish) {
              setState(() {
                this.isLoading = false;
              });
            },
          ),
          this.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(const_blue)))
              : Container(),
        ],
      ),
    );
  }
}
