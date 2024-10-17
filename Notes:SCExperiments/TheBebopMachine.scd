(
var dur = 0.2; // try values between 0.4 and 0.1
var swing = dur.linlin(0.1, 0.5, 0.005, 0.08);
var curNote = 48;
var degrees = [0, 2, 3, 5, 7, 8, 9, 11]; // minor6 - dim7
var allScaleDegrees = 8.collect{|i|(i * 12) + degrees}.flat;
var calcDir = {|val, curNote|
	case
	{ curNote < 58 } { val }
	{ curNote > 73 } { val * -1 }
	{ true } { [val, val.neg].choose}
};
var dir = 1;
var scale, root;
Pdef.removeAll;

Pdef(\basePb,
	Pbind(
		\root, Pstep(Pseq([0, 5, 0, 3, 8, 0], inf), Pseq([28, 16, 20, 8, 8, 16] * dur, inf), inf),
		\assignRoot, Pfunc{|ev|root = ev.root},
		\dur, Pseq([dur + swing, dur - swing], inf),
		\scale, Pfunc{|ev|
			var tmpScale = (allScaleDegrees + ev.root);
			var temp = tmpScale[tmpScale.indexInBetween(48).asInteger..tmpScale.indexInBetween(83).asInteger];
			scale = temp;
		},
		\dir, Pstep(
			Pseq([
				Pseq([
					Pfuncn({|ev|dir = calcDir.(2, curNote)}),
					Pfuncn({|ev|dir = calcDir.(1, curNote)}),
				], 14),
				Pseq([
					Pfuncn({|ev|dir = calcDir.(2, curNote)}),
				], 12),
				Pseq([
					Pfuncn({|ev|dir = calcDir.(2, curNote)}),
					Pfuncn({|ev|dir = calcDir.(1, curNote)}),
				], 4)
			]),
			Pseq([
				Pseq([3, 1], 14),
				Pseq([3, 1], 12),
				Pseq([3, 1], 4)
		]) * dur, inf)
)).play;

Pdef(\line,
	Pbind(
		\dur, Pseq([dur + swing, dur - swing], inf),
		\midinote, Pseries(16, Pfunc { dir }, inf)
		.collect { |i|
			curNote = scale.wrapAt(i);
			curNote;
		},
		\amp, Pseq([0.4, 0.2, 0.3, 0.2], inf) * 0.5,
)).play;

Pdef(\chords,
	Pbind(
		\dur, Pseq([dur * 3 + swing, dur * 5 - swing], inf),
		\midinote, Pfunc{
			var index = scale.indexIn(curNote);
			[0, 2, 4, 6].collect{|j|scale.wrapAt(index + j)}.wrap(50, 73)
		},
		\sustain, Prand([
			Pseq([dur, dur * 2.5], inf),
			Pseq([dur, dur * 2.5], inf)
		]),
		\amp, Prand([0, 0.05], inf),
)).play;

Pdef(\bass,
	Pbind(
		\legato, 0.2,
		\dur, dur * 2,
		\amp, 0.2,
		\midinote, Prand([
			Pseq([0, 2, 4, 6]),
			Pseq([0, 1, 2, 3]),
			Pseq([0, 4, 8, 4]),
			Pseq([4, 2, 1, 0]),
		], inf).collect{|i|scale[i + scale.indexIn(root + 48)] - 12},
		\t, Pseq([\note, Prand([\note, \rest])], inf)
	)
).play
);

Pdef.removeAll;