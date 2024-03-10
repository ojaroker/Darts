
arg1 = 13;
arg2 = 199;

command = "R CMD BATCH " + ...
    "--no-save --no-restore " + ...
    "'--args " + arg1 + " " + arg2 + "' dartsRProg.R testout";