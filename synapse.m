% synapse.m
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

classdef synapse < handle
    %SYNAPSE Summary of this class goes here
    %   Detailed explanation goes here
    
    %% Synaptic Properties
    properties
        type
        weight
        tauRise   = 1e-3;
        tauDecay  = 1e-3;
        frequency = 1000;
        delay     = 0;
        q = 1e-3;
    end
    
    properties (Dependent)
        Esyn
        DT
    end
    
    %% Synaptic Connection
    properties
        preNeuron
        postNeuron
    end 
    
    %% Internal State Variables
    properties (SetObservable, Access = public)
       output = 0;
       h = 0;
       g = 0;
    end
    
    methods
        %% Synapses Constructor
        function obj = synapse(preNeuron,postNeuron,weight,type)
            
            %Set synapse connection
            if nargin == 4
                obj.preNeuron = preNeuron;
                obj.postNeuron = postNeuron;
                obj.weight = weight;
                obj.type = type;
            else
                obj.preNeuron = preNeuron;
                obj.postNeuron = postNeuron;
                obj.weight = weight;
                obj.type = 'exc';
            end
            
            %Set pre neuron connection and listen his firing
            size1 = length(postNeuron.postLink);
            preNeuron.postLink{size1 + 1} = obj;
            %Set post neuron connection
            size2 = length(postNeuron.preLink);
            postNeuron.preLink{size2 + 1} = obj;
            % Draw the object
            obj.place
            
            addlistener(obj.preNeuron,'fired','PostSet',@(src,evnt)getIsyn(obj,src,evnt));
        end
        
        %% Getter Function for Dependent Properties
        function Esyn = get.Esyn(obj)
            switch obj.type
                case 'exc'
                    Esyn = -1e-3;
                case 'inh'
                    Esyn = -70e-3;
            end
        end
        
        function DT = get.DT(obj)
            DT = 1/obj.frequency;
        end
        
        %% Plotter Synapse
        function place(obj)
            figure (100)
            line([obj.preNeuron.position(1) obj.postNeuron.position(1)],...
                 [obj.preNeuron.position(2) obj.postNeuron.position(2)],...
                 [obj.preNeuron.position(3) obj.postNeuron.position(3)],...
                 'LineWidth',0.5,...
                 'Color',[1,0,0])
                 %'Marker','.','LineStyle','-')
        end
    end 
    
    methods
        %% Dynamic Synapse
        function getIsyn(obj,src,evnt)
            GO = obj.preNeuron.fired;
            obj.h = obj.h + (-obj.h/obj.tauRise + GO/obj.DT)*obj.DT;
            obj.g = obj.g + (-obj.g/obj.tauDecay + obj.h)*obj.DT;
            obj.output = -obj.g*obj.weight*obj.q*(obj.postNeuron.Vm - obj.Esyn);
        end
    end
end