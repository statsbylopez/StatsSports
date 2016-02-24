

Sample.punt <- function(yards.from.own.goal){
  data.punt <- filter(punt, yfog <= yards.from.own.goal + 5, 
                      yfog >= yards.from.own.goal - 5, pnet >=0)
  sim.punt <- sample_n(data.punt, 1)
  print(paste("The net number of punting yards is ", sim.punt$pnet, 
              ". This means that the ball is spotted ", sim.punt$pnet + yards.from.own.goal, 
              " yards from the original offensive team's end zone. The defensive team takes possession, ", 
              100 - (sim.punt$pnet + yards.from.own.goal), 
              " yards from its own end zone", sep = ""))
        }


Sample.FG <- function(yards.from.own.goal){
  distance <- 100 - yards.from.own.goal + 17
  data.FG <- filter(FG, dist <= distance + 1, 
                      dist >= distance - 1)
  sim.FG <- sample_n(data.FG, 1)
  if (sim.FG$good){print(paste("The chosen field goal is ", sim.FG$dist, 
              " yards long, and it is successful! (3 pts)", sep = ""))}
  else {print(paste("The chosen field goal is ", sim.FG$dist, 
              " yards long, and it is NOT successful! Too bad. ",
              "The defensive team takes possession ", distance - 10,
              " yards from its own end zone.", sep = ""))}
    }
  


Sample.RP <- function(down, yards.to.go, yards.from.own.goal) {
  if (yards.from.own.goal <= 97) {
    data.RP <- filter(rush.pass, yfog <= yards.from.own.goal + 2, 
                    yfog >= yards.from.own.goal - 2,
                    dwn == down, ytg == yards.to.go)
  }
   else {data.RP <- filter(rush.pass, yfog >= yards.from.own.goal - 2,
                         dwn == down, ytg == yards.to.go)}
  
    sim.RP <- sample_n(data.RP, 1)
  
  if (sim.RP$yds >= sim.RP$ytg) {
    sim.RP.paste <- paste("You called a", sim.RP$type, "which gained", 
                        sim.RP$yds, "yard(s) and picked up a first down.")
  }
    else {sim.RP.paste <- paste("You called a", sim.RP$type, "which gained", 
                        sim.RP$yds, "yard(s) and failed to pick up a first down.")}
    sim.RP.paste.pts<-""
  if (sim.RP$pts < -3) {sim.RP.paste.pts <- "Oh no! You gave up a touchdown (-7 pts)"}
  if (sim.RP$pts == -2) {sim.RP.paste.pts <- "Oh no! You gave up a safety (-2 pts)"}
  if (sim.RP$pts > 0) {sim.RP.paste.pts <- "Bam! You scored a touchdown (7 pts)"}
  print(paste(sim.RP.paste, sim.RP.paste.pts))
  }
