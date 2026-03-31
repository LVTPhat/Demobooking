import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_event.dart';

import 'package:ticket_app/ViewModel/service_request.dart';
import 'package:ticket_app/ViewModel/utill.dart';

class EditMoviePage extends StatefulWidget {
  final MovieModel movieModel;
  const EditMoviePage({Key? key, required this.movieModel}) : super(key: key);

  @override
  _EditMoviePageState createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageAssetController = TextEditingController();
  final TextEditingController _imageBannerController = TextEditingController();
  final TextEditingController _favouriteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _acterController = TextEditingController();

   String? _selectedImageBanner;
   String? _selectedImageAsset;

  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImageBanner = image!.path;
      _imageBannerController.text = _selectedImageBanner.toString();
    });
  }
  Future<void> _pickImageAsset() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImageAsset = image!.path;
      _imageAssetController.text = _selectedImageAsset.toString();
    });
  }
  late MovieModel movie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movie = widget.movieModel;
    if(movie != null){
      _titleController.text = movie.title.toString();
      _descriptionController.text = movie.description.toString();
      _favouriteController.text = movie.favourite.toString();
      _authorController.text = movie.author.toString();
      _categoryController.text = movie.category.toString();
      _acterController.text = movie.acter.toString();
    }
  }
  @override
  Widget build(BuildContext context) {

    //var bloc = Provider.of<MovieBloc>(context);
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
        leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          //print('ok');
          Navigator.pop(context);
        },
        child: const Icon(Icons.navigate_before_sharp, color: Colors.white, size: 30),
        ),
        backgroundColor: const Color(0xFF1E192B),
        title: const Text(
        'Edit Panel',
        style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        ),
        backgroundColor: const Color(0xFF1E192B),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
        
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter title',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: _imageAssetController,
                  decoration: const InputDecoration(
                    labelText: 'Image Asset',
                    hintText: 'Enter image',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(100, 40),
                        backgroundColor: const Color(0xFF5E548E),
                      ),
                      onPressed: _pickImageAsset,
                      child: const Text(
                        'Choose',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _selectedImageAsset != null && _selectedImageAsset!.isNotEmpty
                        ? Image.file(
                      File(_selectedImageAsset!),
                      width: 100,
                      height: 100,
                    )
                        : Image.network(
                      '${ServiceRequest.baseURL}${movie.imageasset.toString()}',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),

                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(100, 40),
                        backgroundColor: const Color(0xFF5E548E),
                      ),
                      onPressed: _pickImage,
                      child: const Text(
                        'Choose',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _selectedImageBanner != null && _selectedImageBanner!.isNotEmpty
                        ? Image.file(
                      File(_selectedImageBanner!),
                      width: 100,
                      height: 100,
                    )
                        : Image.network(
                      '${ServiceRequest.baseURL}${movie.imagebanner.toString()}',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),

                TextFormField(
                  controller: _favouriteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Favourite',
                    hintText: 'Enter favourite count',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: _authorController,
                  decoration: const  InputDecoration(
                    labelText: 'Author',
                    hintText: 'Enter author name',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration:const  InputDecoration(
                    labelText: 'Category',
                    hintText: 'Enter category',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  controller: _acterController,
                  decoration: const InputDecoration(
                    labelText: 'Acter',
                    hintText: 'Enter acter name',
                    labelStyle:  TextStyle(color: Colors.white),
                    hintStyle:  TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    fixedSize: Size(100, 40),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    print('edit ');
                    var data = {
                      "id" : movie.id,
                      "title": _titleController.text,
                      "description": _descriptionController.text,
                      "favourite": _favouriteController.text,
                      "author": _authorController.text,
                      "category": _categoryController.text,
                      "acter": _acterController.text,
                    };
                    context.read<MovieBloc>().add(
                      EditMovie(
                        data: data,
                               context:  context,
                               imageAsset: _selectedImageAsset.toString(),
                              imageBanner: _selectedImageBanner.toString()
                      )
                    );
                    // bloc.event.add(EditMovie(
                    //         data: data,
                    //        context:  context,
                    //        imageAsset: _selectedImageAsset.toString(),
                    //       imageBanner: _selectedImageBanner.toString()
                    // ));
                    // if (_selectedImageAsset != null && _selectedImageBanner != null) {
                    //   bloc.event.add(EditMovie(
                    //     data,
                    //     context,
                    //     File(_selectedImageAsset!),
                    //     File(_selectedImageBanner!),
                    //   ));
                    // } else {
                    //   bloc.event.add(EditMovie2(
                    //     data: data,
                    //     context: context,
                    //
                    //   ));
                    // }




                  },
                  child: const Text('Submit', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageAssetController.dispose();
    _imageBannerController.dispose();
    _favouriteController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    _acterController.dispose();
    super.dispose();
  }
}
