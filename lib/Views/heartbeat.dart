// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';

// class CustomAudioHandler extends BaseAudioHandler {
//   final _player = AudioPlayer();

//   CustomAudioHandler() {
//     _player.playerStateStream.listen((state) {
//       final processingState = _getProcessingState(state.processingState);
//       final playing = state.playing;
//       playbackState.add(playbackState.value.copyWith(
//         controls: [
//           MediaControl.skipToPrevious,
//           if (playing) MediaControl.pause else MediaControl.play,
//           MediaControl.stop,
//           MediaControl.skipToNext,
//         ],
//         systemActions: const {
//           MediaAction.seek,
//           MediaAction.seekForward,
//           MediaAction.seekBackward,
//         },
//         androidCompactActionIndices: const [0, 1, 3],
//         processingState: processingState,
//         playing: playing,
//         updatePosition: _player.position,
//         bufferedPosition: _player.bufferedPosition,
//         speed: _player.speed,
//       ));
//     });
//   }

//   @override
//   Future<void> play() async {
//     _player.play();
//   }

//   @override
//   Future<void> pause() async {
//     _player.pause();
//   }

//   // Add other overrides for next, previous, etc.
// }
// AudioProcessingState _getProcessingState(ProcessingState state) {
//   switch (state) {
//     case ProcessingState.idle:
//       return AudioProcessingState.idle;
//     case ProcessingState.loading:
//       return AudioProcessingState.loading;
//     case ProcessingState.buffering:
//       return AudioProcessingState.buffering;
//     case ProcessingState.ready:
//       return AudioProcessingState.ready;
//     case ProcessingState.completed:
//       return AudioProcessingState.completed;
//     default:
//       return AudioProcessingState.idle;
//   }
// }
