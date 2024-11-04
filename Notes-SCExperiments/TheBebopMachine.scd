(
// dur refers to the value of the eighth note, 0.2 = 0.4bps which is 150 bpm; 0.1 would be 300 bpm
var dur = 0.2; // try values between 0.4 and 0.1

// linlin maps a linear range to another linear range. arguments are as follows: input, srclo (lower limit of input range), srchi (Upper limit of input range), dstlo (Lower limit of output range), dsthi (Upper limit of output range). This variable is setting up a system that says if the bpm is high, then there will be less swing.
var swing = dur.linlin(0.1, 0.5, 0.005, 0.08);

//current note
var curNote = 48;

// four notes of the min6 chord and four notes of the dim7 = 8 notes that are a minor scale with b6, 6, and raised 7.
var degrees = [0, 2, 3, 5, 7, 8, 9, 11]; // minor6 - dim7

// variable sets up an array with 8 integers, then multiplies each i by 12, adds var degrees, and then flattens it into one array. It turns the scale degrees into a list of note values that span multiple octaves.
var allScaleDegrees = 8.collect{|i|(i * 12) + degrees}.flat;

// calculates the direction of the note based on where the note is. If the current note is under 58, the direction remains the same. If the note is over 73, the direction reverses. Neither of the these conditions are met, the direction is random.
var calcDir = {|val, curNote|
	case
	{ curNote < 58 } { val }
	{ curNote > 73 } { val * -1 }
	{ true } { [val, val.neg].choose}
};

// note direction
var dir = 1;

// declares scale and root variables
var scale, root;

// makes sure that there aren't any other pdefs running before the bepop machine starts
Pdef.removeAll;

Pdef(\basePb,
	Pbind(
		\root, Pstep(Pseq([0, 5, 0, 3, 8, 0], inf), Pseq([28, 16, 20, 8, 8, 16] * dur, inf), inf),
		\assignRoot, Pfunc{|ev|root = ev.root},
		\dur, Pseq([dur + swing, dur - swing], inf),
		\scale, Pfunc{|ev|
			//ev.root adjusts the notes according to the current root note
			var tmpScale = (allScaleDegrees + ev.root);
			//
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