
function price_per_month = pay_per_month(pay_by_month, left_guess, right_guess)
    denominator = log(1.015); 
    function k = pay_per_month_root(p)
        numerator = log(p - 500) - log(p - 530); 
        k = (numerator / denominator) - pay_by_month;
    end
    % disp(pay_by_month);
    % disp(left_guess)
    % disp(pay_per_month_root(left_guess));
    % disp(right_guess)
    % disp(pay_per_month_root(right_guess));
    price_per_month = bisection(@pay_per_month_root, left_guess, right_guess);
end


fprintf('6 Month Price p: %f\n', pay_per_month(6, 750, 1000));
fprintf('12 Month Price p: %f\n', pay_per_month(12, 531, 750));