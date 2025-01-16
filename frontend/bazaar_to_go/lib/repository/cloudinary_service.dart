import 'dart:io';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
    static Future<Uri> uploadFile(File file) async {
    try {
      var cloudinary = Cloudinary.fromStringUrl(
          'cloudinary://239118281366527:${dotenv.env['CloudinaryApi']}@daj7vxuyb');
      cloudinary.config.urlConfig.secure = true;

      var response = await cloudinary.uploader().upload(
            file,
            params: UploadParams(
              folder: "ONDC",
              uniqueFilename: true,
              useFilename: true,
              overwrite: false,
              resourceType: 'auto',
            ),
          );

      if (response != null &&
          response.data != null &&
          response.data?.secureUrl != null) {
        return Uri.parse(response.data!.secureUrl!);
      }
      return Uri.parse('https://example.com');
    } catch (e) {
      rethrow;
    }
  }
  
  static fromStringUrl(String s) {}
}