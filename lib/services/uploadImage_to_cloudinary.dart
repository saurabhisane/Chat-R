import 'dart:io';
import 'package:dio/dio.dart';

Future<String?> UploadImageToCloudinary(File image) async {
  const String cloudName = 'dwrw0svfc';
  const String uploadPreset = 'chat_img'; // Unsigned preset configured in Cloudinary

  final String uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

  try {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path),
      'upload_preset': uploadPreset, // Required for unsigned uploads
    });

    Response response = await Dio().post(uploadUrl, data: formData);

    if (response.statusCode == 200) {
      // Return the secure URL of the uploaded image
      print("Image uploaded successfully: ${response.data['secure_url']}");
      return response.data['secure_url'];
    } else {
      // Log the error
      print("Error uploading image: ${response.data}");
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }

}
