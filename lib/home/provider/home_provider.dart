import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindus_test2/home/model/category_model.dart';
import 'package:noviindus_test2/home/model/home_Model.dart';
import 'package:noviindus_test2/home/service/home_service.dart';
import 'package:noviindus_test2/widgets/customSnackbar.dart';
import 'package:noviindus_test2/widgets/response_model.dart';
import 'package:video_player/video_player.dart';

class Homeprovider extends ChangeNotifier {
   final _homeService = HomeService();
Homeprovider(){
  getHomeDatas();
  getCategories();
  notifyListeners();
}

 List<FeedResult> _feedVideos = [];
  List<FeedResult> get feedVideos => _feedVideos;

  int _selectedintex = 0;
 int get selectedintex => _selectedintex;



  Future<void> getHomeDatas() async {
    HomeModel homeModel = await _homeService.getHomeData();
    if (homeModel.results.isNotEmpty) {
      _feedVideos = homeModel.results;
      notifyListeners();
    }
  }



 Future<void> setSelectedIndex(int index) async {

    _selectedintex = index;
    notifyListeners();
   
 }




































//  =========================================== ADD FEED  SECTION =======================================



  bool _isLoading = false;
  bool get isLoading => _isLoading;

 
  List<newCategory> _newcategories = [];
  List<newCategory> get newcategories => _newcategories;


   List<Categories> _categorys = [];
  List<Categories> get categorys => _categorys;

  final TextEditingController _descriptionController = TextEditingController();
TextEditingController get descriptionController => _descriptionController;
 VideoPlayerController? videoController;

  File? _videoFile;
  File? _thumbnailFile;
  File? get videoFile => _videoFile;
  File? get thumbnailFile => _thumbnailFile;


  Future<void> getCategories() async {
 
    CategoryModel categoryModel = await _homeService.getCategory();
    if (categoryModel.categories!.isNotEmpty) {

      List<Categories> categorys = categoryModel.categories!;
      _newcategories = categorys.map((category) => newCategory(id: category.id!, categorie: category)).toList();
    
      _categorys = categorys;
      notifyListeners();
    }
  }
Future<void> addVideo(BuildContext context) async {
   ResponseModel response =  await _homeService.uploadFeed(videoFile!, thumbnailFile!, descriptionController.text, newcategories.where((category) => category.isSelected).map((category) => category.id).toList());

   if(response.status! ){
    CustomSnackbar.show(context: context, message:  response.message!, isSucces: true);
     ClearData();
   } else {
      CustomSnackbar.show(context: context, message:  response.message!, isSucces: false);
   }
  }

   Future<void> updateCategory(int  index ) async {
     newcategories[index].isSelected = !newcategories[index].isSelected;
      notifyListeners();  
   }
  Future<void> pickVideo( ) async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
    setVideoFile(File(video.path));
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setThumbnailFile(File(image.path));
    }
  }

  void setVideoFile(File? file) {
    _videoFile = file;
    initializeVideoController();
    notifyListeners();
  }


  void setThumbnailFile(File? file) {
    _thumbnailFile = file;
    notifyListeners();
  }

 Future<void> playVideo() async {
    if (videoController != null) {
      await videoController!.play();
    }
  
 }
 
 Future<void> initializeVideoController() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      
  try {
       await videoController!.initialize();
    } catch (e) {
      debugPrint("Error initializing video: $e");
    }

     
      notifyListeners();
    }
  }




   @override
  void dispose() {
    videoController?.dispose();
    videoController = null;
    _descriptionController.dispose();
    _videoFile = null;
    _thumbnailFile = null;
    RefreshNewCategory();
    super.dispose();
  }
  
 Future<void> RefreshNewCategory() async {
    _newcategories = _categorys.map((category) => newCategory(id: category.id!, categorie: category)).toList();
    notifyListeners();
   
 }
  Future<void> ClearData() async {
    _videoFile = null;
    _thumbnailFile = null;
    _descriptionController.clear();
    RefreshNewCategory();
    notifyListeners();
  }


 
}






class newCategory {
  final int id;
  final Categories categorie;
  bool isSelected;

   newCategory({
    required this.id,
    required  this.categorie,
    this.isSelected = false, 
  });

  newCategory copyWith({
    int? id,
    String? name,
    bool? isSelected,
  }) {
    return newCategory(
      id: this.id,
      categorie: this.categorie,
      isSelected: this.isSelected,
    );
  }

}