import 'dart:async';
import 'dart:math';
import 'package:mic_stream/mic_stream.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class MicrophoneEngine {
  StreamSubscription<List<int>> _listener;
  //FÓRMULA DE CÁLCULO DE DECIBELIOS: db = 20 * log10(2**15 * pcmValue)
  int _laps;
  bool oddOnly;
  double filterValue;
  MicrophoneEngine(this.oddOnly, this.filterValue);

  Future<void> startRecording(void Function(int) function) async {
    _laps = 0;
    Stream<List<int>> stream = await MicStream.microphone(sampleRate: 44100);
    if (oddOnly) {
      bool odd = true;
      _listener = stream.listen((samples) {
        double value = getSoundAmplitude(samples);
        if (odd && value > filterValue) {
          _laps++;
          odd = false;
        } else if (!odd && value > filterValue) {
          odd = true;
        }
        function(_laps);
      });
    } else {
      _listener = stream.listen((samples) {
        double value = getSoundAmplitude(samples);
        if (value > filterValue) {
          _laps++;
        }
        function(_laps);
      });
    }
  }

  Future<void> stopRecording() async {
    _listener.cancel();
  }

  int get rpm {
    return _laps;
  }

  double getSoundAmplitude(List<int> sampleList) {
    /*  FÓRMULA PARA CALCULAR LA ENERGÍA DE UN STREAM DE PCM16 MONO A 44100 Hz: amplitudDeLaOnda = sqrt(sum(valor_0^2 ... valor_44099^2)/44100);
        La sacamos de aquí: https://dsp.stackexchange.com/questions/2951/loudness-of-pcm-stream/2953#2953
        Resulta que la bici no devuelve silencio, si no que cuando no se da la vuelta, el sonido es extremadamente bajo, pero hay. Eso explicaría que haya energía incluso en "silencio", ya que es un falso silencio, PERO... ¿por qué al dar la vuelta el sonido no es significativamente más alto?.*/
    double sumOfSquaredValues = 0;
    for (var value in sampleList) {
      sumOfSquaredValues = sumOfSquaredValues + (value * value);
    }
    double result = sqrt(sumOfSquaredValues / sampleList.length);
    return amplifyDifference(result);
  }

  double amplifyDifference(double value) {
    double lessenValue = value - 127;
    return lessenValue;
  }
}
