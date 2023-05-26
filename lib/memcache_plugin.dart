
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'package:memcache_plugin/src/memcache_generated_bindings.dart';

class MemcachePlugin {

  final MemCacheNative _cache;

  MemcachePlugin() : _cache = MemCacheNative(Platform.isAndroid
    ? DynamicLibrary.open("libMemCache.so")
    : DynamicLibrary.process());

  String? getString(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var valueCString = calloc.allocate<Pointer<Char>>(1);
    var result = _cache.MemCache_get_string(keyCString, valueCString);
    String? value;
    if (result) {
      value = valueCString.value.cast<Utf8>().toDartString();
    }
    calloc.free(keyCString);
    calloc.free(valueCString);
    return value;
  }

  int? getInt(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var value = calloc.allocate<Int>(1);
    var result = _cache.MemCache_get_int(keyCString, value);
    int? valueInt;
    if (result) {
      valueInt = value.value;
    }
    calloc.free(keyCString);
    calloc.free(value);
    return valueInt;
  }

  double? getDouble(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var value = calloc.allocate<Double>(1);
    var result = _cache.MemCache_get_double(keyCString, value);
    double? valueDouble;
    if (result) {
      valueDouble = value.value;
    }
    calloc.free(keyCString);
    calloc.free(value);
    return valueDouble;
  }

  bool? getBool(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var value = calloc.allocate<Bool>(1);
    var result = _cache.MemCache_get_bool(keyCString, value);
    bool? valueBool;
    if (result) {
      valueBool = value.value;
    }
    calloc.free(keyCString);
    calloc.free(value);
    return valueBool;
  }

  Uint8List? getBytes(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var value = calloc.allocate<Pointer<Uint8>>(1);
    var length = calloc.allocate<Size>(1);
    var result = _cache.MemCache_get_bytes(keyCString, length, value);
    Uint8List? valueBytes;
    if (result) {
      valueBytes = value.value.asTypedList(length.value);
    }
    calloc.free(keyCString);
    calloc.free(value);
    calloc.free(length);
    return valueBytes;
  }

  int putString(String key, String value) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var valueCString = value.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_put_string(keyCString, valueCString);
    calloc.free(keyCString);
    calloc.free(valueCString);
    return reslut;
  }

  int putInt(String key, int value) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_put_int(keyCString, value);
    calloc.free(keyCString);
    return reslut;
  }

  int putDouble(String key, double value) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_put_double(keyCString, value);
    calloc.free(keyCString);
    return reslut;
  }

  int putBool(String key, bool value) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_put_bool(keyCString, value);
    calloc.free(keyCString);
    return reslut;
  }

  int putBytes(String key, Uint8List bytes) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    final pointer = calloc<Uint8>(bytes.length);
    pointer.asTypedList(bytes.length).setAll(0, bytes);
    var reslut = _cache.MemCache_put_bytes(keyCString, pointer, bytes.length);
    calloc.free(keyCString);
    calloc.free(pointer);
    return reslut;
  }

  int putInts(Map<String, int> kvs) {
    var keysCString = calloc.allocate<Pointer<Char>>(kvs.length);
    var valuesCInt = calloc.allocate<Int>(kvs.length);
    var i = 0;
    kvs.forEach((key, value) {
      keysCString[i] = key.toNativeUtf8().cast<Char>();
      valuesCInt[i] = value;
      i++;
    });
    var reslut = _cache.MemCache_put_ints(keysCString, valuesCInt, kvs.length);
    for (var i = 0; i < kvs.length; i++) {
      calloc.free(keysCString[i]);
    }
    calloc.free(keysCString);
    calloc.free(valuesCInt);
    return reslut;
  }

  int putDoubles(Map<String, double> kvs) {
    var keysCString = calloc.allocate<Pointer<Char>>(kvs.length);
    var valuesCDouble = calloc.allocate<Double>(kvs.length);
    var i = 0;
    kvs.forEach((key, value) {
      keysCString[i] = key.toNativeUtf8().cast<Char>();
      valuesCDouble[i] = value;
      i++;
    });
    var reslut = _cache.MemCache_put_doubles(keysCString, valuesCDouble, kvs.length);
    for (var i = 0; i < kvs.length; i++) {
      calloc.free(keysCString[i]);
    }
    calloc.free(keysCString);
    calloc.free(valuesCDouble);
    return reslut;
  }

  int putBools(Map<String, bool> kvs) {
    var keysCString = calloc.allocate<Pointer<Char>>(kvs.length);
    var valuesCBool = calloc.allocate<Bool>(kvs.length);
    var i = 0;
    kvs.forEach((key, value) {
      keysCString[i] = key.toNativeUtf8().cast<Char>();
      valuesCBool[i] = value;
      i++;
    });
    var reslut = _cache.MemCache_put_bools(keysCString, valuesCBool, kvs.length);
    for (var i = 0; i < kvs.length; i++) {
      calloc.free(keysCString[i]);
    }
    calloc.free(keysCString);
    calloc.free(valuesCBool);
    return reslut;
  }

  int putStrings(Map<String, String> kvs) {
    var keysCString = calloc.allocate<Pointer<Char>>(kvs.length);
    var valuesCString = calloc.allocate<Pointer<Char>>(kvs.length);
    var i = 0;
    kvs.forEach((key, value) {
      keysCString[i] = key.toNativeUtf8().cast<Char>();
      valuesCString[i] = value.toNativeUtf8().cast<Char>();
      i++;
    });
    var reslut = _cache.MemCache_put_strings(keysCString, valuesCString, kvs.length);
    for (var i = 0; i < kvs.length; i++) {
      calloc.free(keysCString[i]);
      calloc.free(valuesCString[i]);
    }
    calloc.free(keysCString);
    calloc.free(valuesCString);
    return reslut;
  }

  int deleteValue(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_delete_value(keyCString);
    calloc.free(keyCString);
    return reslut;
  }

  int deleteJson(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_delete_json(keyCString);
    calloc.free(keyCString);
    return reslut;
  }

  int putJson(String key, String json) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var jsonCString = json.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_put_json(keyCString, jsonCString);
    calloc.free(keyCString);
    calloc.free(jsonCString);
    return reslut;
  }

  String? getJson(String key) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var jsonCString = calloc.allocate<Pointer<Char>>(1);
    var result = _cache.MemCache_get_json(keyCString, jsonCString);
    String? json;
    if (result) {
      json = jsonCString.value.cast<Utf8>().toDartString();
    }
    calloc.free(keyCString);
    calloc.free(jsonCString);
    return json;
  }

  int modifyJson(String key, String path, String value) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var pathCString = path.toNativeUtf8().cast<Char>();
    var valueCString = value.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_modify_json(keyCString, pathCString, valueCString);
    calloc.free(keyCString);
    calloc.free(pathCString);
    calloc.free(valueCString);
    return reslut;
  }

  int patchJson(String key, String json) {
    var keyCString = key.toNativeUtf8().cast<Char>();
    var jsonCString = json.toNativeUtf8().cast<Char>();
    var reslut = _cache.MemCache_patch_json(keyCString, jsonCString);
    calloc.free(keyCString);
    calloc.free(jsonCString);
    return reslut;
  }

}
