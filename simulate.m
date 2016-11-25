% simulate.m
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

function simulate(pop, stim, rec, simTime)
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : length(stim)
   getInput(stim(i),simTime); 
end

cronos = timer(pop);

for i = 1 : length(rec)
   play(rec(i),simTime); 
end
%% PARRALLEL SIMULATION????

cronos.run(stim);

for i = 1 : length(rec)
   delete(rec(i).lh)
end

end