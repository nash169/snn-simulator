% createNetwork.m
%
% This file is part of MatSNN.
% Copyright (C) 2015 Bernardo Fichera
%
% MatSNN is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% MatSNN is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with MatSNN.  If not, see <http://www.gnu.org/licenses/>.

function link = createNetwork(neurons, density)
%NETWORK Summary of this function goes here
%   Detailed explanation goes here
link = [];
for i = 1 : length(neurons)
    for j = 1 : length(neurons)
        if rand(1) > density
            link = [link synapse(neurons(i),neurons(j),0.04*rand(1))];
        end
    end
end
end