import 'package:flutter_test/flutter_test.dart';
import 'package:memcache_plugin/memcache_plugin.dart';
import 'package:memcache_plugin/memcache_plugin_platform_interface.dart';
import 'package:memcache_plugin/memcache_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMemcachePluginPlatform
    with MockPlatformInterfaceMixin
    implements MemcachePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MemcachePluginPlatform initialPlatform = MemcachePluginPlatform.instance;

  test('$MethodChannelMemcachePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMemcachePlugin>());
  });

  test('getPlatformVersion', () async {
    MemcachePlugin memcachePlugin = MemcachePlugin();
    MockMemcachePluginPlatform fakePlatform = MockMemcachePluginPlatform();
    MemcachePluginPlatform.instance = fakePlatform;

    expect(await memcachePlugin.getPlatformVersion(), '42');
  });
}
