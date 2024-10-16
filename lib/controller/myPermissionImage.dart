import 'package:permission_handler/permission_handler.dart';

class MyPermissionImage {
  init() async{
    PermissionStatus status = await Permission.photos.status;
  }
  
  checkPermission(PermissionStatus statut){
    switch(statut){
      case PermissionStatus.permanentlyDenied: return Future.error("Impossible d'accéder à la caméra");
      case PermissionStatus.denied: return Permission.photos.request();
      case PermissionStatus.restricted: return Permission.photos.request();
      case PermissionStatus.limited: return Permission.photos.request();
      case PermissionStatus.provisional: return Permission.photos.request();
      case PermissionStatus.granted: return Permission.photos.request();
    };
  }
}