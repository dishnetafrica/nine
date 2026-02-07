import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/login_page.dart';
import 'features/customers/presentation/customers_page.dart';
import 'features/dashboard/presentation/dashboard_page.dart';
import 'features/hotspot/presentation/hotspot_page.dart';
import 'features/mikrotik/presentation/mikrotik_page.dart';
import 'features/settings/presentation/settings_page.dart';
import 'features/starlink/presentation/starlink_page.dart';
import 'features/uisp/presentation/uisp_page.dart';
import 'features/voucher/presentation/voucher_page.dart';
import 'shared/widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/starlink',
          builder: (context, state) => const StarlinkPage(),
        ),
        GoRoute(
          path: '/mikrotik',
          builder: (context, state) => const MikroTikPage(),
        ),
        GoRoute(
          path: '/hotspot',
          builder: (context, state) => const HotspotPage(),
        ),
        GoRoute(
          path: '/vouchers',
          builder: (context, state) => const VoucherPage(),
        ),
        GoRoute(
          path: '/customers',
          builder: (context, state) => const CustomersPage(),
        ),
        GoRoute(
          path: '/uisp',
          builder: (context, state) => const UispPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);

void goToHome(BuildContext context) => context.go('/dashboard');
