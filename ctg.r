#read file
data<- read.csv("F:/imarticus projects/dataset/data/datasets/CTG.csv")
View(data)
#install.packages("party")
library(party)
#install.packages("rpart")
library(rpart)
data$NSP<- factor(data$NSP)
###spliting  data
sam_data<- sample(2,nrow(data), replace = TRUE, prob = c(.9, .1))
train<- data[sam_data==1, ]
test<- data[Sam_data==2, ]
#model 
ctree1<- ctree(NSP ~ LB+AC+FM,data = train)
plot(ctree1)
ctree2<- ctree(NSP ~ LB+AC+FM,data = train,controls = ctree_control(mincriterion = .90,minsplit = 450))
plot(ctree2)
Pred_val<- predict(ctree2, test)
Pred_val
pred_actual_DF<- data.frame(Pred_val, test$NSP)
pred_actual_DF
predict_table<- table(Pred_val,test$NSP) ##confuction matrix
predict_table
acc<-sum(diag(predict_table))/sum(predict_table)*100
acc
