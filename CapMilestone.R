##Packages
library(tm)
library(SnowballC)
library(ggplot2)
library(RWeka)
library(tau)
library(data.table)

##Load Datasets into workspace

twitterDat<-readLines("en_US.twitter.txt")
newsDat<-readLines("en_US.news.txt")
blogsDat<-readLines("en_US.blogs.txt")

##View file summary and determine if sampling is necessary

twitter_size<-file.info("en_US.blogs.txt")$size/1024^2
news_size<-file.info("en_US.news.txt")$size/1024^2
blogs_size<-file.info("en_US.blogs.txt")$size/1024^2

FileSummary<-data.frame(file=c("twitter","news","blogs"),NumLines=c(length(twitterDat),length(newsDat),length(blogsDat)),filesize=c(twitter_size,news_size,blogs_size))
FileSummary

##Random Sampling

set.seed(1234)
twitterSample<-sample(twitterDat,length(twitterDat)*.01)
newsSample<-sample(newsDat,length(newsDat)*.01)
blogsSample<-sample(blogsDat,length(blogsDat)*.01)

##Create Corpus and perform processing

textSample<-c(twitterSample,newsSample,blogsSample)
docs<-VCorpus(VectorSource(textSample))

#Build content transformer (inspired by "gentle introduction to text mining using r)
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
docs<-tm_map(docs,toSpace, "/")
docs<-tm_map(docs,toSpace, "@")
docs<-tm_map(docs,toSpace, "\\|")


docs<-tm_map(docs,removePunctuation)
docs<-tm_map(docs,removeNumbers)
docs<-tm_map(docs,tolower)
docs<-tm_map(docs,removeWords,stopwords("english"))
docs<-tm_map(docs,stripWhitespace)
docs<-tm_map(docs,stemDocument)

##Load Profanity word list and remove first line which is incomprehensible
profanity<-readLines("C:/Users/Vivek/Desktop/DataScience/DScapstone/ProfanityWords.txt")
profanity<-profanity[c(-1)]
docs<-tm_map(docs,removeWords,profanity)
docs<-tm_map(docs,stripWhitespace)

docs<-tm_map(docs,PlainTextDocument)
inspect(docs[13])

##Create term document matrix and explore most frequent terms
dtm<-DocumentTermMatrix(docs)
findFreqTerms(dtm,1000)

##Use n-grams to see which combination of words/phrases are most frequent 
#Monograms
dtms<-removeSparseTerms(dtm,.99)
freq<-colSums(as.matrix(dtms))
ord<-order(freq,decreasing = TRUE)
freq[head(ord)]

wfMono=data.frame(word=names(freq),occurences=freq)
g1<-ggplot(subset(wfMono,freq>1400),aes(word,occurences))
g1<-g1+geom_bar(stat="identity")
g1<-g1+theme(axis.text.x=element_text(angle=45, hjust=1))
g1<-g1+labs(title="Monogram Frequency (>1400 occurences)")
g1

##Bigram and Trigram tokenizer function
bigram_tokenizer<-function(x) NGramTokenizer(x,Weka_control(min=2,max=2))
trigram_tokenizer<-function(x) NGramTokenizer(x,Weka_control(min=3,max=3))

##Bigram frequency
dtmBigram<-DocumentTermMatrix(docs,list(tokenize=bigram_tokenizer))
dtmBigrams<-removeSparseTerms(dtmBigram,.999)
freqBigram<-colSums(as.matrix(dtmBigrams))
####Below is REVISED since the ord variable references monograms
ordBigram<-order(freqBigram,decreasing = TRUE)
freqBigram[head(ordBigram)]

wfBigram=data.frame(phrase=names(freqBigram),occurences=freqBigram)
g2<-ggplot(subset(wfBigram,freqBigram>90),aes(phrase,occurences))
g2<-g2+geom_bar(stat="identity")
g2<-g2+theme(axis.text.x=element_text(angle=45, hjust=1))
g2<-g2+labs(title="Bigram Frequency (>90 occurences)")
g2

##Trigram Frequency
dtmTrigram<-DocumentTermMatrix(docs,list(tokenize=trigram_tokenizer))
dtmTrigrams<-removeSparseTerms(dtmTrigram,.9999)
freqTrigram<-colSums(as.matrix(dtmTrigrams))
####Below is REVISED since the ord variable refrences monograms
ordTrigram<-order(freqTrigram,decreasing = TRUE)
freqTrigram[head(ordTrigram)]

wfTrigram=data.frame(phrase=names(freqTrigram),occurences=freqTrigram)
g3<-ggplot(subset(wfTrigram,freqTrigram>10),aes(phrase,occurences))
g3<-g3+geom_bar(stat="identity")
g3<-g3+theme(axis.text.x=element_text(angle=45, hjust=1))
g3<-g3+labs(title="Trigram frequency (>10 occurences)")
g3


####PREDICTIVE MODEL
tokenizeLines <- function(lines, lang) {
        # TODO end of line token
        lines <- removePunctuation(tolower(lines));
        #lines <- removeWords(lines, stopwords(kind = lang));
        toks <- MC_tokenizer(lines)
        
        filterTok <- function(tok) {
                tok[nchar(tok)>0]
        }
        filterTok(toks);
}


predictMatches<-function(sentence, potentialAnswers) {
        toks<-tokenizeLines(sentence,'en');
        lastTok<-toks[[length(toks)]]
        DT<-freqBigram[lastTok & tok1 %in% potentialAnswers]
        ;
        
}

