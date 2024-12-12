//start with white noise
(
SynthDef("WhiteNoise", { arg out=0, amp=0.025;
    Out.ar(out,
        WhiteNoise.ar(0.025)
    )
}).play;
)




//random notes to launch

//percussive pops with pitch
//play each for 5 sec, stop, 10 sec, stop etc
{RLPF.ar(Dust.ar([12, 15]), LFNoise1.ar([0.3, 0.2]).range(100, 3000), 0.02)}.play;

{RLPF.ar(Dust.ar([6, 22]), LFNoise1.ar([0.3, 0.2]).range(20, 3600), 0.02)}.play;

{RLPF.ar(Dust.ar([6, 22]), LFNoise1.ar([0.3, 0.2]).range(20, 2800), 0.02)}.play;



//random notes (atonal beware)
(
 Pbind(
 \degree, Pseq([0, −1, 2, −3, 4, −3, 7, 11, 4, 2, 0, −3], 5),
 \dur, Pseq([0.2, 0.1, 0.1], inf),
 \amp, Pseq([0.7, 0.5, 0.3, 0.2], inf),
 \legato, 0.4
 ).play;
 )

//tonal chords (Eb major c minor)
(
Pbind(
 \note, Pseq([[−7, 3, 7, 10], [0, 3, 5, 8]], 2),
 \dur, 1,
 \legato, 0.4,
 \strum, 0.1 // try 0, 0.1, 0.2, etc
 ).play;
)

//sin random
{SinOsc.ar(LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;


