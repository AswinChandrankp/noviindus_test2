import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:noviindus_test2/auth/service/auth_service.dart';
import 'package:noviindus_test2/constants.dart';
import 'package:noviindus_test2/home/model/category_model.dart';
import 'package:noviindus_test2/home/model/home_Model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:noviindus_test2/widgets/response_model.dart';


class HomeService {

 final AuthService _authService = AuthService();


Future<HomeModel> getHomeData() async {
    try {
      final url = Uri.parse('${AppConstants.BaseUrl}${AppConstants.home}');
      final token = await _authService.getToken();
      
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseBody = jsonDecode(response.body);
        
        if (responseBody != null) {
          return HomeModel.fromJson(responseBody);
        } else {
          throw FormatException('Unexpected response format: ${response.body}');
        }
      } else {
        throw HttpException('Failed to load home data: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid response format: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }


  Future<CategoryModel> getCategory() async {

      try {
      final url = Uri.parse('${AppConstants.BaseUrl}${AppConstants.Categorys}');
      final token = await _authService.getToken();
      
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseBody = jsonDecode(response.body);
        
        if (responseBody != null) {
          print(responseBody);
          return CategoryModel.fromJson(responseBody); 
        } else {
          throw FormatException('Unexpected response format: ${response.body}');
        }
      } else {
        throw HttpException('Failed to load home data: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid response format: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }




Future<ResponseModel> uploadFeed(
 File videoFile,
  File thumbnailFile,
   String description,
   List<int> selectedCategoryIds,
) async {
  try {
    final url = Uri.parse('${AppConstants.BaseUrl}${AppConstants.addFeed}'); 
    final token = await _authService.getToken();

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'video',
      videoFile.path,
      contentType: MediaType('video', 'mp4'),
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      thumbnailFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));
    request.fields['desc'] = description;
    request.fields['category'] = selectedCategoryIds.join(',').toString();

    final response = await request.send();
    final   ResponseModel responseBody = ResponseModel.fromJson(jsonDecode(await response.stream.bytesToString()));

    if (response.statusCode == 200 || response.statusCode == 202) {
      return responseBody;
    } else {
      return responseBody;
   
      
    }
  } on http.ClientException catch (e) {
    throw Exception('Network error: ${e.message}');
  } on FormatException catch (e) {
    throw Exception('Invalid response format: ${e.message}');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}







}
   