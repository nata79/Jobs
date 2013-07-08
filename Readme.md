# Job Exercise

## Architecture

There is class named Sorter inside a Job module. This class only has one public method called `execute`. The `execute` method receives a string as input and outputs an orderd list of jobs according to their dependencies.

## Tests

I followed a TDD aproach to solve the problem.

The tests were writen using RSpec.

## Sorting Algorithm

The problem fits in the "Topological Sorting" category. I used a variation of the algorithm proposed by Kahn[1].

The original algorithm receives a graph where the jobs are represented by vertices, and there is an edge from x to y if job x must execute __before__ job y. To better fit the provided input and gain performance I built a graph where there is an edge from x to y if job x must be executed __after__ job y.

I also took advantage from the fact that each job doesn't depend on more than one job.

## Sources

* [[1] Topological Sorting](http://en.wikipedia.org/wiki/Topological_sorting)