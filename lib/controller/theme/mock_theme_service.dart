import 'package:chat/controller/theme/backend_types.dart';
import 'package:chat/controller/theme/base_theme_service.dart';

class MockAppTheme extends AppTheme {
  @override
  ThemeBackendType getRequiredService() {
    return ThemeBackendType.MOCK;
  }

  @override
  Future<void> loadSettings() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  Future<void> saveSettings() async {
    await Future.delayed(Duration(milliseconds: 200));
  }
}
