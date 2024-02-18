import 'dart:convert';

class JsonConvert {
  static T deserializeObject<T>(dynamic json) {
    T result = jsonDecode(json);
    return result;
  }
}
