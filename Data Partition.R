library(readxl) #reads excel files
library(tm) ##text mining package
library(ggplot2) ##graphing package
library(lsa)  ##latent semantic analysis
library(topicmodels) ##contains Latent Dirichlet Allocation proc




set.seed(75) ##set seed for any random functions used going forward

fulldata<-read_excel("C:/Users/jboswell/Desktop/thesis/Sources.xlsx", sheet = "Sheet1", col_types = c("numeric","numeric", "text", "text"))
fulldatarandom <- fulldata[sample(nrow(fulldata)),]
head(fulldatarandom)
docs <- VCorpus(VectorSource(fulldatarandom$SUMMARY))
head(docs)


###remove punctuation
docs1<-tm_map(docs,removePunctuation)
### change to lower case docs2<-tm_map(docs1,tolower)

###remove stop words
docs2<-tm_map(docs1,removeWords,stopwords_en)
###remove numbers
docs3<-tm_map(docs2,removeNumbers)
### stem words
docs4<-tm_map(docs3,stemDocument)
### remove blanks
docs5<-tm_map(docs4,stripWhitespace)
### docs6<-tm_map(docs5,PlainTextDocument)

set.seed(75) ##set seed for any random functions used going forward

##get the document-term matrix 
dtm<-DocumentTermMatrix(docs4)
dim(dtm) #give number of documents and terms
###term document matrix
tdm<-TermDocumentMatrix(docs4)

docslda <- LDA(dtm, k = 10)

docstopics<-topics(docslda, k = 1)
docstopics

docstopics2<-topics(docslda, k = 2)
docstopics2

topicsterms2<-terms(docslda, k = 5)
topicsterms2



