import 'api.dart';

class Repo {
  String? getImageExtensionFromUrl(String url) {
    RegExp regExp = RegExp(r'(?:\.([^.]+))?$');
    return regExp.firstMatch(url)?.group(1);
  }

  Future<dynamic> getAgents() async {
    return await ApiHelper.get("/agents");
  }
}
