class ResponsiveConfig {
  static const double mobileBreakpoint = 600.0; // Width < 600 is mobile
  static const double tabletBreakpoint = 800.0; // Width >= 600 and < 1200 is tablet
  static const double desktopBreakpoint = 1200.0; // Width >= 1200 is desktop

  static DeviceType getDeviceType(double width) {
    if (width >= desktopBreakpoint) {
      return DeviceType.desktop;
    } else if (width >= tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}

enum DeviceType { mobile, tablet, desktop }