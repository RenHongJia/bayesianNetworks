% Script loading the 'bnt' library to the workspace


% add the library to query the SQLite db
addpath(genpath('lib/mksqlite'));
% add the libraries of the Bayesian Network Toolbox
cd lib/bnt
addpath(genpathKPM(pwd));
cd BNT
addpath(genpathKPM(pwd));
cd ../../..