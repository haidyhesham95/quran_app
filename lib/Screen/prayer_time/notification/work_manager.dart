
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import 'dart:math';



class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
  StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }


  static Future init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));


    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }
  static int notificationId = 0;
  static Future<void> showDailySchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily schduled notification',
      'id 4',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = NotificationDetails(android: android);

    var scheduleTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: 15));

    final messages = [
      'الله أكبر',
      'الحمد لله',
      'لا إله إلا الله',
      'سبحان الله',
      'استغفر الله العظيم '
      'لا حول ولا قوة إلا بالله',
      'اللهم إنّك عفو تحب العفو فاعفُ عنا',
      'اللهم أنت السلام ، ومنك السلام ، تباركت يا ذا الجلال والإكرام',
      'سبحان الله ',
      'سيجعل الله بعد عسرٍ يسرًا',
      'سبحان الله وبحمده'
      'استغفر الله العظيم لا اله الا هو الحي القيوم وأتوب إليه',
      'اللهم إني أسألك الهدى والتقى والعفو والغفران',
      'اللهم إني أعوذ بك من الهم والحزن والعجز والكسل والبخل والجبن وضلع الدين وغلبة الرجال',
      'اللهم أعنِّي على ذكرك وشكرك وحسن عبادتك',
      'سبحان الله وبحمده عدد خلقه وزنة عرشه ورضى نفسه ومداد كلماته',
      'إن الله وملائكته يصلون على النبي يأيها الذين آمنو صلوا عليه وسلموا تسليمًا'
      'وعسى أن تكرهوا شيئًا وهو خير لكم وعسى أن تحبوا شيئًا وهو شر لكم والله يعلم وأنتم لا تعلمون',
      'اللهم أحسن ظننا في الناس. وأحسن ظن الناس فينا',
      'من شكر لله قولًا وعملًا. زاده من فضله وأحسن له العاقبة',
      'ولسوف يعطيك ربك فترضى. ولا تنسى عنه في العالم',
      'ربي أوزعني أن أشكر نعمتك التي أنعمت علي',
      'اللهم يا مقلب القلوب ثبت قلبي على دينك',
      'اللهم إني أعوذ بك من الفقر والقلة والذلة وأعوذ بك من أن أظلم أو أظلم',
      'ربي..أبعد عنا موت الفجأة في ساعة الغفلة',
      'ابتسم.. فالأمور تسير كما قدر الله لها',
      'يا رب اذهب عنا الحزن وأزل عنا الهم',
      'الحمد لله حمدًا نتجاوز به ضيقة الأرض لسعة السماء',
      'الله أكبر',
      'الحمد لله',
      'لا إله إلا الله',
      'سبحان الله',
      'استغفر الله العظيم ',
      'لا حول ولا قوة إلا بالله',
      'اللهم إنّك عفو تحب العفو فاعفُ عنا',
      'إِنَّ اللَّهَ وَمَلائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ يَا أَيُّهَا الَّذِينَ آمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا'
      'لا حول ولا قوة إلا بالله',
      'لا اله الا انت سبحانك اني كنت من الظالمين',
      'ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار',
      'ربنا لا تؤاخذنا إن نسينا أو أخطأنا',
      'ربنا لا تزغ قلوبنا بعد إذ هديتنا وهب لنا من لدنك رحمة إنك أنت الوهاب',
      'ربنا لا تجعلنا فتنة للذين كفروا واغفر لنا ربنا إنك أنت العزيز الحكيم',
      'ربنا ظلمنا انفسنا وان لم تغفر لنا وترحمنا لنكونن من الخاسرين',





    ];
    final random = Random();
    final randomMessage = messages[random.nextInt(messages.length)];

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId++,
      '',
      randomMessage,
      scheduleTime,
      details,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
