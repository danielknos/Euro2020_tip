# Euro 2021 tip

A shinyapp to tip the scores in the Euro 2020 (2021). The users guess the scores in each of the 36 group matches. Based on the predcited scores the correct 8th finals are produced. The users need to predict the scores in all knockout games, but the actual scores are irrelevant, its all about finding a winner (home team wins if draw).
To monitor the scores I have built another app (https://github.com/danielknos/Euro2020_answers) where the actual score is followed up, and the points can be changed there, based on a experience from previous tournaments I have developed the following scoring which in my own personal opinion usually puts the overall best guesser on top
Group stage
    - Correct sign (winner or draw) - 2 points
    - Correct goal difference (3 points, thus 1 additional on top of the 2 from the correct sign)
    - Correct result - 5 points
Knockout stage
    - 4 points per correct team in 8th final
    - 6 points per correct team in quarter final
    - 8 points per correct team in semi final
    - 10 points per correct teem in final
    - 15 points per for corret winner
- 15 points for correct top scorer
- Number of yellow cards as a tiebreaker of there is a draw between participants

Once done, all the predicted scores are summarised in a csv file. I've enabled it to be uploaded to a dropbox, but that requires a token so to set this up you need to provide your own token. It's all using the rdrop2 package. Antoher option is for the users to download there scores as a csv and email to the organizer.

To quickly run and have a look please run the following r code
library(shiny)
runGitHub('danielknos/Euro2020_tip')