play{VarSaw.ar(Duty.ar(1/4,0,Dxrand([99,130,147,185,220,247,146], inf)),0,0.4,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2,1,-20,50))!2}

(
s = SynthDef.new(\mysynth, {
    Out.ar(0,
        VarSaw.ar(Duty.ar(1/4, 0, Dxrand([99, 130, 147, 185, 220, 247, 146], inf)), 0, 0.4, 0.3) +
        (LFCub.ar(LFSaw.kr(LFPulse.kr(1/4, 1/4, 1/4) * 2, 1, -20, 50))!2))
});
s.add;
)

x = Synth(\mysynth);
x.free;
