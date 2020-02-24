% connect.m
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

function connect(obj1,obj2,var)
%CONNECTSTIM Conection Neuron - Stimulator
%   This function concets the stimulator to a neuron.
%   INPUT --> 1. neuron: the neuron you want to stimulate
%             2. stimualtor: the stimulator you want to use during the
%                            simualtion

switch class(obj1)
    case 'recorder'
        if length(obj2) > length(obj1)
            error('Ehi! Che cazzo fai? Numero di canali insufficiente')
            return
        elseif length(obj2) < length(obj1)
            warning('Non stai utilizzando tutti i canali a dispozione')
        end
        
        for i = 1 : length(obj2)
            switch class(obj2(i))
                case 'neuron'
                    obj1(i).recNeuron = obj2(i);
                    obj1(i).classRec = class(obj2(i));
                    obj1(i).varRec = var;
                case 'synapse'
                    obj1(i).recSynapse = obj2(i);
                    obj1(i).classRec = class(obj2(i));
            end
        end
    case 'stimulator'
        if length(obj2) > length(obj1)
            error('Ehi! Che cazzo fai? Numero di stimolatori insufficiente')
            return
        elseif length(obj2) < length(obj1)
            warning('Non stai utilizzando tutti gli stimolatori')
        end
        
        for i = 1 : length(obj2)
            size = length(obj2(i).preLink);
            obj2(i).preLink{size + 1} = obj1(i);
            obj2(i).neuroPlot.FaceColor = [1 0 0];
        end
end