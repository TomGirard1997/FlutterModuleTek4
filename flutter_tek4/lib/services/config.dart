library config.globals;
import 'package:flutter_tek4/themes/theme.dart';
import 'package:hive/hive.dart';

MyTheme currentTheme = MyTheme();
Box box = Hive.box('myTheme');