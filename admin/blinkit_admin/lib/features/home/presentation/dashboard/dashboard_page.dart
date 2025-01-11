import 'package:blinkit_admin/core/responsive/responsive_widget.dart';
import 'package:blinkit_admin/features/home/presentation/dashboard/dashboard_desktop.dart';
import 'package:blinkit_admin/features/home/presentation/dashboard/dashboard_mobile.dart';
import 'package:blinkit_admin/features/home/presentation/dashboard/dashboard_tablet.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: DashboardMobile(),
      tablet: DashboardTablet(),
      desktop: DashboardDesktop(),
    );
  }
}
