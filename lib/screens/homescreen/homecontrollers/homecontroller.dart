import 'dart:ffi';

import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:finalgame/routes/approutes.dart';

class HomeController extends GetxController {
  Rx<CameraController?> _cameraController = Rx<CameraController?>(null);
  CameraController get cameraController => _cameraController.value!;
  Rx<Future<void>?> _initializeControllerFuture = Rx<Future<void>?>(null);
  Future<void>? get initializeControllerFuture =>
      _initializeControllerFuture.value;
  Rx<img.Image?> _capturedImage = Rx<img.Image?>(null);
  img.Image? get capturedImage => _capturedImage.value;
  RxBool _isControllerInitialized = false.obs;
  bool get isControllerInitialized => _isControllerInitialized.value;
  RxBool _isloading = false.obs;
  bool get isloading => _isloading.value;

  @override
  void onInit() {
    // Perform initialization tasks
    super.onInit();
    _initCameraWithDelay();
  }

  void _initCameraWithDelay() async {
    await Future.delayed(Duration(seconds: 2)); // Add a delay of 2 seconds
    _initCamera();
    update();
  }

  void _initCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = cameras.first;
    _cameraController.value = CameraController(
      selectedCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture.value =
        _cameraController.value?.initialize().then((_) {
      _isControllerInitialized.value = true;
      update();
    });
    update();
  }

  void captureImage() async {
    try {
      await _initializeControllerFuture;
      final XFile imageFile = await _cameraController.value!.takePicture();
      final capturedImage = img.decodeImage(await imageFile.readAsBytes());

      _capturedImage.value = capturedImage;
    } catch (e) {
      print('Error capturing image: $e');
    }
    update();
  }

  void uploadImageToFirebase() async {
    _isloading.value = true;
    update();
    if (_capturedImage != null) {
      final storage = FirebaseStorage.instance;
      final name = "${DateTime.now()}";
      final Reference ref = storage.ref().child('images/$name.jpg');
      final imageBytes = img.encodeJpg(capturedImage!);
      final metadata = SettableMetadata(contentType: 'image/jpeg');

      try {
        final UploadTask uploadTask = ref.putData(imageBytes, metadata);
        await uploadTask;
        _isloading.value = false;
        Get.offNamed(AppRoutes.goodjobscreen);

        Get.defaultDialog(
          title: 'Done',
          middleText: "Thank you for sharing food with me ",

          backgroundColor:
              Color(0xff3E8B3A), // Set the background color to green
          confirmTextColor: Colors.white,
          buttonColor: Colors.grey,
          onConfirm: () {
            Get.back();
          },
        );
        print('Image uploaded to Firebase Storage');
      } catch (e) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Error uploading image to Firebase Storage: $e',
          backgroundColor: Colors.green, // Set the background color to green
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
        print('Error uploading image to Firebase Storage: $e');
      }
    }
  }
}
