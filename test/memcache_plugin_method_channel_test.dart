import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memcache_plugin/memcache_plugin_method_channel.dart';

void main() {
  MethodChannelMemcachePlugin platform = MethodChannelMemcachePlugin();
  const MethodChannel channel = MethodChannel('memcache_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
