
class News {
  String? status;
  String? code;
  String? message;
  int? totalResults;
  List<Articles>? articles;

  News({this.status, this.code, this.message, this.totalResults, this.articles});

  News.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["code"] is String) {
      status = json["code"];
    }
    if(json["message"] is String) {
      status = json["message"];
    }
    if(json["totalResults"] is int) {
      totalResults = json["totalResults"];
    }
    if(json["articles"] is List) {
      articles = json["articles"] == null ? null : (json["articles"] as List).map((e) => Articles.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["code"] = code;
    data["message"] = message;
    data["totalResults"] = totalResults;
    if(articles != null) {
      data["articles"] = articles?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  dynamic description;
  String? url;
  dynamic urlToImage;
  String? publishedAt;
  dynamic content;

  Articles({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    if(json["source"] is Map) {
      source = json["source"] == null ? null : Source.fromJson(json["source"]);
    }
    if(json["author"] is String) {
      author = json["author"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    description = json["description"];
    if(json["url"] is String) {
      url = json["url"];
    }
    urlToImage = json["urlToImage"];
    if(json["publishedAt"] is String) {
      publishedAt = json["publishedAt"];
    }
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(source != null) {
      data["source"] = source?.toJson();
    }
    data["author"] = author;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["content"] = content;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}