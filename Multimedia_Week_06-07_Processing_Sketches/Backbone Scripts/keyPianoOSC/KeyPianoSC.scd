/*Here is a monophonic synth. For its notes it will convert the key values into midi notes and sonify them using an LFSaw oscillator*/

Spec.add(\freq, [100, 1220.0])

s.waitForBoot{

	SynthDef(\playNotes, {|amp=0.6, note|
		var env = EnvGen.kr( Env.perc(0.01, 0.3), doneAction:2);
		var out = Splay.ar(LFSaw.ar({note}!8, Rand(pi, 2pi), amp));
		ReplaceOut.ar(0, out * env);
	}).add;

	OSCdef(\playNotes, {|msg|
		var note, ascii;
		note = msg[1];
		ascii = msg[2];
		Synth(\playNotes, [ \note, note.midicps ]);
	}, '/key/value');
};

//this bit below will loop values to Processing:
fork{ loop{
	1.wait;
	NetAddr("localhost", 12000).sendMsg('/test', 10000.rand.asString);
}};