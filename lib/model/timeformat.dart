import 'package:intl/intl.dart';

class TimeDate {
  static String orderTimeDate(int time) {
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat("dd-MM-yyyy HH:mm").format(notificationDate);
  }
}
