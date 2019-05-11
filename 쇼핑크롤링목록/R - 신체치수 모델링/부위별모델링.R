#
wrist <-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","wrist")]
arm_round <-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","arm_round")]
bottom_leng <-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","bottom_leng")]
ankle <-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","ankle")]
top_length<-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","top_length")]
arm<-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","arm")]


#
wrist <-wrist[wrist$wrist > mean(wrist$wrist) - 2*sd(wrist$wrist) &
                wrist$wrist < mean(wrist$wrist) + 2*sd(wrist$wrist),]
arm_round <-arm_round[arm_round$arm_round > mean(arm_round$arm_round) - 2*sd(arm_round$arm_round) &
                        arm_round$arm_round < mean(arm_round$arm_round) + 2*sd(arm_round$arm_round),]
bottom_leng <-bottom_leng[bottom_leng$bottom_leng > mean(bottom_leng$bottom_leng) - 2*sd(bottom_leng$bottom_leng) &
                            bottom_leng$bottom_leng < mean(bottom_leng$bottom_leng) + 2*sd(bottom_leng$bottom_leng),]
ankle <-ankle[ankle$ankle > mean(ankle$ankle) - 2*sd(ankle$ankle) &
                ankle$ankle < mean(ankle$ankle) + 2*sd(ankle$ankle),]
top_length<-top_length[top_length$top_length > mean(top_length$top_length) - 2*sd(top_length$top_length) &
                         top_length$top_length < mean(top_length$top_length) + 2*sd(top_length$top_length),]
arm<-arm[arm$arm > mean(arm$arm) - 2*sd(arm$arm) &
                         arm$arm < mean(arm$arm) + 2*sd(arm$arm),]


#
idx_wrist <-createDataPartition(wrist$wrist, p=.8, list = F)
train_wrist <-wrist[idx_wrist,]
test_wrist <-wrist[-idx_wrist,]

idx_arm_round <-createDataPartition(arm_round$arm_round, p=.8, list = F)
train_arm_round <-arm_round[idx_arm_round,]
test_arm_round <-arm_round[-idx_arm_round,]

idx_bottom_leng <-createDataPartition(bottom_leng$bottom_leng, p=.8, list = F)
train_bottom_leng <-bottom_leng[idx_bottom_leng,]
test_bottom_leng <-bottom_leng[-idx_bottom_leng,]

idx_ankle <-createDataPartition(ankle$ankle, p=.8, list = F)
train_ankle <-ankle[idx_ankle,]
test_ankle <-ankle[-idx_ankle,]

idx_top_length<-createDataPartition(top_length$top_length,p=0.8,list=F)
train_top_length<-top_length[idx_top_length,]
test_top_length<-top_length[-idx_top_length,]

idx_arm<-createDataPartition(arm$arm,p=0.8,list=F)
train_arm<-arm[idx_arm,]
test_arm<-arm[-idx_arm,]


#
control = trainControl(method='cv', search='grid', number=5, verbose = TRUE)

control = trainControl(method='repeatedcv', search='random', number=5,repeats = 5,verbose = TRUE)

#모델링
##wrist
#xgGrid <- expand.grid(eta=0.05, colsample_bytree=0.5, max_depth=c(2:10),
                      #nrounds=c(100:500), gamma=1, min_child_weight=1, subsample =1)
xgb.model_wrist <- train(
  wrist~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_wrist,trControl = control,method = 'xgbTree')
wrist.xgb = predict(xgb.model_wrist,test_wrist)
R2(wrist.xgb,test_wrist$wrist)  #0.7097816

##arm_round
#xgGrid <- expand.grid(eta=0.05, colsample_bytree=0.5, max_depth=c(2:10),
                      #nrounds=c(100:500), gamma=1, min_child_weight=1, subsample =1)
xgb.model_arm_round <- train(
  arm_round~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_arm_round,trControl = control,method = 'xgbTree')
arm_round.xgb = predict(xgb.model_arm_round,test_arm_round)
R2(arm_round.xgb,test_arm_round$arm_round)

##bottom
#xgGrid <- expand.grid(eta=0.05, colsample_bytree=0.5, max_depth=c(2:10),
                      #nrounds=c(100:500), gamma=1, min_child_weight=1, subsample =1)
xgb.model_bottom_leng <- train(
  bottom_leng~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_bottom_leng,trControl = control,method = 'xgbTree')
bottom_leng.xgb = predict(xgb.model_bottom_leng,test_bottom_leng)
R2(bottom_leng.xgb,test_bottom_leng$bottom_leng)  #0.8638056

#최적모델은 nrounds = 499, max_depth = 2, eta = 0.05,colsample_bytree = 0.5

#top_leng
train_top_length$bottom_leng<-predict(xgb.model_bottom_leng,train_top_length)
str(train_top_length)

test_top_length$bottom_leng<-predict(xgb.model_bottom_leng,test_top_length)
str(train_top_length)

train_top_length$arm<-predict(xgb.model_arm,train_top_length)

test_top_length$arm<-predict(xgb.model_arm,test_top_length)
str(train_top_length)


xgb.model_top_leng <- train(
  top_length~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh+bottom_leng+arm,
  data=train_top_length,trControl = control,method = 'xgbTree')

top_leng.xgb = predict(xgb.model_top_leng,test_top_length)
R2(top_leng.xgb,test_top_length$top_length)



##ankle
#xgGrid <- expand.grid(eta=0.05, colsample_bytree=0.5, max_depth=c(2:10),
                      #nrounds=c(100:500), gamma=1, min_child_weight=1, subsample =1)
xgb.model_ankle <- train(
  ankle~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_ankle,trControl = control,method = 'xgbTree')
ankle.xgb = predict(xgb.model_ankle,test_ankle)
R2(ankle.xgb,test_ankle$ankle)  #0.7097816
#최적모델은 nrounds = 357, max_depth = 3



####
##neck
# test하기 위한 데이터분할
library(caret)
neck <-data[,c("sex","age","height","weight","shoulder","chest","belly","waist","hip","thigh","neck")]

neck <-neck[neck$neck > mean(neck$neck) - 2*sd(neck$neck) &
              neck$neck < mean(neck$neck) + 2*sd(neck$neck),]

idx_neck <-createDataPartition(neck$neck, p=.8, list = F)
train_neck <-neck[idx_neck,]
test_neck <-neck[-idx_neck,]

#
control = trainControl(method='repeatedcv', search='random', number=5,repeats = 2,verbose = TRUE)

xgGrid <- expand.grid(eta=0.05, colsample_bytree=0.5, max_depth=c(2:10),
                      nrounds=c(100:500), gamma=1, min_child_weight=1, subsample =1)
xgb.model_neck <- train(
  neck~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_neck,tuneGrid = xgGrid,trControl = control,method = 'xgbTree')

neck.xgb = predict(xgb.model_neck,test_neck)
R2(neck.xgb,test_neck$neck)

neck.xgb2 = predict(xgb.model_neck,size)
neck.xgb2

#######
#arm
xgb.model_arm <- train(
  arm~sex+age+height+weight+shoulder+chest+belly+waist+hip+thigh,
  data=train_arm,trControl = control,method = 'xgbTree')

arm.xgb = predict(xgb.model_arm,test_arm)
R2(arm.xgb,test_arm$arm)


######################################
######################################
######################################
#실측
size<-read.csv("size2.csv")
str(size)














