[FileName, FilePath]=uigetfile('*');
inputVideo = VideoReader(strcat(FilePath, FileName));
numFrames = ceil(inputVideo.FrameRate*inputVideo.Duration);
inputVideoLength = inputVideo.Duration;
disp(strcat('This video contains ',num2str(numFrames), ' frames'));
%Get Background
inputVideo.currentTime = 0;
backgroundFrame = readFrame(inputVideo);
backgroundFrame1=imresize(backgroundFrame,0.2);
disp('The input Video is');
disp(strcat(num2str(inputVideoLength),'seconds'));

disp('Press ');
%result = input('(1) for Video or\n(2) for a Frame of the input video.\n');
numberOfFeatures = input('How many features would you like to detect per frame? (number)\n');


if(result == 1)
    outputVideo = VideoWriter(strcat(FilePath(1:end-7), 'output/',...
    'roto',FileName(1:end-4)));
    open(outputVideo);
    startTime = input('What time would you like to begin the rotoscoping? (seconds)\n');
    inputVideo.CurrentTime = startTime;
    numberOfFrames = input('How many frames of the video would you like to process? (number)\n');
    
    for time = 1:numberOfFrames
        disp(time);
        inputFrame = readFrame(inputVideo);
        inputFrame1=imresize(inputFrame,0.2);
        outputImage = rotoscope(numberOfFeatures, backgroundFrame1, inputFrame1);
        writeVideo(outputVideo, outputImage);
    end
    close(outputVideo);
end

if (result == 2)
    time = input('At what time is the frame that you would like to process? (seconds)\n');
    inputVideo.CurrentTime = time;
    inputFrame = readFrame(inputVideo);
    outputImage = rotoscope(numberOfFeatures, backgroundFrame, inputFrame);
    imshow(outputImage)
    imwrite(outputImage, strcat(FilePath(1:end-7), 'output/',...
        'roto', FileName(1:end-4),'.png'), 'PNG');
end