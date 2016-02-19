Corey Ching
998373195

Milestone 1 Readme

--------------------------------------------------------------------------------

Currently I have displayed a basketball court that is draw upon setup of the page.

Next, I read in the game data for the Golden State Warriors versus the New

Orleans Pelicans from 1.csv, 2.csv, 3.csv for the Warriors and Pelicans,

first play off game of 2014-2015 series.

I am currently animating the x,y spatial position of first 2 players that are 

listed in the 1,2,3 csv files. The player ids map to klay thompson and norris cole.


--------------------------------------------------------------------------------

Techincal Explanation:

1 ) I animate the players position by drawing an elipse on the basketball court

based of the spatial position given from the csv file.

Using the draw function, I redraw the background (basketball court) and

next position of the player. This series of drawings creates the animation.

2 ) Secondly, I have made a slider bar that change which CSV file I am showing 

the player's position on the court. If you move the slider to the left, I show 

the player's position based off 1.csv, i.e. earlier in the game. As you move it 

to the right, I show the position in 2.csv and 3.csv consectively.

--------------------------------------------------------------------------------

Next Steps

My goal is show specific players at a time on the court and animate their position.

The slider can be used to change which game it is. 

I need to find the right ratio between the spatial x and y position relative

to the size of the basketball court so that the spacing looks proportional.

