(
SynthDef("awesome synth",{
	arg freq=150, amp=0.1;
	var snd;
	snd=SinOsc.ar(freq:[freq,freq*5,freq*4,freq*8],mul:[amp,amp,amp,amp/2]);
	snd=Mix.ar(snd);
	snd=Splay.ar(snd);
	Out.ar(0,snd);
}).add;
)

(
x=Synth("awesome synth",[\freq,52.midicps]);
)

(
x.set(\freq,57.midicps);
)

(
x.set(\freq,60.midicps);
)

(
x.set(\freq,64.midicps);
)

x.free;

// Sep.26 notes: inf = infinity, pbind takes negative integers for scale degrees = wider range of pitches