

import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class MovieEvent{}


class MovieFetch extends MovieEvent{}

class AddMovie extends MovieEvent{
  final Object data;
  final BuildContext context;
  final File imageAssets;
  final File imageBanner;
  AddMovie({required this.data, required this.context, required this.imageAssets, required this.imageBanner});
}
class DeleteMovie extends MovieEvent{
  BuildContext context;
  String id;
  DeleteMovie({required this.context, required this.id});
}

class EditMovie extends MovieEvent {
  final Map<String, dynamic> data;
  final BuildContext context;
  final String imageAsset;
  final String imageBanner;

  EditMovie({
    required this.data,
    required this.context,
    required this.imageAsset,
    required this.imageBanner,

  });
}