//First create an OSC responder to start receiving the messages:

Spec.add(\ascii, [1, 2.0]);

(
OSCdef(\x, {| msg |
	~convertAscii.value( msg[1] ); //turn it to letter again with next function below.
	~synth.set( \ascii.asSpec.map( msg[1] / 127 ) ); //.map() expects input values between 0.0 - 1.0
}, '/test/osc')
)

(
~convertAscii = {| msg |
	msg = msg.asAscii;//requires a valid Ascii range as input.
	msg.postln;
};
)

~synth = {| freq = 0.1 | Splay.ar(LFSaw.ar({ExpRand(100, 1220.0) / freq}!8, Rand(0.1, 2.0) * pi)) }.play;
~synth.free;