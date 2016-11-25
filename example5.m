% example5.m
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
pop = create('neuron', 50, 'random');
link = createNetwork(pop, 0.8);

stim = create('stimulator',5,{1e-7, 'step', [10e-3 60e-3]});

rec = create('recorder',50);
connect(rec,pop,'Vm');

inputNeur = [];

while length(inputNeur) < 5
   winner = randi(length(pop),1,1);
   inputNeur = [inputNeur pop(winner)];
end

connect(stim,inputNeur);
simulate(pop,stim,rec,500e-3)