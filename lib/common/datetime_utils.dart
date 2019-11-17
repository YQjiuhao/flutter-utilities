// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
/// 
import 'package:intl/intl.dart';

class DateTimeUtils {
  /// 距离今天多少天 +(n):未来n天，-(n):过去n天
  /// fromDate: 距离今天的日期
  static int diffNowDay(String fromDate) {
    DateTime now = new DateTime.now();
    String date = format(now);
    return DateTime.parse(fromDate).difference(DateTime.parse(date)).inDays;
  }

  static int diff(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    return endDate.difference(startDate).inDays;
  }

  /// 时间格式化，返回字符串，默认格式：2019-01-01
  static String format(DateTime date, {String format = 'y-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  /// 计算过期时间(年、月、日)
  ///
  /// 返回值为null,已过期
  static String beforeDate(String endDate, {String beginDate}) {
    try {
      DateTime start =
          beginDate != null ? DateTime.parse(beginDate) : DateTime.now();
      int startY = start.year;
      int startM = start.month;
      int startD = start.day;

      DateTime end = DateTime.parse(endDate);
      DateTime subEnd = end.subtract(Duration(days: startD));
      int endY = subEnd.year;
      int endM = subEnd.month;
      // 这里如果2019-04-12至2019-04-12算第二天到期(+1)
      int endD = subEnd.day + 1;

      if (end.isBefore(start)) return null;
      int endDayOnMonth = daysOnMonth(endY, endM);
      if (endD >= endDayOnMonth) {
        // 一个月完成
        endM += 1;
        endD = endD - endDayOnMonth;
      }
      int deltaM = (endY - startY) * 12 + (endM - startM);
      int lastY = deltaM ~/ 12;
      int lastM = deltaM % 12;
      String result = '';
      if (lastY > 0) result += lastY.toString() + '年';
      if (lastM > 0) result += lastM.toString() + '个月';
      if (endD > 0) result += endD.toString() + '天';
      return result;
    } catch (e) {
      print(e);
      return '不存在时间';
    }
  }

  /// 这个月多少天
  static int daysOnMonth(int year, int month) {
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) return 31;
    if ([4, 6, 9, 11].contains(month)) return 30;
    if ((year % 4) == 0) return 29;
    return 28;
  }

  /// 计算年龄
  static int age(String birthday) {
    try {
      if (birthday == null) return null;
      DateTime start = DateTime.parse(birthday);
      int startY = start.year;
      int startM = start.month;
      int startD = start.day;

      DateTime end = DateTime.now();
      DateTime subEnd = end.subtract(Duration(days: startD));
      int endY = subEnd.year;
      int endM = subEnd.month;
      // 这里如果2019-04-12至2019-04-12算第二天到期(+1)
      int endD = subEnd.day + 1;

      if (end.isBefore(start)) return 0;
      int endDayOnMonth = daysOnMonth(endY, endM);
      if (endD >= endDayOnMonth) {
        // 一个月完成
        endM += 1;
        endD = endD - endDayOnMonth;
      }
      int deltaM = (endY - startY) * 12 + (endM - startM);
      return deltaM ~/ 12;
    } catch (e) {
      print('error:$e');
      return null;
    }
  }
}
