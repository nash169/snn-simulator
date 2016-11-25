% grapher.m
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

classdef grapher < handle
    %GRAPHER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        network
        figVm
    end
    
    methods
        function obj = grapher
            obj.network = figure (100);
            title('Neural Network')
            camlight right
            lighting phong
            axis ([0 20 0 20 0 20])
            hold on
            grid on
        end
        
        function plotVm(obj,rec) 
           obj.figVm = figure (101);
           title('Membrane Potential')
           plot(rec.time,rec.membranePotential);
           grid on
        end
        
        function plotIsyn(obj,rec)
           figure (102)
           title('Synaptic Current')
           plot(rec.time,rec.SynapticCurrent);
           grid on
        end
        
        function plotSpikes(obj,rec)
           figure (103)
           title('Synaptic Current')
           stem(rec.time,lifrec.timeSpikes);
           grid on
        end
        
        function plotInput(obj,stim)
           figure (104)
           title('Input Current')
           plot(stim.time,stim.input);
           grid on
        end
    end
end