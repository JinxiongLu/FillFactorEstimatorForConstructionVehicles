%This script corresponds to the hardware setup with 3 GPU.
%the first GPU is only for screen output, whereas the other 
%two GPUs are exclusively for training.
parpool('local', 2);
spmd
    gpuDevice(labindex+1);
end