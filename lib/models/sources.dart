
class Sources {
  String? status;
  String? code;
  String? message;
  List<Sources1>? sources;

  Sources({this.status,this.code, this.message, this.sources});

  Sources.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["code"] is String) {
      status = json["code"];
    }
    if(json["message"] is String) {
      status = json["message"];
    }
    if(json["sources"] is List) {
      sources = json["sources"] == null ? null : (json["sources"] as List).map((e) => Sources1.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["code"] = code;
    data["message"] = message;
    if(sources != null) {
      data["sources"] = sources?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Sources1 {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  Sources1({this.id, this.name, this.description, this.url, this.category, this.language, this.country});

  Sources1.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["category"] is String) {
      category = json["category"];
    }
    if(json["language"] is String) {
      language = json["language"];
    }
    if(json["country"] is String) {
      country = json["country"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["url"] = url;
    data["category"] = category;
    data["language"] = language;
    data["country"] = country;
    return data;
  }
}