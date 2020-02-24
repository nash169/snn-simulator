% create.m
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

function obj = create(typeObj, numberObj, varargin)

switch typeObj
    case 'neuron'
        if nargin == 3 
            for i = 1 : numberObj
               position = 19*rand(1,3);
               switch varargin{1}
                   case 'Vrest'
                       obj(i) = neuron(i,position);
                   case 'random'
                       Vstart = -0.07 + 0.05*rand(1);
                       obj(i) = neuron(i,position,Vstart);
               end 
            end
        elseif nargin == 4
            posMatrix = varargin{2};
            for i = 1 : numberObj
                switch varargin{1}
                   case 'Vrest'
                       obj(i) = neuron(i,posMatrix(i,:));
                   case 'random'
                       Vstart = -0.07 + 0.05*rand(1);
                       obj(i) = neuron(i,posMatrix(i,:),Vstart);
               end 
            end
        end
    case 'stimulator'
        for i = 1 : numberObj
           if nargin > 2
               opt = varargin{1};
               obj(i) = stimulator(opt{1},opt{2},opt{3});
           elseif nargin == 2
               obj(i) = stimulator(1e-7,'step',[10e-3 60e-3]);
           end
        end
    case 'recorder'
        obj(numberObj) = recorder;
end
end