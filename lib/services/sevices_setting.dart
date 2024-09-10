import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SevicesSetting extends GetxService{
SharedPreferences? sharedP;
Future <SevicesSetting> init()async{

sharedP=await SharedPreferences.getInstance();

return this;

}



}