function mfccs= mfccfunc(audio)

%% Read the .wav file
[voice,samplefre]=audioread(audio);

%% VAD
signal = vadsohn(voice, samplefre, 'a');
index = find(signal);
voice = voice(index);

%% Pre-emphasis
voice=filter([1 -0.9375],1,voice);

%% MFCC Feature Extraction
mfccs = melcepst(voice,samplefre,'MEdD',12,32,512,256); 
%signal; sample freq; window used; cepstral coefficients num; Mel filter num; frame len; frame shift 
mfccs = mfccs';
% 39 dimensions

end

