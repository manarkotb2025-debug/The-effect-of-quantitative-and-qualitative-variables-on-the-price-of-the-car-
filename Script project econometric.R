###Reading and sampling the data
library(readxl)
Data <-read_excel("data car project.xls")
sample_data = Data[sample(1:nrow(Data), size = 200, replace= F),]

###Saving the sampled data as an excel file
install.packages('writexl')
library(writexl)
write_xlsx(sample_data, "C:/Users/yi727/OneDrive/Desktop/Econometrics Project//Sampled_data.xlsx")
View(sample_data)

###Model_1 (Linear model with a categorical variable)
attach(sample_data)
Model1=lm(price~Type)
summary(Model1)

###Model_2 (interaction between 2 categorical variables)
Model2=lm(price~Type + Cylinder + Make )
summary(Model2)

###model_3 
Hatchback<- ifelse(sample_data$Type=="Hatchback", 1, 0)
Sedan<- ifelse(sample_data$Type=="Sedan", 1, 0)
Coupe<-ifelse(sample_data$Type=="Coupe", 1, 0)
Wagon<-ifelse(sample_data$Type=="Wagont", 1, 0)
low<-ifelse(sample_data$Cylinder=="low", 1, 0)
moderate<-ifelse(sample_data$Cylinder=="moderate", 1, 0)
df_reg<-data.frame(Hatchback=Hatchback,Sedan=Sedan,Coupe=Coupe,Wagon=Wagon,low=low,moderate=moderate,price =sample_data$price)
df_reg
reduced_model3<-lm(price~Hatchback+Sedan+Coupe+Wagon+low+moderate, data=df_reg)
summary(reduced_model3)

model3<-lm(price~Hatchback+Sedan+Coupe+Wagon+low+moderate
           +Hatchback*low+Sedan*low+Coupe*low+Wagon*low
           +Hatchback*moderate+Sedan*moderate+Coupe*moderate+Wagon*moderate
           , data=df_reg)
summary(model3)

###Model_4
model4=lm(price~Make+Mileage+Doors) 
summary(model4) 
model4

###Model_5
Coupe<-ifelse(Data$Type=="Coupe",1,0)
Hatchback<-ifelse(Data$Type=="Hatchback",1,0) 
Sedan<-ifelse(Data$Type=="Sedan",1,0)
Wagon<-ifelse(Data$Type=="Wagon",1,0) 
Model5=lm(price~Coupe+Hatchback+Sedan+Wagon+Mileage+Coupe*Mileage+Hatchback*Mileage+Sedan*Mileage+Wagon*Mileage, data=Data) 
summary (Model5) 

###Model_6
model6=lm(price~ Cruise + Sound + Leather + Cruise*Sound + Cruise*Leather + 
             Sound*Leather+Cruise*Sound*Leather ,data=Data)
summary(model6)

###Model_7
#Create dummy variables for model_7 : 
dummy= rep(0,length(sample_data$Mileage))
dummy
dummy[sample_data$Mileage>15000]=1 
dummy 
#create (x-xi)di: 
sample_data$xdif=sample_data$Mileage-15000 
sample_data 
sample_data$Mileage_Dummy=dummy 
sample_data 
sample_data$x = sample_data$xdif*sample_data$Mileage_Dummy 
sample_data
write_xlsx(sample_data, "C:/Users/yi727/OneDrive/Desktop/Econometrics Project//Data.xlsx")
#model 7:
model7=lm(price~Mileage+x,data=sample_data)
summary(model7) 
model7
install.packages("dplyr")
library(dplyr)
library(carData)
Dta_cat=recode()
write_xlsx(sample_data, "C:/Users/yi727/OneDrive/Desktop/Econometrics Project//Data.xlsx")


####################################################################################################################################
###Model three using a cut-off point for a quantitative variable
sample_data$dummy <- ifelse(Mileage > 15000,
                            c(1), c(0)) 
sample_data$Miles = Mileage - 15000
sample_data$new = sample_data$minus*sample_data$dummy

attach(sample_data)
Model3=lm(price~Mileage+new)
summary(Model3)



