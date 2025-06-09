import 'package:simple/Bloc/Response/errorResponse.dart';

/// success : true
/// data : {"status":true,"events":[{"title":"Testing","event_date":"20-03-2025","description":"Testing","banner_image":"https://pauldentalcare.com/lara/front-ends/events/1742413595_banner3.jpg","images":["https://pauldentalcare.com/lara/front-ends/events/1742413595ab2.jpg","https://pauldentalcare.com/lara/front-ends/events/1748950390_1_istockphoto-483338630-612x612.jpg"]},{"title":"Testing 2","event_date":"21-03-2025","description":"Testing","banner_image":"https://pauldentalcare.com/lara/front-ends/events/1742414165_ab1.jpg","images":[]}]}
/// message : "Events List"

class GetEventModel {
  GetEventModel({
    bool? success,
    Data? data,
    String? message,
    ErrorResponse? errorResponse,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  GetEventModel.fromJson(dynamic json) {
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
  GetEventModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      GetEventModel(
        success: success ?? _success,
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
    if (errorResponse != null) {
      map['errors'] = errorResponse!.toJson();
    }
    return map;
  }
}

/// status : true
/// events : [{"title":"Testing","event_date":"20-03-2025","description":"Testing","banner_image":"https://pauldentalcare.com/lara/front-ends/events/1742413595_banner3.jpg","images":["https://pauldentalcare.com/lara/front-ends/events/1742413595ab2.jpg","https://pauldentalcare.com/lara/front-ends/events/1748950390_1_istockphoto-483338630-612x612.jpg"]},{"title":"Testing 2","event_date":"21-03-2025","description":"Testing","banner_image":"https://pauldentalcare.com/lara/front-ends/events/1742414165_ab1.jpg","images":[]}]

class Data {
  Data({
    bool? status,
    List<Events>? events,
  }) {
    _status = status;
    _events = events;
  }

  Data.fromJson(dynamic json) {
    _status = json['status'];
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Events>? _events;
  Data copyWith({
    bool? status,
    List<Events>? events,
  }) =>
      Data(
        status: status ?? _status,
        events: events ?? _events,
      );
  bool? get status => _status;
  List<Events>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "Testing"
/// event_date : "20-03-2025"
/// description : "Testing"
/// banner_image : "https://pauldentalcare.com/lara/front-ends/events/1742413595_banner3.jpg"
/// images : ["https://pauldentalcare.com/lara/front-ends/events/1742413595ab2.jpg","https://pauldentalcare.com/lara/front-ends/events/1748950390_1_istockphoto-483338630-612x612.jpg"]

class Events {
  Events({
    String? title,
    String? eventDate,
    String? description,
    String? bannerImage,
    List<String>? images,
  }) {
    _title = title;
    _eventDate = eventDate;
    _description = description;
    _bannerImage = bannerImage;
    _images = images;
  }

  Events.fromJson(dynamic json) {
    _title = json['title'];
    _eventDate = json['event_date'];
    _description = json['description'];
    _bannerImage = json['banner_image'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _title;
  String? _eventDate;
  String? _description;
  String? _bannerImage;
  List<String>? _images;
  Events copyWith({
    String? title,
    String? eventDate,
    String? description,
    String? bannerImage,
    List<String>? images,
  }) =>
      Events(
        title: title ?? _title,
        eventDate: eventDate ?? _eventDate,
        description: description ?? _description,
        bannerImage: bannerImage ?? _bannerImage,
        images: images ?? _images,
      );
  String? get title => _title;
  String? get eventDate => _eventDate;
  String? get description => _description;
  String? get bannerImage => _bannerImage;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['event_date'] = _eventDate;
    map['description'] = _description;
    map['banner_image'] = _bannerImage;
    map['images'] = _images;
    return map;
  }
}
