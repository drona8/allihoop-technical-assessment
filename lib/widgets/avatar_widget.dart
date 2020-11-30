import 'dart:io';

import '../services/utility/image_utility.dart';

import '../services/storage/avatar_service.dart';
import '../services/storage/avatar_storage_service.dart';
import '../styles/color.dart';
import '../widgets/app_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatefulWidget {
  final String imageURL;
  AvatarWidget({
    this.imageURL,
  });
  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<AvatarStorageService>(context, listen: false);
    final database = Provider.of<AvatarService>(context, listen: false);
    return Container(
      child: widget.imageURL != null
          ? GestureDetector(
              onTap: () async {
                PickedFile _pFile;
                await ImageUtility.showImageDialog(context, (PickedFile file) {
                  setState(() {
                    _pFile = file;
                    Navigator.pop(context);
                  });
                });
                if (_pFile != null) {
                  final downloadUrl =
                      await storage.uploadAvatar(file: File(_pFile.path));

                  await database.setAvatarReference(downloadUrl);
                }
              },
              child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColor.BLACK,
                  ),
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(25),
                ),
                child: ClipOval(
                  child: AppCachedNetworkImage(
                    imageURL: widget.imageURL,
                    fit: BoxFit.fill,
                    color: Colors.transparent,
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () async {
                PickedFile _pFile;
                await ImageUtility.showImageDialog(context, (PickedFile file) {
                  setState(() {
                    _pFile = file;
                    Navigator.pop(context);
                  });
                });
                if (_pFile != null) {
                  final downloadUrl =
                      await storage.uploadAvatar(file: File(_pFile.path));

                  await database.setAvatarReference(downloadUrl);
                }
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: new BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: () async {
                    PickedFile _pFile;
                    await ImageUtility.showImageDialog(context,
                        (PickedFile file) {
                      setState(() {
                        _pFile = file;
                        Navigator.pop(context);
                      });
                    });
                    if (_pFile != null) {
                      final downloadUrl =
                          await storage.uploadAvatar(file: File(_pFile.path));

                      await database.setAvatarReference(downloadUrl);
                    }
                  },
                  child: Icon(Icons.add_a_photo_rounded),
                  mini: true,
                  splashColor: AppColor.blue,
                ),
              ),
            ),
    );
  }
}
