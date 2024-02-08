import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationControllerProvider extends GetxController {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: Get.find(),
    );
    animationController.repeat();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class MyAnimationController extends GetxController
    with SingleGetTickerProviderMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  void startAnimation() {
    _controller.forward(); // Start the animation
  }

  void stopAnimation() {
    _controller.stop(); // Stop the animation
  }

  AnimationController get controller => _controller;
  Animation<double> get animation => _animation;

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
