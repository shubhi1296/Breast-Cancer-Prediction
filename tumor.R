library(readxl)
tumor <- read_excel("tumor.xlsx")
View(tumor)
str(tumor)
tumor$`Sample code number`=NULL
tumor=tumor[complete.cases(tumor),]
tumor$Class<-factor(ifelse(tumor$Class==2, "benign", "malignant"))
trainingSet<-tumor[1:477, 1:9]
testSet<-tumor[478:683, 1:9]
trainingOutcomes<-tumor[1:477,10]
testOutcomes<-tumor[478:683,10]
install.packages("class")
library(class)
predictions<-knn(train=trainingSet, cl=trainingOutcomes$Class, k=21, 
                 test=testSet)
predictions
table(testOutcomes$Class, predictions)
actual_preds<-data.frame(cbind(actuals=testOutcomes$Class,predicted=predictions))
correlation_accuracy<-cor(actual_preds)
head(actual_preds)

