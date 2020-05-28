import 'package:http/http.dart' as http;
class API {
  static Future getUsers() {
    var url = "https://melange2020.in/Reg/data.json";
    print(http.get(url));
    return http.get(url);
  }
}
