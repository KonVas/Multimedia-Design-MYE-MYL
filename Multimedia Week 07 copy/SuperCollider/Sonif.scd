//Testing input from Processing:
OSCdef(\procTest, {|msg|
	msg.postln
}, "/test/osc");


//Receiving an integer whenever ball hits on the sides:
(
OSCdef(\procPos, {|msg|

	if(msg[1] == 0) {
		Synth(\ball, [\freq, 80, \amp, 0.05]);
		"Ball hit Up or Down".postln
	};

	if(msg[1] == 1) {
		Synth(\ball, [\freq, 120, \amp, 0.05]);
		"Ball hit left of right".postln
	};

	//Forward some OSC to Proc when the ball riches a side:
	~proc.sendMsg('/sc', 255.rand);

}, "/ball/pos");
)

//create a remote location to send messages from SC:
~proc = NetAddr("127.0.0.1", 8080); //Proc's port is 8080.

~proc.sendMsg('/sc/osc');

(
SynthDef(\ball, {|out = 0, freq = 120.0, amp = 0.5|
	var signal, env;
	env = EnvGen.kr(Env.perc(0.02, 0.5), doneAction:Done.freeSelf);
	signal = Impulse.ar(freq, mul: amp);
	signal = {signal}!2;
	signal = signal * env;
	signal = Ringz.ar(signal, freq, 0.15);
	ReplaceOut.ar(out, signal)
}).add
)