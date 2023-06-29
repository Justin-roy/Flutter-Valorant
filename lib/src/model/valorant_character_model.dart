class ValorantCharacterModel {
  int status;
  List<ValorantCharacterData> data;

  ValorantCharacterModel({
    required this.status,
    required this.data,
  });

  factory ValorantCharacterModel.fromJson(Map<String, dynamic> json) =>
      ValorantCharacterModel(
        status: json["status"],
        data: List<ValorantCharacterData>.from(
            json["data"].map((x) => ValorantCharacterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ValorantCharacterData {
  String uuid;
  String displayName;
  String displayIcon;
  String background;
  String description;
  String fullPortraitV2;
  String killfeedPortrait;
  List<String> backgroundGradientColors;
  VoiceLine voiceLine;

  ValorantCharacterData({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.fullPortraitV2,
    required this.killfeedPortrait,
    required this.backgroundGradientColors,
    required this.voiceLine,
    required this.displayIcon,
    required this.background,
  });

  factory ValorantCharacterData.fromJson(Map<String, dynamic> json) =>
      ValorantCharacterData(
        uuid: json["uuid"],
        displayName: json["displayName"],
        displayIcon: json["displayIcon"],
        description: json["description"],
        background: json["background"] ??
            'https://media.valorant-api.com/agents/add6443a-41bd-e414-f6ad-e58d267f4e95/background.png',
        fullPortraitV2: json["fullPortraitV2"] ??
            'https://media.valorant-api.com/agents/e370fa57-4757-3604-3648-499e1f642d3f/fullportrait.png',
        killfeedPortrait: json["killfeedPortrait"],
        backgroundGradientColors:
            List<String>.from(json["backgroundGradientColors"].map((x) => x)),
        voiceLine: VoiceLine.fromJson(json["voiceLine"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "displayIcon": displayIcon,
        "description": description,
        "fullPortraitV2": fullPortraitV2,
        "killfeedPortrait": killfeedPortrait,
        "background": background,
        "backgroundGradientColors":
            List<dynamic>.from(backgroundGradientColors.map((x) => x)),
        "voiceLine": voiceLine.toJson(),
      };
}

class VoiceLine {
  double minDuration;
  double maxDuration;
  List<MediaList> mediaList;

  VoiceLine({
    required this.minDuration,
    required this.maxDuration,
    required this.mediaList,
  });

  factory VoiceLine.fromJson(Map<String, dynamic> json) => VoiceLine(
        minDuration: json["minDuration"]?.toDouble(),
        maxDuration: json["maxDuration"]?.toDouble(),
        mediaList: List<MediaList>.from(
            json["mediaList"].map((x) => MediaList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "minDuration": minDuration,
        "maxDuration": maxDuration,
        "mediaList": List<dynamic>.from(mediaList.map((x) => x.toJson())),
      };
}

class MediaList {
  int id;
  String wwise;
  String wave;

  MediaList({
    required this.id,
    required this.wwise,
    required this.wave,
  });

  factory MediaList.fromJson(Map<String, dynamic> json) => MediaList(
        id: json["id"],
        wwise: json["wwise"],
        wave: json["wave"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wwise": wwise,
        "wave": wave,
      };
}
