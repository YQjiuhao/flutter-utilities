// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
///
import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../widgets/cupertino_swipe_back_observer.dart';

bool isNull(Object data) {
  if (data == null) return true;

  if (data is Map) return data.isEmpty;

  if (data is String) return data.isEmpty;

  if (data is List) return data.isEmpty;

  if (data is Set) return data.isEmpty;

  return false;
}

bool isNotNull(var data) {
  return !isNull(data);
}

String convertMD5(String obj) {
  List<int> objBytes = Utf8Encoder().convert(obj);
  Digest digest = md5.convert(objBytes);
  return hex.encode(digest.bytes);
}

/// 金额数字格式化，保留两位小数
String moneyFormat(var number, {String format = '#,###.##'}) {
  final formatter = NumberFormat(format);
  if (number is num) {
    return formatter.format(number);
  } else {
    // 不是number 类型的视为非法
    return null;
  }
}

/// push进入一个新界面
Future pushPage(context, Widget page,
    {bool maintainState = false, bool fullscreenDialog = false}) async {
  await CupertinoSwipeBackObserver.promise?.future;
  return await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => page,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    ),
  );
}

Future pushNamed(context, String name, Object arguments) async {
  await CupertinoSwipeBackObserver.promise?.future;
  return await Navigator.pushNamed(context, name, arguments: arguments);
}

/// Util for collections.
class KaCollections {
  /// Wrap List.reduce with a check list is null or empty.
  static E reduce<E>(List<E> list, E combine(E e0, E e1)) =>
      (list == null || list.isEmpty) ? null : list.reduce(combine);

  /// Wrap List.fold with a check list is null or empty.
  static T fold<T, E>(T init, List<E> list, T combine(T e0, E e1)) =>
      (list == null || list.isEmpty) ? init : list.fold(init, combine);

  /// Flatten list
  /// For example:
  /// List<String> a = ['a', 'b', 'c'];
  /// List<String> b = ['1', '2', '3'];
  /// List<List<String>> list = [a, b] // [[a, b, c], [1, 2, 3]]
  /// List<String> listFlatten = Collections.flatten(list) // [a, b, c, 1, 2, 3]
  static List<E> flatten<E>(List<List<E>> lists) => reduce(lists, merge);

  /// Merge two Iterable
  /// List<String> a = ['a', 'b', 'c'];
  /// List<String> b = ['1', '2', '3'];
  /// List<String> listMerge = Collections.merge(a, b) // [a, b, c, 1, 2, 3]
  static List<T> merge<T>(Iterable<T> a, Iterable<T> b) =>
      <T>[]..addAll(a ?? <T>[])..addAll(b ?? <T>[]);

  static List<T> clone<T>(Iterable<T> a) =>
      (a == null || a.isEmpty) ? <T>[] : (<T>[]..addAll(a));

  /// Cast map to list
  /// Map<String, String> map = {'key0': 'a', 'key1': 'b', 'key2': 'c'};
  /// Function mapFunction = (String value, String key) => value;
  /// List<String> list = Collections.castMapToList<String, String, String>(
  ///        map, mapFunction); // [a, b, c]
  static List<T> castMapToList<T, K, V>(Map<K, V> map0, T map(V v, K k)) =>
      map0.entries
          .map((MapEntry<K, V> entry) => map(entry.value, entry.key))
          .toList();

  /// Cast map with a map function
  static Map<K, V1> castMap<K, V0, V1>(Map<K, V0> map0, V1 map(V0 v0, K k)) =>
      <K, V1>{}..addEntries(castMapToList<MapEntry<K, V1>, K, V0>(
          map0, (V0 v, K k) => MapEntry<K, V1>(k, map(v, k))));

  /// Emit item null and return new list.
  /// List<String> list = ['1', '2', null, '3', null];
  /// print(list)                       // [1, 2, null, 3, null]
  /// print(Collections.compact(list)); // [1, 2, 3]
  static List<T> compact<T>(Iterable<T> list, {bool growable = true}) =>
      list?.where((T e) => e != null)?.toList(growable: growable);

  /// Check if an Object is Empty.
  static bool isEmpty(Object value) {
    if (value == null) {
      return true;
    } else {
      if (value is String) {
        return value.isEmpty;
      } else if (value is List) {
        return value.isEmpty;
      } else if (value is Map) {
        return value.isEmpty;
      } else if (value is Set) {
        return value.isEmpty;
      } else {
        return false;
      }
    }
  }

  static bool isNotEmpty(Object value) => !isEmpty(value);
}

/// 金额数字格式化，保留两位小数
String formatDouble(num number, {String formart = '#,###.##'}) {
  final formatter = NumberFormat(formart);
  if (number is num) {
    return formatter.format(number);
  } else {
    // 不是number 类型的视为非法
    return null;
  }
}
