% neuron.m
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

classdef neuron < handle
    %NEURON This class implements the leaky-integrate-fire model
    %   Detailed explanation goes here
    
    %% User defined parameters --> Use the constructor to set thi parameters!
    properties (Access = public)
        position         % In the future this parameter will be handled by the mesh generator
        ID
        ciao
    end
    
    %% Neuron's parametrs
    properties (Constant)
        Trefract  =     1e-3 %[s]
        Cm        =     3e-8 % 
        Rm        =      1e6 %
        Vresting  =    -0.06 % Resting Potential
        frequency =     1000 % [Hz] Neuron's dynamic velocity
    end
    
    properties (Dependent)
        taum    % Time Costant fo RC Circuit
        Vthresh % Threshold to cross for firing
        Vreset  % Reset Value after Firing
        DT      % Dynamic Resolution
    end
    
    properties (SetObservable)
        %% InternalState Variables
        nStepsInRefr = -1; % Number of steps in refractory
        neuroPlot          % Handle for Plot of NEURON
        Vm                 % Membrane Potential
        fired = 0;
        Iapp = 0;
        %% Connections
        preLink
        postLink
        flag = timer.empty
    end
    
    methods  
        %% Constructor
        function obj = neuron(id,pos,Vstart)
            if nargin > 0
                obj.ID = id;
                obj.position = pos;
                place(obj);
                
                if nargin == 2
                    obj.Vm = obj.Vresting;
                elseif nargin == 3
                    obj.Vm = Vstart;
                end
            end
        end     

        
        %% Tau_m getter function
        function taum = get.taum(obj)
            taum = obj.Rm*obj.Cm;
        end
        
        %% Threshold getter function
        function Vthresh = get.Vthresh(obj)
            Vthresh = obj.Vresting + 0.015;
        end
        
        %% Resting Potential getter function
        function Vreset = get.Vreset(obj)
            Vreset = obj.Vresting;
        end
        
        %% Dynamic getter function
        function DT = get.DT(obj)
            DT = 1/obj.frequency;
        end
        
        %% Reset Neuron
        function reset(obj)
            obj.Vm = obj.Vresting;
        end
        
        %% Place Neuron in 3D Space
        
        function place(obj)
            n        = 100;
            theta    = (-n:2:n)/n*pi;
            phi      = (-n:2:n)'/n*pi/2;
            cosphi   = cos(phi); cosphi(1) = 0; cosphi(n+1) = 0;
            sintheta = sin(theta); sintheta(1) = 0; sintheta(n+1) = 0;

            x = obj.position(1) + 0.5*cosphi*cos(theta);
            y = obj.position(2) + .5*cosphi*sintheta;
            z = obj.position(3) + .5*sin(phi)*ones(1,n+1);
            
            figure(100)
            obj.neuroPlot = surf(x,y,z,'FaceColor','blue','EdgeColor','none');
        end
        
        
    end
    
    methods
       %% Get Voltage Membrane
        function getVm(obj,Iapp)
            if obj.nStepsInRefr > 0
                obj.Vm = obj.Vresting;
                obj.nStepsInRefr = obj.nStepsInRefr - 1;
                obj.fired = 0;
            else
                dVm = (obj.Vresting - obj.Vm + obj.Rm*Iapp)/obj.taum;
                nextState = obj.Vm + dVm*obj.DT;
                if obj.Vm >= obj.Vthresh
                    obj.reset
                    obj.nStepsInRefr = ceil(obj.Trefract/obj.DT);
                    obj.fired = 1;
                else
                    obj.Vm = nextState;
                    obj.fired = 0;
                end
            end
            obj.Iapp = 0;
        end
        
        function updateCurrent(obj,src,evnt)
            for i = 1:length(obj.preLink)
                obj.Iapp = obj.Iapp + obj.preLink{i}.output;
            end
            getVm(obj,obj.Iapp);
%             ciao = 1;
        end
    end  
end