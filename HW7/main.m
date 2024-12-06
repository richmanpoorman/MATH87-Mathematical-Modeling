
%%%
%%% QUESTION 1
%%%



dataset_1 = load('M87HW7a.mat');
dataset_2 = load('M87HW7b.mat');

function coefficients = fitConicSection(points) 
    data_size = size(points, 1); 

    equations = []; 
    result = -1 * ones([data_size, 1]);

    for index = 1 : data_size 
        x = points(index, 1);
        y = points(index, 2);
        equation_row = [x * x, x * y, y * y, x, y];
        equations = [equations ; equation_row];
    end
    equations_t = equations.'; 
    coefficients = (equations_t * equations) \ (equations_t * result); 
end

function graph_contour(coefficients, points, x_range, y_range, figure_index)
    a = coefficients(1); 
    b = coefficients(2); 
    c = coefficients(3); 
    d = coefficients(4); 
    e = coefficients(5); 

    fprintf('a: %f \nb: %f \nc: %f \nd: %f \ne: %f \n', a, b, c, d, e);
    fig = figure(figure_index);
    [X,Y] = meshgrid(x_range, y_range);
    f = ones(size(X));
    Z = a*X.^2 + b*X.*Y + c*Y.^2 + d*X + e*Y + f;
    
    
    points_x = points(:, 1); 
    points_y = points(:, 2);
    % disp(points_x);
    plot(points_x, points_y, '.r');

    hold on;
    contour(X,Y,Z,[0 0]);
    hold off; 
end

fprintf('QUESTION 1 \n'); 

fprintf('- DATASET 1 \n');

dataset_1_x_range =  1 : 0.1 : 7; 
dataset_1_y_range = -5 : 0.1 : 8; 
dataset_1_points = [dataset_1.x, dataset_1.y]; 

dataset_1_coefficients = fitConicSection(dataset_1_points);
graph_contour(dataset_1_coefficients, dataset_1_points, dataset_1_x_range, dataset_1_y_range, 1);

fprintf('- DATASET 2 \n');
dataset_2_x_range =  -4 : 0.1 : 2; 
dataset_2_y_range = -1 : 0.1 : 5; 
dataset_2_points = [dataset_2.x, dataset_2.y]; 

dataset_2_coefficients = fitConicSection(dataset_2_points);
graph_contour(dataset_2_coefficients, dataset_2_points, dataset_2_x_range, dataset_2_y_range, 2);


%%% 
%%% QUESTION 2 
%%%
fprintf('\n');
dataset_3 = load('M87HW7c.mat'); 

fprintf('QUESTION 2: \n');

function spring_constants = solveForSpringConstants(elongation_matrix, displacement_samples, force_samples) 
    B = elongation_matrix; 
    x = displacement_samples; 
    f = force_samples; 
    p = size(displacement_samples, 1); 
    

    L = []; 
    B_t = B.'; % B transpose
    for index = 1 : p 
        L = [L ; B_t * diag(B * x(:, index))]; 
    end

    F = []; 
    for index = 1 : p 
        F = [F ; f(:, index)]; 
    end

    L_t = L.'; % L transpose 

    k = (L_t * L) \ (L_t * F); 
    spring_constants = k; 

end

root2Divide2 = 0.5 * sqrt(2); 
elongation_matrix = [
    0, root2Divide2,  0, -root2Divide2 ; 
    0, root2Divide2,  1,  root2Divide2 ; 
    1, 0           ,  0,  0            ; 
    0, 0           , -1,  0            ;
]; 

displacement_samples = [dataset_3.x1, dataset_3.x2, dataset_3.x3, dataset_3.x4]; 
force_samples        = [dataset_3.f1, dataset_3.f2, dataset_3.f3, dataset_3.f4]; 

spring_constants = solveForSpringConstants(elongation_matrix, displacement_samples, force_samples); 
fprintf('k1: %f \nk2: %f \nk3: %f \nk4: %f\n', spring_constants);