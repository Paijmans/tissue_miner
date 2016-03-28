#!/usr/bin/env Rscript
argv = commandArgs(TRUE)

if(length(argv) != 2){
  stop("Usage: cell_division_orientation_pattern.R <movie_db_directory> <output_directory>")
}else{
  movieDir=normalizePath(argv[1])
  if(is.na(file.info(movieDir)$isdir)) stop(paste("movie directory does not exist"))
  print(movieDir)
  outDir=normalizePath(argv[2])
  dir.create(outDir)
  setwd(outDir)
  print(outDir)
}

scriptsDir=Sys.getenv("TM_HOME")
if(is.na(file.info(scriptsDir)$isdir)){
  stop(paste("TM_HOME not correctly defined (",scriptsDir ,")"))
}


source(file.path(scriptsDir, "commons/TMCommons.R"))
source(file.path(scriptsDir, "commons/BaseQueryFunctions.R"))
source(file.path(scriptsDir, "config/default_config.R"))

db <- openMovieDb(movieDir)

print("")
print("Creating cell_division_orientation_pattern.mp4...")

mqf_cg_grid_unit_nematics_CD(movieDir, gridSize = 160, kernSize = 11) %>%
  render_movie("cell_division_orientation_pattern.mp4", list(
    geom_segment(aes(x=x1, y=y1, xend=x2, yend=y2),size=2, alpha=0.7, lineend="round", color="orange", na.rm=T)
  ))


