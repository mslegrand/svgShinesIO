# for(i in 1:38){
#   fileName=paste0("samples/",categories[i],"/",tmp[i],".R")
#   content<-paste(grps[[i]], collapse="\n")
#   content<-gsub("},$", "}\n", content)
#   sink(fileName)
#   cat(content )
#   sink()
# }


#helper fn
extractField1<-function(fieldName,grp){
  pattern<-paste("#'( )+@",fieldName, sep="")
  grep(pattern, grp, ignore.case=TRUE)->indx
  if(length(indx)==0){ 
    ""
  } else{
    str_trim(gsub(pattern, "", grp[indx])  )
  }
}

#to get a list of all categories
#either get from sample.index
# do a dir


#read categories
catChoice<-dir("samples")

#to load a samples list we would
# scan the director and load all 
#read and parse each file

"Animations"->category
# readLines(fileName)->lines
# extractField1(lines,"Title")->title

#create list of titles and fileNames for category
readCatFiles<-function(category){
  fileNames<-dir(paste0("samples/",category))
  fileNames<-paste0("samples/",category,"/",fileNames)
  getTitle<-function(fileName){
    readLines(fileName)->lines
    extractField1("title",lines)
  }
  catFiles<-sapply(fileNames, getTitle)  
  cf<-names(catFiles)
  names(cf)<-catFiles
  as.list(cf)
}

# for each fileName, 
#  1. readfile
#  2. extract title
#  3. title is fed to choices of radio buttons

# fileName is recorded for loading file

#!!!need list with title, fileName

# upon request by server, load file
# fill description 
# fill (title) name, concepts in ui
# extract and run code.

getFileInfo<-function(fileName){
  #read the file
  readLines(fileName)->lines 
  flds<-list(
    name=extractField1("name",lines),
    title=extractField1("title",lines),
    family=extractField1("family",lines),
    title=extractField1("title",lines),
    description=extractField1("description",lines),
    concepts=extractField1("concepts",lines),
    src=paste(lines,collapse="\n")
  )
}


