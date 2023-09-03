Author: Zachary Hui


The purpose of this project is to compute the VaR(Value at Risk), the most amount of money potentially lost on a stock portfolio at a specific confidence level. The project uses historical stock price data to simulate return scenarios using Yahoo Finance’s API. 

My approach to this project is to come up with an efficient design process. As such, I have decided to use Python as the programming language, mySql as my database, and GitHub as source code control system. 

During the implementation process, I created two classes, SqlFunc for any database related code and AnalyticFunc for any computational code. By doing this, I have used dataframe objects from python’s pandas library to do any necessary data analysis/wrangling on historical finance data. In addition to this, I also leveraged ChatGBT to create samples to code for me to modify for my needs. I believe that ChatGBT, if used properly, is a great productivity tool.
