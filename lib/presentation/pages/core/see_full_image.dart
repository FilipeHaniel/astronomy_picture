import 'package:astronomy_picture/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SeeFullImage extends StatefulWidget {
  final String url;

  const SeeFullImage({
    required this.url,
    super.key,
  });

  @override
  State<SeeFullImage> createState() => _SeeFullImageState();
}

class _SeeFullImageState extends State<SeeFullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: CustomColors.spaceBlue.withOpacity(0),
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.download, color: CustomColors.white),
            label: Text(
              'Save on gallery',
              style: TextStyle(color: CustomColors.white),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: InteractiveViewer(
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRect(
              clipBehavior: Clip.none,
              child: Image.network(
                widget.url,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void savveOnGallery() {
    GallerySaver.saveImage(widget.url).then((value) {
      if (value == true) {
        setState(() => showSnackBar('Image save on gallery!!'));
      }
    });
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
