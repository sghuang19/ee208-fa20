# Engineering Electromagnetic Field Experiment 1 Report

This is the report fo the first experiment of Engineering Electromagnetic Field course, written by HUANG Guanchao, SID 11912309 from SME. The complete resources of this experiment, including `.m` source code, report in `.md`, `.pdf` format and all the figures can be retrieved at [my GitHub repo](https://github.com/SamuelHuang2019/EEF-lab/tree/main/experiment_1).

[toc]

---

## General Idea

The general idea of my coding, is to capsulate the workflow of plotting several figures into corresponding customized functions, taking charges, with their amount and location as parameters, to achieve high code reuse rate, and to reduce duplicated lines as many as possible.

In all, five functions are implemented, one for calculating the potential distribution, and the other four are for generating the figures required in this experiment.

---

## Function `potential()`

This method is intended for calculating the electric potential distribution due to one or more point charges. It requires 3 parameters:

### Parameters

This function is invoked as `potential(charges, xm, ym)`.

- `charges`
This parameter is for the charge distribution, it is a matrix with 3 rows and three columns, each row vector of which specifies a point charge. In rows of `charges`, the first element is the charge amount, the second is the $x$-coordinate, and the third is the $y$-coordinate.

- `xm`
This parameter represents the maximum absolute value of the $x$-coordinates on which the potential is calculated. In another word, the range we are concerned along the $x$-axis is $[-x_m, x_m]$.

- `ym`
Similar to `xm`, but along the $y$-axis.

### Returns

This function returns a **cell** of three matrices, noted as `V`.

1. the first indicates the potential at each points in the range.
2. the second indicates the $x$-coordinate of the meshgrid.
3. the third indicates the $y$-coordinate of the meshgrid.

>Since MATLAB doesn't support a matrix composed of matrices, hence a `cell` type is required.

### Detailed Explanation

Inside the function, firstly, the $x$-coordinates in the range are evenly divided to 50 segments with command `x = linspace(-xm, xm, 50);`, stored in a row vector. Then the same for the $y$-coordinates. Based on this, the meshgrid is generated as `[X, Y] = meshgrid(x, y);`

>The meshgrid is set to have size of 50 by 50, in order to achieve the relatively best appearance for all 4 figures needed to be accomplished in this experiment.

Afterward, the distance between each of the point charges to, and hence the potential due to each of them at any points in the meshgrid are calculated iteratively within `for` loop, then summed to form the return.

>Due to the same limitation mentioned above, calculation inside functions is also based on the `cell` type.

### Source Code

The complete source code of this function is shown in the following code block.

```matlab
%% potential
function V = potential(charges, xm, ym)
    % potential - to calculate the electric potential distribution
    %
    % input -
    %   charges - a matrix with 3 rows,
    %            column 1 indicates point charge amount;
    %            column 2 indicates x-coordinate;
    %            column 3 indicates y-coordinate
    %   xm - the range of the field in x direction
    %   ym - the range of the field in y direction
    %
    % output -
    %   V - a cell of three matrices,
    %      the first indicates the potential at each points in the range
    %      the second indicates the x-coordinate of the meshgrid
    %      the third indicates the y-coordinate of the meshgrid

    % evenly divide the x axis into 50 segments
    x = linspace(-xm, xm, 50);
    % evenly divide the y axis 50 segments
    y = linspace(-ym, ym, 50);

    % to form the coordinates of each point in the field.
    [X, Y] = meshgrid(x, y);

    % calculate the distance between each point and the source charge (the origin).
    R = {};

    for index = 1:size(charges, 1)
        R{index} = ...
            sqrt((X - charges(index, 2)).^2 + ...
            (Y - charges(index, 3)).^2);
    end

    % calculate the electric potential of each point
    % V = k * Q ./ R;
    global k
    V_q = {};

    for index = 1:size(charges, 1)
        V_q{index} = ...
            k * charges(index, 1) ./ R{index};
    end

    V_total = sum(cat(3, V_q{:}), 3);
    V = {V_total, X, Y};

end
```

---

## Function `plot_potential()`

This function is invoked as `plot_potential(V)`, takes in a potential distribution `V`, which is a result of `potential()`, then generates a figure using `mesh()`.

>Since there's a line of `figure` command, each time this function runs, a new figure window is generated.

The complete source code of this function is shown in the following code block.

```matlab
%% plot_potential
function plot_potential(V)
    % potential - to plot the electric potential distribution
    % input arguments -
    %   V - a cell of three elements,
    %      the first indicates the x-coordinate of the meshgrid
    %      the second indicates the y-coordinate of the meshgrid
    %      the third indicates the potential at each points in the range

    figure
    mesh(V{2}, V{3}, V{1})

    % The title for the plot(Note that all symbols should be half-angled English characters )
    title("The plot of electric potential distribution of point charge(s) in the vacuum");
    % label the x axis
    xlabel('X axis (unit: m)', 'fontname', 'Times New Roman');
    % label the y axis
    ylabel('Y axis (unit: m)', 'fontname', 'Times New Roman');
end
```
