import 'package:simple/Bloc/Response/errorResponse.dart';
/// success : true
/// data : {"status":true,"awareness":[{"title":"Awarez","url":"https://www.youtube.com/watch?v=I7-G4rrQyx0","event_date":"02-04-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1743849551_images.jpeg","images":[]},{"title":"Precautions","url":"https://www.youtube.com/watch?v=Z1iHVxOCCkA","event_date":"05-04-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1743852011_istockphoto-1276634862-612x612.jpg","images":[]},{"title":"Dental","url":"https://youtu.be/GLeUJhybJQw?si=Vst-u94SJNsrc9kd","event_date":"02-06-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1748860097_DENTAL AWARENESS (1) (1).png","images":[]}]}
/// message : "Awareness List"

class GetAwarenessModel {
  GetAwarenessModel({
      bool? success,
      Data? data,
      String? message,
      ErrorResponse? errorResponse,
  }) {
    _success = success;
    _data = data;
    _message = message;
}

  GetAwarenessModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
    if (json['errors'] != null && json['errors'] is Map<String, dynamic>) {
      errorResponse = ErrorResponse.fromJson(json['errors']);
    } else {
      errorResponse = null;
    }
  }
  bool? _success;
  Data? _data;
  String? _message;
  ErrorResponse? errorResponse;
GetAwarenessModel copyWith({  bool? success,
  Data? data,
  String? message,
}) => GetAwarenessModel(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// status : true
/// awareness : [{"title":"Awarez","url":"https://www.youtube.com/watch?v=I7-G4rrQyx0","event_date":"02-04-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1743849551_images.jpeg","images":[]},{"title":"Precautions","url":"https://www.youtube.com/watch?v=Z1iHVxOCCkA","event_date":"05-04-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1743852011_istockphoto-1276634862-612x612.jpg","images":[]},{"title":"Dental","url":"https://youtu.be/GLeUJhybJQw?si=Vst-u94SJNsrc9kd","event_date":"02-06-2025","banner_image":"https://pauldentalcare.com/lara/front-ends/awareness/1748860097_DENTAL AWARENESS (1) (1).png","images":[]}]

class Data {
  Data({
      bool? status,
      List<Awareness>? awareness,
  }){
    _status = status;
    _awareness = awareness;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
    if (json['awareness'] != null) {
      _awareness = [];
      json['awareness'].forEach((v) {
        _awareness?.add(Awareness.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Awareness>? _awareness;
Data copyWith({  bool? status,
  List<Awareness>? awareness,
}) => Data(  status: status ?? _status,
  awareness: awareness ?? _awareness,
);
  bool? get status => _status;
  List<Awareness>? get awareness => _awareness;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_awareness != null) {
      map['awareness'] = _awareness?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "Awarez"
/// url : "https://www.youtube.com/watch?v=I7-G4rrQyx0"
/// event_date : "02-04-2025"
/// banner_image : "https://pauldentalcare.com/lara/front-ends/awareness/1743849551_images.jpeg"
/// images : []

class Awareness {
  Awareness({
      String? title,
      String? url,
      String? eventDate,
      String? bannerImage,
      List<dynamic>? images,}){
    _title = title;
    _url = url;
    _eventDate = eventDate;
    _bannerImage = bannerImage;
    _images = images;
}

  Awareness.fromJson(dynamic json) {
    _title = json['title'];
    _url = json['url'];
    _eventDate = json['event_date'];
    _bannerImage = json['banner_image'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(v.toString());
      });
    }
  }
  String? _title;
  String? _url;
  String? _eventDate;
  String? _bannerImage;
  List<dynamic>? _images;
Awareness copyWith({  String? title,
  String? url,
  String? eventDate,
  String? bannerImage,
  List<dynamic>? images,
}) => Awareness(  title: title ?? _title,
  url: url ?? _url,
  eventDate: eventDate ?? _eventDate,
  bannerImage: bannerImage ?? _bannerImage,
  images: images ?? _images,
);
  String? get title => _title;
  String? get url => _url;
  String? get eventDate => _eventDate;
  String? get bannerImage => _bannerImage;
  List<dynamic>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['url'] = _url;
    map['event_date'] = _eventDate;
    map['banner_image'] = _bannerImage;
    if (_images != null) {
      map['images'] = _images;
    }
    return map;
  }
}