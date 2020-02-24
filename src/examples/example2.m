% example2.m
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
lif = create('neuron',2,'Vrest');

link = synapse(lif(1),lif(2),0.1);

stim = create('stimulator',1,{1e-7, 'step', [10e-3 60e-3]});
rec = create('recorder',2);
connect(rec,lif,'Vm');
connect(stim,lif(1));

simulate(lif,stim,rec,100e-3);