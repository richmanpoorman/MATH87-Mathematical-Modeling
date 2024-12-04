
%%%
%%% QUESTION 1
%%%

dataset_1 = load('M87HW7a.mat');
dataset_2 = load('M87HW7b.mat');



%%% 
%%% QUESTION 2 
%%%

dataset_3 = load('M87HW7c.mat'); 


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