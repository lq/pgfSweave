pgfSweave <- function(filename, compile.tex=TRUE, syntax = getOption("SweaveSyntax"), ...){
    
    #Run Sweave
    Sweave(filename,driver=pgfSweaveDriver,syntax=syntax)
    
	#if available compile pgf graphics
    if(compile.tex){
        
        #Strip the extension and compile the pgf graphics separately
	    fn <- strsplit(filename,'\\.')[[1]][1]
        cmds <- readLines(paste(fn,'sh',sep='.'))
        dummy <- lapply(cmds,system)

        #set special versions of calls to latex or pdflatex
        if(is.null(match.call()$pdf))
            Sys.setenv(LATEX=paste("latex --jobname=",fn,sep=''))
        else
            Sys.setenv(PDFLATEX=paste("pdflatex --jobname=",fn,sep=''))
    
        #run texi2dvi on the tex file        
        texi2dvi(paste(fn,'tex',sep='.'),...)
    }

}