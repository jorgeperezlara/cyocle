# RPM Jack Counter

An RPM counter that uses the audio jack as input

## Requirements

To compile this project you will need a machine running Linux, Windows or macOS and the latest flutter framework.

### Dependencies

The only dependency appart from the actual flutter framework is `sound_stream` from casperpas (https://pub.dev/packages/sound_stream).

### Minimum requirements

I have just tested it on a Galaxy A40 and Galaxy S10 (Hong Kong version). No further testing has been performed. I expect it to work pretty well on any other device that supports flutter, as it uses pretty standard packages, as well as on iOS devices, as long as it has a headphone jack. It **should** work also over bluetooth, but you'd need to send the pulses through bluetooth audio, maybe picking a cheap bluetooth broadcaster through Amazon, like this ones:

- [EasyULT Transmisor]: https://www.amazon.es/EasyULT-Transmisor-Bluetooth-Inal%C3%A1mbrico-Auriculares/dp/B088K5WLX4/ref=sr_1_6?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=bluetooth%2Btransmitter&qid=1611649405&sr=8-6&th=1
- [ELEGIANT Transmisor]: https://www.amazon.es/Adaptador-Transmisor-ELEGIANT-Transceptor-Inal%C3%A1mbrico/dp/B074M9N8NM/ref=sr_1_7?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=bluetooth+transmitter&qid=1611649405&sr=8-7

**This is NOT and endorsement for ANY product, nor any recommendation whatsoever. This should IN THEORY work, though.**

Sadly I don't have any iOS device, so unless you can give me one, I won't be able to test it for you.

## How it works

My bike sends the information through an audio jack cable. Each time a revolution is performed, an audio pulse is sent through the headphone jack. We receive the input from the mic using `sound_stream` and count how many peaks are reached per second. The information will be passed to a method that will turn those numbers into revolutions/minute (RPM).

As simple as that.