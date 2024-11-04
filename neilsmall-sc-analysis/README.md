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