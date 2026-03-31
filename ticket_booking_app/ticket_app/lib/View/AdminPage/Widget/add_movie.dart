import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/ViewModel/BloC/MovieBloc/movie_bloc.dart';
import 'package:ticket_app/ViewModel/utill.dart';

import '../../../ViewModel/BloC/MovieBloc/movie_event.dart';

class MovieForm extends StatefulWidget {
  const MovieForm({Key? key}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {


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
      _selectedImageBanner = image?.path;
      _imageBannerController.text = _selectedImageBanner.toString();
    });
  }
  Future<void> _pickImageAsset() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImageAsset = image?.path;
      _imageAssetController.text = _selectedImageAsset.toString();
    });
  }
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
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
                          borderRadius: BorderRadius.circular(10)
                      ),
                      fixedSize: Size(100, 40),
                      backgroundColor: const Color(0xFF5E548E)
                  ),

                  onPressed: _pickImageAsset,
                  child: const Text(
                    'Choose',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                _selectedImageAsset != null
                    ? Image.file(
                  File(_selectedImageAsset!),
                  width: 100,
                  height: 100,
                )
                    : const Text('No image selected', style: TextStyle(color: Colors.white)),
              ],
            ),
            TextFormField(
              controller: _imageBannerController,

              decoration: const InputDecoration(
                labelText: 'Image Banner',
                hintText: 'Enter image',
                labelStyle:  TextStyle(color: Colors.white),
                hintStyle:  TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),

            ),
            // Chọn ảnh từ thư viện
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                      fixedSize: Size(100, 40),
                    backgroundColor: const Color(0xFF5E548E)
                  ),

                  onPressed: _pickImage,
                  child: const Text(
                      'Choose',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                _selectedImageBanner != null
                    ? Image.file(
                  File(_selectedImageBanner!),
                  width: 100,
                  height: 100,
                )
                    : const Text('No image selected', style: TextStyle(color: Colors.white)),
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
                var data = {
                  "id" : "movie_${Utill.generateRandomString(10)}",
                  "title": _titleController.text,
                  "description": _descriptionController.text,
                  "favourite": _favouriteController.text,
                  "author": _authorController.text,
                  "category": _categoryController.text,
                  "acter": _acterController.text,
                };
                context.read<MovieBloc>().add(
                    AddMovie(data: data, context: context, imageAssets: File(_selectedImageAsset!), imageBanner: File(_selectedImageBanner!))
                );
                //bloc.event.add(AddMovie(data: data, context: context, imageAssets: File(_selectedImageAsset!), imageBanner: File(_selectedImageBanner!)));
              },
              child: const Text('Submit', style: TextStyle(color: Colors.white),),
            ),
          ],
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
