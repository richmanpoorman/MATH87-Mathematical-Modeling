function [x_new,k] = bisection(f,xL,xR)
% Computes iterates of the bisection method for solving f(x) = 0
% returns iterate where |f(x_k)| < 1e-10 or k=100
% Input: 
%        f  = function handle for function
%        xL = Initial guess Left of the root
%        xR = Initial guess Right of the root
% Output: 
%        x_new  = Approximation of root
%        k      = Total number of Iterations needed

% Maximum number of Bisection Steps to perform
maxsteps = 100; 
% Stopping tolerance check: if |f(x)| < tol, we are close enough
tol = 1e-10;  

% Initialize values
k = 1;
fL = f(xL);
fR = f(xR);

% Basic error-checking
if (fL*fR > 0)
  error('Endpoints give same sign.  You must pick new endpoints!');
end

% Find new point
x_new = (xL+xR)/2;
f_new = f(x_new);

while ((k < maxsteps) && abs(f_new) > tol)

  % Update endpoints
  if(f_new == 0)
    break
  else if (fL*f_new > 0)
      xL = x_new;
      fL = f_new;
  else
    xR = x_new;
    fR = f_new;
  end
  k = k+1;
    
  % Compute updated point
  x_new = (xL+xR)/2;
  f_new = f(x_new);
end

end