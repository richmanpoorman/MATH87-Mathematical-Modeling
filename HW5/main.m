
%%% VARIABLES %%%
FIRST_DAY            = 1;
STORAGE_COST_PER_DAY = 1; 
QUIET_FLAG           = 0; 
DAYS                 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
TEST_COUNT           = 1000; 
%%% RUNNING %%% 

function [strat1Avgs, strat2Avgs] = runTests(storage_per_day, customer_probabilities_per_day, start_day, test_count, quiet_flag)
    profit_per_tank1 = zeros([1, test_count]);
    profit_per_tank2 = zeros([1, test_count]);
    strat1Avgs       = zeros([1, test_count]);
    strat2Avgs       = zeros([1, test_count]);

    for testIndex = 1 : test_count 
        profit_per_tank1(testIndex) = strategy1(storage_per_day, customer_probabilities_per_day, start_day, quiet_flag);
        profit_per_tank2(testIndex) = strategy2(storage_per_day, customer_probabilities_per_day, quiet_flag);
        strat1Avgs(testIndex) = sum(profit_per_tank1) / testIndex;
        strat2Avgs(testIndex) = sum(profit_per_tank2) / testIndex;       
    end
end

function printTestResults(storage_per_day, customer_probabilities_per_day, start_day, test_count, quiet_flag)
    [strat1Avgs, strat2Avgs] = runTests(storage_per_day, customer_probabilities_per_day, start_day, test_count, quiet_flag);

    fprintf('> Strategy 1: $%f\n', strat1Avgs(end));
    fprintf('> Strategy 2: $%f\n', strat2Avgs(end));
end


fprintf('---RUN WITH GIVEN PROBABILITIES--- \n');
CUSTOMER_PROBABILITY_PER_DAY = [0.08, 0.04, 0.08, 0.12, 0.25, 0.27, 0.16];

printTestResults(STORAGE_COST_PER_DAY, CUSTOMER_PROBABILITY_PER_DAY, FIRST_DAY, TEST_COUNT, QUIET_FLAG);

fprintf('\n');

fprintf('---TESTING STRATEGY 1 ARRIVAL DAYS--- \n');
for day = 1 : 7 
    
    % Choose the day to have the highest likely hood
    [strat1Avgs, ~] = runTests(STORAGE_COST_PER_DAY, CUSTOMER_PROBABILITY_PER_DAY, day, TEST_COUNT, QUIET_FLAG);
    fprintf('> Arrive on %s: $%f\n', DAYS(day), strat1Avgs(end));

    fprintf('\n');
end

fprintf('\n');

fprintf('---WEIGHTING ON A SINGLE DAY--- \n');

for step = 0 : 10
    %% Make the probabilities go towards 1 (approaching limit)
    probability = 1 - 2^(-step); 
    probability_per_day = ones([1, 7]) * ((1 - probability) / 6);
    probability_per_day(1) = probability; 

    fprintf('> Probability %f: \n', probability);
    printTestResults(STORAGE_COST_PER_DAY, probability_per_day, FIRST_DAY, TEST_COUNT, QUIET_FLAG);

    fprintf('\n');
end

%% Probability at exactly 1
probability_per_day = [1, 0, 0, 0, 0, 0, 0];
fprintf('> Probability %f: \n', 1);
printTestResults(STORAGE_COST_PER_DAY, probability_per_day, FIRST_DAY, TEST_COUNT, QUIET_FLAG);
