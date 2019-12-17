# Exoplanet-Habitability
Binary classification project for Bay Path University's ADS 635 Data Mining I class. 
The goals were to create a data set for my machine learning methods using the NASA Exoplanet Archive data and to build models that would accurately predict whether an exoplanet was habitable or not. 
As I continue to learn more, I wish to come back to this project and fix any mistakes I'd missed and optimize the code.


It is good for myself to note that because there is a severe class imbalance in the data set (44 habitable planets vs. 451 unhabitable), some of these models may not be predicting correctly due to its sensitivity to the imbalance. The Random Forest model does the best in this project (97.9% accuracy), and this is most likely due to the resampling nature of the algorithm. I just wanted to add all of the models here for the sake of the project and learning.

I also want to note that there some strong correlations between the variables, which may cause redundancy. I chose to retain all of the predictors for this project, but some of these variables can indeed be removed. 


Langauges utilized in this project: R;
Machine Learning algorithms: K-nearest neighbors, Linear Discriminant Analysis, Random Forest, Support Vector Machines. 
Attempted Logistic regression but came across "complete separation" in my data, so I decided not to use the model for this project.


Credits:
• Kepler Objects of Interest,
https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nphtblView?
app=ExoTbls&config=q1_q17_dr24_koi.
• “HEC: Data of Potentially Habitable Worlds.” Planetary
Habitability Laboratory @ UPR Arecibo,
http://phl.upr.edu/projects/habitable-exoplanets-catalog/data.
• Misra, Rajeev. Stanford University, Dec. 2017,
http://cs229.stanford.edu/proj2017/final-reports/5228128.pdf.
• Lawrencelm. “Lawrencelm/Machine-Learning-For-
Exoplanets.” GitHub, 8 June 2015,
https://github.com/lawrencelm/Machine-Learning-For-Exoplanets.
• “ WHAT IS COMPLETE OR QUASI-COMPLETE SEPARATION
IN LOGISTIC.” IDRE Stats, UCLA,
https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faqwhat-iscomplete-
or-quasi-complete-separation-in-logisticprobitregression-
and-how-do-we-deal-with-them/.
• Johnson, Michele. “Kepler and K2 Missions.” NASA, NASA, 31
Mar. 2015,
https://www.nasa.gov/mission_pages/kepler/main/index.html.
• “Data Columns in Kepler Objects of Interest Table.” Data
Columns in Kepler Objects of Interest Table,
https://exoplanetarchive.ipac.caltech.edu/docs/API_kepcandidate
_columns.html.
