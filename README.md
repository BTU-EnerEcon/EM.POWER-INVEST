# EM.POWER-INVEST
An Open Optimisation Model of the European Electricity Market


About
=====

EM.POWER-INVEST is a model for long term capacity expansion planning.

The EM.POWER-INVEST model was developed for the BMBF-funded project "Stimulating endogenous development potential for structural change - decarbonisation of a lignite region" (DecarbLau) https://www.b-tu.de/decarblau/ 
The chair of Energy Economics within BTU was responsible for the quantification of future employment development in the Lusatian lignite industry.


![image](https://user-images.githubusercontent.com/72204893/145413110-3d26ecc8-cef1-4f7d-8869-9cf47c7d3e1e.png)


Functionality
=============

EM.POWER INVEST can compute the cost minimal investment and dispatch in conventional generation capacity, which follows future exogenous potentials for renewable utilities and storage systems. It incorporates techniques for reducing regional and temporal resolution in favour of increasing technical properties; while facilitating the cost effective evolution of the European power system.

Model output examples 
===========
Conventional generation capacity in Germany 
![image](https://user-images.githubusercontent.com/72204893/162191335-3dc2dbe1-2d56-4b78-9c7c-bd93051007d8.png)


Development of coal capacity in Germany when coal phase-out restriction is applied 
![image](https://user-images.githubusercontent.com/72204893/162197208-c1aeb5e8-8caf-4768-82e7-655ffeccec63.png)


How to run EM.POWER-INVEST?
===============================

For the operation of EM.POWER INVEST, it is essential to have a GAMS license which offers full access to the CPLEX solver. The model solving is achieved by executing three files: the initial file named “Firstrun” must be computed to have all the required sets and parameters defined; the computation is followed by running the GAMS script “Representative_hours”, which includes the time reduction approach for the first model stage explained in our Working Paper; the file called “main_3stage_h4380” includes the core model solving for our three step model approach and displays the output in bihourly resolution subsequent to its full computation. Results can also be obtained in hourly resolution, if “main_3stage_h8760” is executed.


Licence
=======

Authors: Daniel Scholz, Smaranda Sgarciu, Felix Müsgens
