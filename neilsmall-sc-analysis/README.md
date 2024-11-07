# Analyzing The Bepop Machine by Thor Madsen
### Day 1
I copied and pasted [The Bepop Machine](https://scsynth.org/t/the-bebop-machine/7066) into SuperCollider and saved it so that I can pull it up any time I want. Madsen does a good job explaining the purpose of the project, but a TLDR is it plays the C minor blues using alternating minor 6 chords and diminished 7 chords. The dim7 chords act as dominant 7 b9 chords. 

    || Cm | Cm | Cm | Cm (C7)|
    | Fm | Fm | Cm | Cm |
    | Ab7 | G7 | Cm | (G7) ||

All the minor chords turn into m6 and the second half of their measures turn into the V7(b9) of the following measure's chord (save Ab7 and G7). Ab7 uses Ebm6's notes and G7 uses Abm6's notes. 

Because I planned to analyze line by line, I decided to make notes within the code itself so that I could keep track of what was going on without having to open VS Code. 

I analyzed the first 15 lines of code:

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

The duration was defined by Thor as the value of the eighth note. 0.2 is is 0.4 bps or 150 bpm. 0.1 is 300 bpm. For the next line, I looked up [linin](https://doc.sccode.org/Classes/LinLin.html). I found that it retains the relative positions of the values as they are converted to a new range. This yields a stronger swing feel at slowed tempos and a weaker swing feel at fast tempos. curNote was pretty self explanatory. The degrees variable represents the 8 scale degrees from minor 6 and dim 7 chords. The allScaleDegrees variable sets up an array with 8 integers, then multiplies each i by 12, then adds the degrees variable, and then [flattens](http://doc.sccode.org/Classes/SequenceableCollection.html) it into one array. In plain terms, it turns the scale degrees into a list of note values that span multiple octaves. calcDir (calculate direction) variable calculates the direction of the sequenced note based on where the note is. If the current note is under 58, the direction remains the same. If the note is over 73, the direction reverses. Neither of the these conditions are met, the direction is random. The rest are pretty self explanatory.

### Day 2
I analyzed basePb next. I didn't add comments in the SuperCollider file for this.

Pdef defines a pattern that's named basePb and then [Pbind](https://doc.sccode.org/Classes/Pbind.html) takes the following information and turns it into one event stream. \root contains a Pstep whose arguments determine the root note, the duration of each note, and the number of repeats (infinite). In this case, the root notes are as follows: 0, 5, 0, 3, 8, 0 and loops infinitely. The following Pseq gives the values 28, 16, 20, 8, 8, 16 and once one is chosen, it is multiplied by the variable dur. This leads to rhythm variation. This is also an infinite loop. \assignRoot updates \root using the current event's root note. 

\dur creates the swing feel by alternating between "dur + swing" + "dur - swing." 

\scale calculates the scale based on the root note (ev.root). By adding allScaleDegrees and ev.root, the variable tmpScale creates an array of notes that could be played. The variable temp is limiting this array to values in between 48 and 83 and assigns it to the \scale variable. 

\dir's Pstep arguments are as follows:

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
			])

and

			Pseq([
				Pseq([3, 1], 14),
				Pseq([3, 1], 12),
				Pseq([3, 1], 4)
		]) * dur

and

    inf

The first argument contains a series of functions that will set the direction based on the calDir function. It alternates between values 2 and 1 over different lengths which creates variations in how note direction changes. The second argument contains a sequence that that multiplies by dur. These values make it so that the timing of the direction changes align with the overall rhythm. The last argument says that this pattern will repeat infinitely. 

## Day 3

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

\dur is the same in \line as it is in \basePb. \midinote is a sequence that starts at 16 and then the step size changes based on the direction variable. .collect collects the notes sequenced and scale.[wrapAt(i)](https://doc.sccode.org/Classes/ArrayedCollection.html) makes sure the sequence stays within the scale. \amp uses a sequence to vary the amplitude as \line plays.

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

In \chords, \dur is longer than the previous two Pdefs. This makes \chords sustain for a longer period of time. \midinote finds the current index of curNote in the scale and then adds 0, 2, 4, 6 semitones which form the chord tones. Wrap limits the chord tones to be between 50 and 73. \sustain is randomly chosen between two sequences, varying the harmonic rhythm. \amp is chosen randomly from either 0 or 0.05 which means some chords will be silent and some can be heard. 

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

\legato's value makes it so that there's little separation between each note. \dur is twice the duration to make the bass feel heavier (more like a real bass). The amplitude remains consistent throughout the piece at 0.2. \midinote has four sequences to choose from randomly which will determine the bassline's intervals. The .collect{|i|scale[i + scale.indexIn(root + 48)] - 12} is keeping the bassline within the scale and also transposing it down an octave. \t sets up a sequence to play either a note or a rest.

    Pdef.removeAll;

Removes all the bepop machine Pdefs