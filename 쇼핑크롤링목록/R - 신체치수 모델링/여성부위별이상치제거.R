#여자
woman_model<-subset(data,sex=="여")
woman_model$label<-1:nrow(woman_model)

#어깨
sort(unique(woman_model$shoulder))


#chest
sort(unique(woman_model$chest))


#belly 배 - 배도 할필요 없음
sort(unique(woman_model$belly))

woman_model[woman_model$belly>=1100,]

#neck-할필요없음
sort(unique(woman_model$neck))


#팔길이 arm - 할필요없음
sort(unique(woman_model$arm))


#겨드랑이둘레 할필요없음
sort(unique(woman_model$armhole))

#상체총길이-안해도됨
sort(unique(woman_model$top_length))


#손목둘레
sort(unique(woman_model$wrist))

#팔둘레 - 할필요없음
sort(unique(woman_model$arm_round))


#허리둘레 - 할필요없음
sort(unique(woman_model$waist))


#엉덩이둘레
sort(unique(woman_model$hip))

#넙다리둘레 - 할필요없음
sort(unique(woman_model$thigh))


#엉덩뼈높이
sort(unique(woman_model$bottom_leng))

#발목둘레 
sort(unique(woman_model$ankle))






