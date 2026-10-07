import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReporterWebViewScreen extends StatefulWidget {
  final String reporterName;

  const ReporterWebViewScreen({super.key, required this.reporterName});

  @override
  State<ReporterWebViewScreen> createState() => _ReporterWebViewScreenState();
}

class _ReporterWebViewScreenState extends State<ReporterWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0;

  static const String postNewEditorUrl = 'https://www.news7india.com/wp-admin/post-new.php';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100.0;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('त्रुटि: ${error.description}')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(postNewEditorUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'खबर प्रकाशित करें',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'wp-admin/post-new.php',
              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              }
            },
            tooltip: 'पीछे जाएँ',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
            tooltip: 'रिफ्रेश',
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pop(context),
            tooltip: 'बाहर निकलें',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            LinearProgressIndicator(
              value: _progress > 0 ? _progress : null,
              color: const Color(0xFFD32F2F),
              backgroundColor: Colors.white,
            ),
        ],
      ),
    );
  }
}