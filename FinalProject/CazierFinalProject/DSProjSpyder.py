import xlrd
from sklearn.neighbors import KNeighborsClassifier
import sklearn
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, recall_score, precision_score, f1_score
from sklearn.linear_model import LinearRegression

loc = "C:\\Users\\wonde\\OneDrive\\Documents\\PythonReadyDSProjCop.xls" 

wb = xlrd.open_workbook(loc)
sheet = wb.sheet_by_index(0)



#def vars as list
listOfObs = [];
listForRow = [];

#nested loop imports data in 2D array
for i in range(987):
    
    for j in range(7):
        listForRow.insert(j, sheet.cell_value(i+1, j))
        
    listOfObs.append([listForRow[0], listForRow[1], listForRow[2], listForRow[3], listForRow[4], listForRow[5], listForRow[6]])
    
        
#classifier object, using 3 neighbors
classifier = KNeighborsClassifier(n_neighbors = 3)

#all data is in listOfObs, take every fourth for training data in datKept
datKept = [];
needDel = [];
for x in range(245):
    datKept.append(listOfObs[x*4])
    needDel.append(x*4)
#deleting data in training set moved to testing set
for x in range(len(needDel)):  
    del listOfObs[needDel[len(needDel)-1-x]]

#y labels need to be in seperate list for both training and testing sets,
#new array for both    
tLabels = [];
for x in range(len(listOfObs)):
    tLabels.append(listOfObs[x][0])
    del listOfObs[x][0]
    
kLabels = [];
for x in range(len(datKept)):
    kLabels.append(datKept[x][0])
    del datKept[x][0] 
    
    
    
#fit data for K Nearest Neighbors   
classifier.fit(listOfObs, tLabels)
#use testing data to generate predictions
guesses = classifier.predict(datKept)

#print measures of predicition accuracy
print("K Neighbors Scores:")
print(accuracy_score(kLabels, guesses))


print(sklearn.metrics.recall_score(kLabels, guesses, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))
print(sklearn.metrics.precision_score(kLabels, guesses, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))
print(sklearn.metrics.f1_score(kLabels, guesses, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))
#print(guesses)
#print(kLabels)
#done with K nearest neighbors


#Naive Bayes model, new object
NBModel = MultinomialNB()

#calling fit method on object, passing training data and labels
NBModel.fit(listOfObs, tLabels)
#calling predict method with testing data, storing in predictions array
predictions = NBModel.predict(datKept)

#printing measures of accuracy
print("Naive Bayes Scores:")

print(accuracy_score(kLabels, predictions))

print(sklearn.metrics.recall_score(kLabels, predictions, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))
print(sklearn.metrics.precision_score(kLabels, predictions, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))

#print(predictions)

print(sklearn.metrics.f1_score(kLabels, predictions, labels=None, pos_label=1, average= None, sample_weight=None, zero_division='warn'))
print(predictions)

#regressor object and fit
regressor = LinearRegression()  
regressor.fit(listOfObs, tLabels)
#print(regressor.coef_)
