import 'dart:developer';

import 'package:astronomy_picture/core/date_convert.dart';
import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/pages/core/see_full_image.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_video.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/apod_view_button.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;

  const ApodViewPage({
    required this.apod,
    super.key,
  });

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late Apod apod;

  bool isImage = true;

  @override
  void initState() {
    apod = widget.apod;

    checkMediaType();

    super.initState();
  }

  void checkMediaType() {
    if (apod.mediaType == 'video' || apod.mediaType == null) {
      isImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: CustomColors.white),
            color: CustomColors.black,
            itemBuilder: (context) => buildMenuButtons(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [CustomColors.spaceBlue, CustomColors.black],
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRect(child: buildMediaType()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 350, 30, 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerLeft,
                          colors: [
                            CustomColors.blue,
                            CustomColors.vermilion,
                            CustomColors.vermilion,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: CustomColors.white.withOpacity(.3)),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue.withOpacity(.7),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apod.title ?? '',
                            style: TextStyle(
                              fontSize: 22,
                              color: CustomColors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            apod.explanation ?? '',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'by ${apod.copyright ?? 'NASA'}',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                          Text(
                            'date: ${DateConvert.dateToString(apod.date)} (YYYY-MM-DD)',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ApodViewButton(
                      icon: Icons.open_in_browser,
                      title: 'Show media',
                      description:
                          'if media are not able on app, tap here to see on browser',
                      onTap: () {},
                    ),
                    const SizedBox(width: 15),
                    ApodViewButton(
                      icon: Icons.bookmark_outline,
                      title: 'Save',
                      description:
                          'Save this content for quick access in future',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMediaType() {
    if (isImage) {
      log('is image!!');

      return GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(apod.url ?? ''),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            border: Border.all(
              color: CustomColors.white.withOpacity(.5),
            ),
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    SeeFullImage(url: apod.hdurl ?? apod.url ?? ''))),
      );
    } else {
      log('is video!!');

      return Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(apod.thumbnailUrl ??
                'https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg'),
            fit: BoxFit.fitHeight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(
            color: CustomColors.white.withOpacity(.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ApodVideo(url: apod.url ?? ''),
          ],
        ),
      );
    }
  }

  List<PopupMenuItem> buildMenuButtons() {
    List<PopupMenuItem> list = [];

    if (isImage) {
      list.add(PopupMenuItem(
        textStyle: TextStyle(color: CustomColors.white),
        onTap: saveOnGallery,
        child: const Text('Save Image on gallery'),
      ));
    }

    list.addAll([
      PopupMenuItem(
        textStyle: TextStyle(color: CustomColors.white),
        onTap: shareOnlyLink,
        child: const Text('Shared media only'),
      ),
      PopupMenuItem(
        textStyle: TextStyle(color: CustomColors.white),
        onTap: shareAllContent,
        child: const Text('Shared all content'),
      ),
    ]);

    return list;
  }

  void saveOnGallery() {
    if (isImage) {
      GallerySaver.saveImage(apod.hdurl ?? apod.url ?? '').then((value) {
        if (value == true) {
          setState(() => showSnackBar('Image save on gallery!!'));
        }
      });
    }
  }

  void shareOnlyLink() => Share.share(apod.hdurl ?? apod.url ?? '');

  void shareAllContent() {
    String link = apod.hdurl ?? apod.url ?? '';

    Share.share(
        '${apod.title}\n\n${apod.explanation}\n\nlink: $link\nby: ${apod.copyright}');
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
