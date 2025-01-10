import 'package:flutter/material.dart';
import 'responsive_config.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = ResponsiveConfig.getDeviceType(screenWidth);
    switch (deviceType) {
      case DeviceType.desktop:
        return desktop;
      case DeviceType.tablet:
        return tablet;
      default:
        return mobile;
    }
  }
}
