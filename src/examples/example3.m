% example3.m
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

clear
close all

giotto = grapher;
posMat = [2,12,12; 10,3,17; 10,10,5; 4,3,5];
lif = create('neuron',4, 'Vrest', posMat);

link(1) = synapse(lif(1),lif(3),5);           % Create Synapse 1->2 
link(2) = synapse(lif(1),lif(4),5);           % Create Synapse 1->4 
link(3) = synapse(lif(3),lif(2),3);           % Create Synapse 3->2 
link(4) = synapse(lif(4),lif(2),3);           % Create Synapse 4->2
stim = create('stimulator',1,{1e-7, 'step', [10e-3 60e-3]});
rec = create('recorder',4);
connect(rec,lif,'Vm');
connect(stim,lif(1));

simulate(lif, stim,rec,100e-3)