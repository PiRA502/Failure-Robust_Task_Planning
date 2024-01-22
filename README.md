# Failure-Robust_Task_Planning

This repository implements a MILP-based algorithm to solve a new type of failure-aware multi-robot task planning problem, which takes the unexpected robot failures into account, in order to enhance the robustness of the multi-robot system. 

## Code
The Matlab implementations of both initially-robust algorithm and globally-robust algorithm are provided, using [Gurobi](https://www.gurobi.com/) as the MILP-solver.

The code is modified from [cLTL-synth](https://github.com/sahiny/cLTL-synth). 

## Video
Two videos are provided to show the simulation and hardware experiments.

* The example of delivery robots working in a library workspace. The simulation is performed in the [V-REP](https://www.coppeliarobotics.com/) robot simulator.


https://github.com/PiRA502/Failure-Robust_Task_Planning/assets/43596587/0d8d09db-f4d9-4534-8ffe-54eb54f4556c


* The example of [Turtlebot3-Burger](https://emanual.robotis.com/docs/en/platform/turtlebot3/features/) mobile robots in the laboratory.


https://github.com/PiRA502/Failure-Robust_Task_Planning/assets/43596587/4e0b4e46-c48f-44ef-9729-5d92204452c0

