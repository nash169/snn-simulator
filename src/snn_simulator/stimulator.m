% stimulator.m
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

classdef stimulator < handle
    %STIMULATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        maxAmp % [units=A; range=(-1,1);]
        type
        frequency = 1000;
        int
        time
        input
    end
    
    properties
        conNeur = neuron.empty
    end
    
    properties (Dependent)
        DT
    end
    
    properties (SetObservable)
       output = 0;
    end
    
    methods
        function obj = stimulator(amp,type,interval)
            obj.maxAmp = amp;
            obj.type = type;
            obj.int = interval;
        end
        
        function DT = get.DT(obj)
            DT = 1/obj.frequency;
        end
        
        function getInput(obj,simTime)
            if simTime < obj.int(2)
                error('Ehi! Non fare cazzate...')
                return
            end
            
            t = 0:obj.DT:simTime;
            switch obj.type
                case 'step'
                    obj.input = zeros(length(t),1);
                    obj.input(t>=obj.int(1) & t<=obj.int(2)) = obj.maxAmp;
                    
                case 'sin'
                    f = .2; %[Hz]
                    phi = 0;
                    shift = 0;
                    A = .5;
                    obj.input = zeros(length(t),1);
                    obj.input(t>=obj.int(1) & t<=obj.int(2)) = A*sin(2*pi*f*(0:obj.DT:obj.int(2)-obj.int(1)) + phi) + shift;
            end
            obj.time = t;
        end
        
        function play(obj,iter)
            obj.output = obj.input(iter);
%             obj.output = 1e-7;
        end
    end
    
end