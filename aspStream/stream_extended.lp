% extended encoding
#const extended=1.

% assign every request R at window time WT to at most one job J
{ assign((R,WT),J) : J=1..jobs } <= 1 :- window(request(R,_,_),WT), extended=1.

% maximize the jobs assigned, giving higher priority to the oldest requests
#maximize{ 1@-WT,R : assign((R,WT),_) }.

% if occupied(M,T) appears in the newest position of the stream (0),
% then M cannot be occupied at T
:- window(occupied(M,T),0), occupies(_,M,_,T).

% if submitted(R,WT) appears in the newest position of the stream (0),
% then request R at WT cannot be assigned
:- window(submitted(R,WT),0), assign((R,WT),_).

% new window atomss definition
watom(  occupied(M,T)) :- M=1..machines, T=1..horizon.
watom(submitted(R,WT)) :- R=1..requests, WT=1-wsize..-1.

