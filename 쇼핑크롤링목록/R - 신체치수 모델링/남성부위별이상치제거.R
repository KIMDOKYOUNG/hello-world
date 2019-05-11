#어깨
str(data)

man_model<-subset(data,sex=="남")
man_model$label<-1:nrow(man_model)


#어깨 안고쳐도됨

#chest
sort(unique(man_model$chest))

#가슴 안고쳐도됨

#belly 배 - 배도 할필요 없음
sort(unique(man_model$belly))

#neck-할필요없음
sort(unique(man_model$neck))


#팔길이 arm - 할필요없음
sort(unique(man_model$arm))

#겨드랑이둘레 armhole
sort(unique(man_model$armhole))


#겨드랑이 안고쳐도됨


#상체총길이 - 안고쳐도됨
sort(unique(man_model$top_length))



#손목둘레
sort(unique(man_model$wrist))



#팔둘레 - 할필요없음
sort(unique(man_model$arm_round))

#허리둘레 - 할필요없음
sort(unique(man_model$waist))


#엉덩이둘레
sort(unique(man_model$hip))


#넙다리둘레 - 할필요없음
sort(unique(man_model$thigh))


#엉덩뼈높이
sort(unique(man_model$bottom_leng))

#발목둘레 - 할필요없ㅇ
sort(unique(man_model$ankle))




