# UGthesis

This repo contains code as presented in van der Hoop et al. 2012 Ecological Applications 

AIS_CRW_wrapper is a wrapper to run the scripts in order. 

The first step is to import and manage the AIS data using ImportAIS. It pulls in data over the period specified in the quicklog.list, then organizes the AIS data in various matrices, and calculates the straight-line distance that the ship must travel over a given period of time, etc.

The second step is to load some simulated whales. These whales would be simulated with the CRW code. The file loadWhales loads some data, and concatenates the individual files into a two-week record of the whales's positions over the same time period of interest.

The file HIT combines the whale and vessel data using the functions ship_positions_jv and whalepositions. 

