export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CPATH=/usr/local/cudnn8.0-11.0/include:$CPATH
export LD_LIBRARY_PATH=/usr/local/cudnn8.0-11.0/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/usr/local/cudnn8.0-11.0/lib64:$LIBRARY_PATH

learning_rate=0.001
ep=250
random_state=0
path=/Data/counterfactual_fairness_game_theoric/reports/results/adult
lambda_path=/Data/counterfactual_fairness_game_theoric/reports/results/adult/lambda
for random_state in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
  do
    for lambda_weight in 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 200 210 220 230 240 250 1000 2000 3000
      do
        evaluate_path="${lambda_path}/evaluate/epoch-${ep}_lambda-${lambda_weight}_lr-${learning_rate}_random-${random_state}.csv"
        result_path="${lambda_path}/result/epoch-${ep}_lambda-${lambda_weight}_lr-${learning_rate}_random-${random_state}.csv"
        python /counterfactual_fairness_game_theoric/src/adult_train.py --epoch $ep --lambda_weight $lambda_weight --learning_rate $learning_rate
        python /counterfactual_fairness_game_theoric/src/adult_test.py
        python /counterfactual_fairness_game_theoric/src/evaluate_classifier.py --data_name adult
        cp /counterfactual_fairness_game_theoric/reports/results/evaluate_adult.csv $evaluate_path
        cp /counterfactual_fairness_game_theoric/reports/results/adult_ivr.csv $result_path
        rm -rf /counterfactual_fairness_game_theoric/reports/results/adult_ivr.csv
        rm -rf /counterfactual_fairness_game_theoric/reports/results/evaluate_adult.csv
        echo $evaluate_path
        echo $result_path
        clear
      done
  done

