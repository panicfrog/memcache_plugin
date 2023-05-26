import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:memcache_plugin/memcache_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _memcachePlugin = MemcachePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getPut();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = 'hello world';
    });
  }

  void getPut() {
    final stopwatch = Stopwatch()..start();
    final result = _memcachePlugin.putString("stringKey", "value");
    stopwatch.stop();
    if (result == 101) {
      debugPrint("putString success ${stopwatch.elapsedMicroseconds.toDouble() / 1000.0}ms");
    } else {
      debugPrint("putString failed");
    }
    final getStopwatch = Stopwatch()..start();
    final value = _memcachePlugin.getString("stringKey");
    getStopwatch.stop();
    if (value != null) {
      debugPrint("getString success: $value with ${getStopwatch.elapsedMicroseconds.toDouble() / 1000.0}ms");
    } else {
      debugPrint("getString failed");
    }

    final deleteResult = _memcachePlugin.deleteValue("stringKey");
    if (deleteResult == 101) {
      debugPrint("deleteValue success");
    } else {
      debugPrint("deleteValue failed");
    }
    final deleteValue = _memcachePlugin.getString("stringKey");
    if (deleteValue == null) {
      debugPrint("deleteValue success");
    } else {
      debugPrint("deleteValue failed");
    }

    final putBytes = _memcachePlugin.putBytes("bytesKey", Uint8List.fromList([1, 2, 3, 4, 5]));
    if (putBytes == 101) {
      debugPrint("putBytes success");
    } else {
      debugPrint("putBytes failed");
    }
    final getBytes = _memcachePlugin.getBytes("bytesKey");
    if (getBytes != null) {
      debugPrint("getBytes success: $getBytes");
    } else {
      debugPrint("getBytes failed");
    }

    final putInt = _memcachePlugin.putInt("intKey", 123);
    if (putInt == 101) {
      debugPrint("putInt success");
    } else {
      debugPrint("putInt failed");
    }
    final getInt = _memcachePlugin.getInt("intKey");
    if (getInt != null) {
      debugPrint("getInt success: $getInt");
    } else {
      debugPrint("getInt failed");
    }

    final putDouble = _memcachePlugin.putDouble("doubleKey", 123.456);
    if (putDouble == 101) {
      debugPrint("putDouble success");
    } else {
      debugPrint("putDouble failed");
    }
    final getDouble = _memcachePlugin.getDouble("doubleKey");
    if (getDouble != null) {
      debugPrint("getDouble success: $getDouble");
    } else {
      debugPrint("getDouble failed");
    }
    
    final putBool = _memcachePlugin.putBool("boolKey", true);
    if (putBool == 101) {
      debugPrint("putBool success");
    } else {
      debugPrint("putBool failed");
    }
    final getBool = _memcachePlugin.getBool("boolKey");
    if (getBool != null) {
      debugPrint("getBool success: $getBool");
    } else {
      debugPrint("getBool failed");
    }

    final stringMap = <String, String>{"putStringsKey1": "value1", "putStringsKey2": "value2"};
    final putStrings= _memcachePlugin.putStrings(stringMap);
    if (putStrings == 101) {
      debugPrint("putStrings success");
    } else {
      debugPrint("putStrings failed");
    }
    final getStrings1 = _memcachePlugin.getString("putStringsKey1");
    if (getStrings1 != null) {
      debugPrint("getStrings success: $getStrings1");
    } else {
      debugPrint("getStrings failed");
    }
    final getStrings2 = _memcachePlugin.getString("putStringsKey2");
    if (getStrings2 != null) {
      debugPrint("getStrings success: $getStrings2");
    } else {
      debugPrint("getStrings failed");
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
