
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


