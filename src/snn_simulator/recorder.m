% recorder.m
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

classdef recorder < handle
    %RECORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        timeSpikes
        membranePotential
        inputCurrent
        SynapticCurrent
        frequency = 1000;
        report
        varRec
        classRec
        time
        lh
    end
    
    properties (Dependent)
       DT
    end
    
    properties (SetObservable)
       recNeuron
       recSynapse
    end
    
    methods
        function DT = get.DT(obj)
            DT = 1/obj.frequency;
        end
        
        function obj = recorder(class,var)
            if nargin > 0
                obj.classRec = class;
                obj.varRec = var;
            end
        end

        function play(obj,simTime)
            obj.time = 0 : obj.DT : simTime;
            switch obj.classRec
                case 'neuron'
                    switch obj.varRec
                        case 'Vm'
                            obj.lh = addlistener(obj.recNeuron,'Vm','PostSet',@(src,evnt)obj.recVm(obj,src,evnt));
                        case 'spikes'
                            obj.lh = addlistener(obj.recNeuron,'fired','PostSet',@(src,evnt)obj.recSpikes(obj,src,evnt));
                    end                    
                case 'synapse'
                    obj.lh = addlistener(obj.recSynapse,'output','PostSet',@(src,evnt)obj.recIsyn(obj,src,evnt));
            end
        end
        
        function reset(obj)
            obj.timeSpikes = [];
            obj.membranePotential = [];
            obj.inputCurrent = [];
            obj.SynapticCurrent = [];
        end
    end
    
    methods (Static)
      
      function recVm(obj,src,evnt)
          obj.membranePotential = [obj.membranePotential obj.recNeuron.Vm];
      end
      
      function recSpikes(obj,src,evnt)
         obj.timeSpikes = [obj.timeSpikes obj.recNeuron.fired];
      end
      
      function recIsyn(obj,src,evnt)
         h = evnt.AffectedObject;
         obj.SynapticCurrent = [obj.SynapticCurrent h.output];
      end
      
    end
    
end