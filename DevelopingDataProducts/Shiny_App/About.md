## MLB Team History from 1973 to 2014
**Author:** Douglas Wirtz

**Date:** June 10, 2016

***

#### Background
This course project is for the data science specialization offered by Johns Hopkins University on Coursera. The Goal of this project is to build a web application using the Shiny package in R-studio. 

The application must include the following:

1. Some form of input (widget: textbox, radio button, checkbox, ...)
2. Some operation on the ui input in sever.R
3. Some reactive output displayed as a result of server calculations
4. You must also include enough documentation so that a novice user could use your application.
5. The documentation should be at the Shiny website itself. Do not post to an external link.

***

#### Data
The data used for this application was found on [statcrunch.com](http://www.statcrunch.com).
The dataset, [MLB Team Histories (1973-2014)](http://www.statcrunch.com/5.0/index.php?dataid=1819295) was modified to remove redundancies and fix inaccuracies in some stats. 

***

#### How To Use The Application
This application was built with the intention to explore the MLB dataset. The sidepanel contains a slider that allows the user to adjust the time frame in which to explore the data. In addition, the user can select or deselect teams from the list of checkboxes to narrow the exploration to their liking. The "Legend" tab on the sidepanel is a list of the variables and their extended names. The mainpanel, first and foremost, contains a data table that will adjust to the user's parameters. The user can use the arrows at the top of the data table to ascend or descend particular stats. The "Charts" tab on the main panel will allow the user to visualize the data in a simple scatter plot. Use the drop-down menus for each axis to choose which variables to compare. The user also has the option to adjust the size of the chart by clicking and dragging the bottom right corner of the plot.

