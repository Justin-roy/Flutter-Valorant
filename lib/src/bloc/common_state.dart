import 'package:flutter_valorant/src/model/valorant_character_model.dart';

class CommonState {
  final List<ValorantCharacterData> valorantCharacterData;
  CommonState({
    required this.valorantCharacterData,
  });

  CommonState copyWith({
    List<ValorantCharacterData>? valorantCharacterData,
  }) {
    return CommonState(
      valorantCharacterData:
          valorantCharacterData ?? this.valorantCharacterData,
    );
  }
}
