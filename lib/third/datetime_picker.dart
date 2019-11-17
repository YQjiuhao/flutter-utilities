// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
/// 
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/// 日期选择器
datePicker(context,
    {DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    DateTime minTime,
    DateTime maxTime}) {
  DatePicker.showDatePicker(context,
      showTitleActions: true,
      minTime: minTime ?? DateTime(1970, 1, 1),
      maxTime: maxTime ?? DateTime(2100, 1, 1),
      onChanged: onChanged,
      onConfirm: onConfirm,
      currentTime: DateTime.now(),
      locale: LocaleType.zh);
}

/// 日期时间选择器
dateTimePicker(context,
    {DateChangedCallback onChanged, DateChangedCallback onConfirm}) {
  DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      onChanged: onChanged,
      onConfirm: onConfirm,
      currentTime: DateTime.now(),
      locale: LocaleType.zh);
}
