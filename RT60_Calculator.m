clear all;

% This script was designed to calculate the the point of RT60 for impulse
% responses +- 0.01dB.

% It will create 3 output arrays: 
% 1. The sample that is at point of RT60. (rt60Point)
% 2. The sample value at point of RT60.   (rt60SampVal)
% 3. The dB value of RT60 relative to the dB val of the 1st sample. (rt60)

% File names should be 'number'.extension 
% e.g. 1.wav, 2.wav, 3.wav etc...
% DirectoryToFiles should be the path to impulse responsess relative to this script.
% indexOfFirstSample - should be the first sample in the file 
% (normally the loudest sample).


numberOfFiles = 10; % number of files to process.
directoryToFiles = 'Audio/IRs/High/'; 
fileExtension = '.wav'; 
indexOfFirstSample = 1; 

rt60Point = zeros(1, numberOfFiles);
rt60SampVal = zeros(1, numberOfFiles);
rt60 = zeros(1, numberOfFiles);

for j = 1: numberOfFiles - 1
    fileName = [directoryToFiles, num2str(j), fileExtension];
    [inputAudio, Fs] = audioread(fileName); % reads file into array
    initialGain = log10(abs(inputAudio(indexOfFirstSample))) * 20.0;
    rt60(j) = initialGain - 60;

    for n = 1:size(inputAudio)
        currentGain = log10(abs(inputAudio(n))) * 20.0;
        if currentGain <= rt60(j) && currentGain >= rt60(j) - 0.01
           rt60Point(j) = n;
           rt60SampVal(j) = inputAudio(n);
        end
    end
end