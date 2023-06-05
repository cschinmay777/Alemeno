import 'package:finalgame/screens/goodjobscreen/goodjobscreen.dart';
import 'package:finalgame/routes/approutes.dart';
import 'package:finalgame/screens/homescreen/homecontrollers/homecontroller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CameraScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    // if (!homeController.isControllerInitialized) {
    //   return Scaffold(
    //     body: Align(
    //       alignment: Alignment.center,
    //       child: Container(
    //         height: height / 2,
    //         width: width / 2,
    //         // margin: EdgeInsets.only(bottom: height / 8),
    //         child: Lottie.asset("assets/loader.json"),
    //       ),
    //     ),
    //   );
    // }
    return GetBuilder<HomeController>(builder: (controller1) {
      if (!controller1.isControllerInitialized) {
        return Scaffold(
          body: Align(
            alignment: Alignment.center,
            child: Container(
              height: height / 2,
              width: width / 2,
              // margin: EdgeInsets.only(bottom: height / 8),
              child: Lottie.asset("assets/loader.json"),
            ),
          ),
        );
      }

      return Scaffold(
        body: GetBuilder<HomeController>(builder: (controller) {
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Align(
                    alignment: AlignmentDirectional(0, -0.75),
                    child: Container(
                      height: height / 1.5,
                      width: width / 1,
                      child: Image.asset(
                        "assets/img.png",
                      ),
                    )),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  height: height / 1.68,
                  width: double.infinity,
                  // color: Color(0xffF4F4F4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Color(0xffF4F4F4)),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.45),
                child: AnimatedContainer(
                  height: height / 3.2,
                  width: double.infinity,
                  // color: Color(0xffF4F4F4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Color(0xffF4F4F4)),
                  // child: CameraPreview(_controller),
                  duration: Duration(seconds: 1),
                  child: controller.capturedImage == null
                      ? FutureBuilder<void>(
                          future: controller.initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (!controller.isControllerInitialized) {
                              // `_initializeControllerFuture` is initialized and has completed
                              // Add your code here
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Center(
                                child: Container(
                                  width: height / 4.2,
                                  height: height / 4.2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: AspectRatio(
                                      aspectRatio: controller
                                          .cameraController.value.aspectRatio,
                                      child: CameraPreview(
                                          controller.cameraController),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      : Center(
                          child: Container(
                            width: height / 4.2,
                            height: height / 4.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.memory(
                                img.encodeJpg(controller.capturedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Visibility(
                visible: controller.capturedImage == null,
                child: Align(
                  alignment: AlignmentDirectional(-0.5, 0.1),
                  child: Container(
                    height: width / 10,
                    width: width / 10,
                    // color: Color(0xffF4F4F4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color(0xffF4F4F4)),
                    child: Image.asset("assets/tl.png"),
                  ),
                ),
              ),
              Visibility(
                visible: controller.capturedImage == null,
                child: Align(
                  alignment: AlignmentDirectional(-0.5, 0.56),
                  child: Container(
                    height: width / 9.6,
                    width: width / 9.6,
                    // color: Color(0xffF4F4F4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color(0xffF4F4F4)),
                    child: Image.asset("assets/bl.png"),
                  ),
                ),
              ),
              Visibility(
                visible: controller.capturedImage == null,
                child: Align(
                  alignment: AlignmentDirectional(0.55, 0.56),
                  child: Container(
                    height: width / 9.6,
                    width: width / 9.6,
                    // color: Color(0xffF4F4F4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color(0xffF4F4F4)),
                    child: Image.asset("assets/br.png"),
                  ),
                ),
              ),
              Visibility(
                visible: controller.capturedImage == null,
                child: Align(
                  alignment: AlignmentDirectional(0.55, 0.1),
                  child: Container(
                    height: width / 9.6,
                    width: width / 9.6,
                    // color: Color(0xffF4F4F4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color(0xffF4F4F4)),
                    child: Image.asset("assets/tr.png"),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.91, 0.50),
                child: Container(
                  height: height / 3,
                  width: width / 8,
                  child: Image.asset("assets/fork.png"),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.96, 0.50),
                child: Container(
                  height: height / 2.8,
                  width: width / 6.8,
                  child: Image.asset(
                    "assets/spoon.png",
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.735),
                child: Container(
                    child: Text(
                  controller.capturedImage == null
                      ? "Click your meal"
                      : "Will you eat this",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                )),
              ),
              GetBuilder<HomeController>(builder: (controlller2) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: controlller2.capturedImage == null
                        ? FloatingActionButton(
                            backgroundColor: Color(0xff3E8B3A),
                            onPressed: controller.captureImage,
                            child: Icon(
                              Icons.camera_alt_sharp,
                              size: 38,
                              color: Colors.white,
                            ),
                          )
                        : FloatingActionButton(
                            backgroundColor: Color(0xff3E8B3A),
                            onPressed: controller.uploadImageToFirebase,
                            child: controlller2.isloading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.done,
                                    size: 38,
                                    color: Colors.white,
                                  ),
                          ),
                  ),
                );
              }),
              Align(
                alignment: AlignmentDirectional(-0.96, -0.9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.offNamed(AppRoutes.welcomescreen);
                    },
                    child: Material(
                      shape: CircleBorder(),
                      elevation: 10,
                      child: CircleAvatar(
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            size: 38,
                            color: Colors.white,
                          ),
                        ),
                        radius: 25,
                        backgroundColor: Color(0xff3E8B3A),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
