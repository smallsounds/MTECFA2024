# Neil's Awesome SuperCollider Tweet

I took a look at the template that was in the 140 character assignment. I was overwhelmed by the amount of text that filled my screen, but I copied the first example into SuperCollider and the colors/formatting made it easier to read. 

I learned what iphase meant. Yay! I played around with the initial phase for a bit to understand what the difference sounds like. I only knew what it was conceptually.

I don't understand the math in this section:
    
    {LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))}.play

What does the 1/4 represent and how does the multiplication and addition at the end make it pulse eighth notes? Also, how did we end up with LFCub going to LFSaw and LFpulse? I understand the LFPulse and LFSaw relationship, but how does the LFCub interpret all of the stuff in its parentheses? I also know what it's doing aurally, I just don't get it on the code level. 

The combination of the white noise and the pulse make sense!

The next example I looked at was the baby noise one. I thought that was funny. I listened to the other examples to see which ones I liked the most. I liked the headcube 2 example.

I understood most of the code up until this last section:

    // Finally, let's go back and see how exactly the big array of arrays is generated inside Dseq:


    a=[[4,4.5],[2,3,5,6]];
    flat(a *.x allTuples(a *.x a) * 4).clump(2)++0;

    // "flat" simply flattens an array (removes internal brackets):

    [1, 2, [3, 4, 5], 6, 7].flat

    // "clump" regroups elements of an array:

    [1, 2, 3, 4, 5, 6, 7].clump(2)

    // "++" concatenates something to the end of an array:

    [1, 2, 3, 4, 5, 6, 7] ++ 0;

    // "allTuples" returns a new Array whose elements contain all possible combinations of the receiver's subcollections.

    [[1, 2, 3, 4, 5], [10, 20, 30]].allTuples;
    [[1, 2, 3, 4, 5], [10, 20, 30], [5, 6]].allTuples;

    // The trickiest thing here is probably the *.x operator. This is called an operator with an adverb.
    // The operator is the regular multiplication sign; the adverb is the letter 'x' preceded by a dot '.'
    // The adverb slightly modifies the behavior of the normal operator.
    // Here's a normal multiplication of two arrays:

    [1, 2, 3, 4, 5] * [10, 11, 12] // evaluate and see the result

    // A new array is created which is the length of the longer array;
    // Items from each array are multiplied one by one in sequence, wrapping
    // around the shorter array until all items from longer array have been multiplied.

    // Now this is what happens when we use the adverb .x to modify
    // the behavior of the array multiplication:

    [1, 2, 3, 4, 5] *.x [10, 11, 12] // evaluate and see the result

    // Result: all items of first array are multiplied by first item
    // of second array; then all items of first array are multiplied
    // by second item of second array; and so on. All products are
    // then collected in a single flat list.
    // [a,b,c] *.x [d,e,f] = [ad,bd,cd,ae,be,ce,af,bf,cf]

    // For more info on adverbs, look up "Adverbs for Binary Operators" in the documentation.

    a=[[4,4.5],[2,3,5,6]];
    flat(a *.x allTuples(a *.x a) * 4)

    // Breaking down the code above:

    a *.x a; // that is, [ [4,4.5], [2,3,5,6] ] *.x  [ [4,4.5], [2,3,5,6] ]

    allTuples(a *.x a); // all combinations of previous result

    a *.x allTuples(a *.x a); // 'a' * previous result

    a *.x allTuples(a *.x a) * 4; // previous result * 4

    flat(a *.x allTuples(a *.x a) * 4); // flatten previous result

    flat(a *.x allTuples(a *.x a) * 4).clump(2); // regroup in pairs

    flat(a *.x allTuples(a *.x a) * 4).clump(2)++0; // add a zero to the very end (otherwise last note pair would keep repeating)

Busy Tuesday unfortunately, so I couldn't go to office hours. I'm going to take this information at face value and ask questions later. 

Next, I tried combining the left side of micromoog example with the right side of the headcube 2 example. It looked like this

    play{VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50)}

It very much did not work. SuperCollider said that there was a syntax error at the end of the line, but I feel like there was more wrong than that. When I clicked on the end of the line, I saw that only the--wait. I just realized my mistake. I forgot the extra parentheses that needs to be at the end of the line.

    play{VarSaw.ar(Duty.ar(1/5,0,Dseq([256, 144, 128, 72, 162, 450], 4)),0,0.9,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))}

IT WORKS NOW! I then played around with the speed of the left side of the Tweet and made the whole thing stereo.
   
    play{VarSaw.ar(Duty.ar(1/4,0,Dseq([256, 144, 128, 72, 162, 450], 100)),0,0.9,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))!2}

Now, I want to change the values in the Dseq argument. While I was doing this, I got rid of the +2 in the LFPulse equation to see what would happen. I liked it, so I kept it. The initial held note is like an intro and the two pulses that follow are great for a nice kick. I saw on [this page](http://docs.supercollider.online/Classes/Dseq.html) that there was a Drand option, so I replaced Dseq with Drand. I then saw there was a Dxrand option on the [Drand page](http://docs.supercollider.online/Classes/Drand.html), so I replace Drand for Dxrand. I tried putting in the ".." in the Dxrand argument, but SuperCollider told me there was a syntax error. I'm guessing that demand rate functions need explicit values? I settled on a few values and here's what it looks like now:

    play{VarSaw.ar(Duty.ar(1/4,0,Dxrand([130, 185, 440], inf)),0,0.9,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2,1,-20,50))!2}

I want to change the sound of the left side of the Tweet. I went to [this page](http://doc.sccode.org/Guides/Tour_of_UGens.html) to figure out which UGen worked for this project. I tested out the SinOsc and other related UGens and all of them were distorted. It was an experience for sure. I think I will stick with VarSaw for now. I changed the values in the Dxrand argument and adjusted the amplitude to create a darker feeling to the Tweet.

    play{VarSaw.ar(Duty.ar(1/4,0,Dxrand([130, 185, 220], inf)),0,0.4,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2,1,-20,50))!2}

This is only 127 characters. NOOO! Okay, we will add more frequencies to the Dxrand argument. 

    play{VarSaw.ar(Duty.ar(1/4,0,Dxrand([99,130,147,185,220,247,146], inf)),0,0.4,0.3)+LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2,1,-20,50))!2}

I got rid of the spaces in between the numbers in the argument to fit an extra value in there. This brings my total character count to 140! Huzzah!