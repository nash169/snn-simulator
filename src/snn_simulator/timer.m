% timer.m
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

classdef timer < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetObservable)
        startflag
    end
    
    methods
        function obj = timer(pop)
            for i = 1 : length(pop)
               pop(i).flag = obj;
               addlistener(pop(i).flag,'startflag','PostSet',@(src,evnt)updateCurrent(pop(i),src,evnt));
            end
        end
        
        function run(obj,stim)
            for i = 1 : length(stim(1).time)
                for j = 1 : length(stim)
                    play(stim(j),i);
                end
               obj.startflag = stim(1).time(i);
            end     
        end
    end
    
end

