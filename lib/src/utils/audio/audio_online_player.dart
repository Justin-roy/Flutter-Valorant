import 'package:just_audio/just_audio.dart';

class AudioOnlinePlayer {
  static Future<void> playOnliveAudio(String audioUri) async {
    final player = AudioPlayer();
    await player.setUrl(audioUri);
    await player.play();
    await player.stop();
  }
}
