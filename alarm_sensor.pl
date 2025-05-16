%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baysian Network for sensor alarm with earthquake
%
% Coder: Edjard Mota
% Date   : 15/05/2025
% Source:  Prolog Programming for AI, Ivan Bratko, 4th edition
%          Chapter 15 - KR and Expert Systems
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------
parent(burglary, sensor).
parent(lightning, sensor).
parent(earthquake, sensor).  % Terremoto afeta o sensor
parent(sensor, alarm).
parent(sensor, call).

p(burglary, 0.001).
p(lightning, 0.02).
p(earthquake, 0.002).  % Probabilidade a priori de um terremoto

% Probabilidades condicionais para o sensor (com terremoto)
p(sensor, [burglary, lightning, earthquake], 0.95).
p(sensor, [burglary, lightning, not earthquake], 0.9).
p(sensor, [burglary, not lightning, earthquake], 0.92).
p(sensor, [burglary, not lightning, not earthquake], 0.9).
p(sensor, [not burglary, lightning, earthquake], 0.2).
p(sensor, [not burglary, lightning, not earthquake], 0.1).
p(sensor, [not burglary, not lightning, earthquake], 0.05).
p(sensor, [not burglary, not lightning, not earthquake], 0.001).

p(alarm, [sensor], 0.95).
p(alarm, [not sensor], 0.001).
p(call, [sensor], 0.9).
p(call, [not sensor], 0.0).