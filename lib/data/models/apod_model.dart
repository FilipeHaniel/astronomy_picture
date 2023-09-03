import 'package:astronomy_picture/domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel({
    super.copyright,
    super.date,
    super.explanation,
    super.hdurl,
    super.mediaType,
    super.serviceVersion,
    super.thumbnailUrl,
    super.title,
    super.url,
  });

  // Cria apodmodel baseado em Json

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      copyright: json['copyright'] ?? 'Nasa Apod',
      date: DateTime.parse(json['date']),
      explanation: json['explanation'],
      mediaType: json['mediaType'],
      serviceVersion: json['serviceVersion'],
      title: json['title'],
      url: json['url'],
      hdurl: json['hdurl'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  // Cria Json baseado em apodmodel

  Map<String, dynamic> toJson() {
    return {
      'copyright': copyright,
      'date': date.toString(),
      'explanation': explanation,
      'mediaType': mediaType,
      'serviceVersion': serviceVersion,
      'title': title,
      'url': url,
      'hdurl': hdurl,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
