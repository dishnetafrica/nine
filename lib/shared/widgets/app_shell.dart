import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.child,
    required this.currentLocation,
    super.key,
  });

  final Widget child;
  final String currentLocation;

  static const _items = <({String label, String route, IconData icon})>[
    (label: 'Dashboard', route: '/dashboard', icon: Icons.dashboard_outlined),
    (label: 'Starlink', route: '/starlink', icon: Icons.satellite_alt_outlined),
    (label: 'MikroTik', route: '/mikrotik', icon: Icons.router_outlined),
    (label: 'Hotspot', route: '/hotspot', icon: Icons.wifi_tethering_outlined),
    (label: 'Vouchers', route: '/vouchers', icon: Icons.receipt_long_outlined),
    (label: 'Customers', route: '/customers', icon: Icons.people_outline),
    (label: 'UISP', route: '/uisp', icon: Icons.cloud_outlined),
    (label: 'Settings', route: '/settings', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nine ISP Suite')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Navigation')),
            ..._items.map(
              (item) => ListTile(
                leading: Icon(item.icon),
                title: Text(item.label),
                selected: currentLocation == item.route,
                onTap: () {
                  Navigator.pop(context);
                  context.go(item.route);
                },
              ),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
