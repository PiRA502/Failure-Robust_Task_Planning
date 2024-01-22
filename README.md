# Failure-Robust_Task_Planning

This repository implements a MILP-based algorithm to solve a new type of failure-aware multi-robot task planning problem, which takes the unexpected robot failures into account, in order to enhance the robustness of the multi-robot system. 

## Code
The Matlab implementations of both initially-robust algorithm and globally-robust algorithm are provided, using Gurobi(https://www.gurobi.com/) as the MILP-solver.
The code is modified from cLTL-synth(https://github.com/sahiny/cLTL-synth). 

## Video
Two videos are provided to show the simulation and hardware experiments.

* The example of delivery robots working in a library workspace. The simulation is performed in the V-REP robot simulator.
https://www.youtube.com/watch?v=TsQS0MRFgw4
* The example of Turtlebot3-Burger mobile robots in the laboratory.
https://github.com/PiRA502/Failure-Robust_Task_Planning/blob/main/turtlebot.mp4
