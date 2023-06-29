import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_valorant/src/api/repo.dart';
import 'package:flutter_valorant/src/model/valorant_character_model.dart';

import '../utils/bot_toast/bot_toast_functions.dart';
import 'common_state.dart';

class CommonBloc extends Cubit<CommonState> {
  CommonBloc() : super(CommonState(valorantCharacterData: []));
  final _repo = Repo();
  Future<void> getAgents() async {
    try {
      showLoading();
      var response = await _repo.getAgents();
      final valorantTempData = ValorantCharacterModel.fromJson(response);
      emit(state.copyWith(valorantCharacterData: valorantTempData.data));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      closeLoading();
    }
  }
}
