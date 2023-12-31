import 'package:flutter/material.dart';
import 'package:ytm_downloader_gui/downloader.dart';
import 'form.dart';
import 'metadata.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.download_outlined),
            onPressed: () async {
              if (Downloader.isValidLink(context, _linkController.text)) {
                String id = Downloader.getId(_linkController.text);
                SongMetadata metadata = await Downloader.getMetadata(id);
                if (!context.mounted) return;
                showDownloadForm(context, id, metadata);
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('ytm_downloader_gui'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _linkController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text('Music Link'),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _linkController.text = '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
