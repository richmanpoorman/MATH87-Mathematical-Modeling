function [profit_per_tank] = strategy1(storage_per_day, prob_customer, arrival_day, quiet)
% Runs Strategy 1 of the fish tank problem:
% A new tank arrives on the first day of each week, regardless of sales.
% Input: 
%        storage_per_day = Cost of storing a tank each day.
%                  quiet = Prints extra output if needed
%
% Output: 
%        profit_per_tank = Profit of selling each tank needed to cover 
%                          costs of storing tanks over 2 year period.

% Set parameters

num_weeks = 104;

% Initialize stock to zero
stock = 0;

% Variables to keep track of total sales, etc
total_cust = 0;
total_sold = 0;
total_lost = 0;
total_inventory = 0;

% Print labels for tables
if (quiet == 2)
    fprintf('Week Weekday Stock Customers Sold Lost\n');
end

for week=1:num_weeks,
    % New tank arrives on day 1
    
    for weekday=1:7,
        if weekday == arrival_day
            stock = stock + 1;
        end
        sold = 0;
        lost = 0;
        
        % Do we have a customer today
        random_num = rand(1);
        if random_num < prob_customer(weekday),
            customers = 1;
        else
            customers = 0;
        end
        
        % If we have a customer, process sale
        if customers == 1
            % If we have stock, then sell one
            if stock > 0
                sold = sold+1;
                stock = stock-1;
            else
                % Otherwise, lose customer
                lost = lost+1;
            end
        end
        
        % Track statistics
        total_cust = total_cust + customers;
        total_sold = total_sold + sold;
        total_lost = total_lost + lost;
        total_inventory = total_inventory + stock;
        
        % Display today's info
        if (quiet == 2)
            disp([week weekday stock customers sold lost]);
        end
    end
end

profit_per_tank = (storage_per_day*total_inventory)/total_sold;
 
if (quiet == 1)
    fprintf('Total over simulation:\n');
    fprintf('Customers : %i\n',total_cust);
    fprintf('Tanks Sold: %i\n',total_sold);
    fprintf('Lost Sales: %i\n',total_lost);
    fprintf('Total Inventory: %i\n',total_inventory);
    fprintf('Needed cost per tank: $%f\n',profit_per_tank);
end
