function [out1,out2] = runRScript(input1,input2)


%Make sure you are in correct working directory (pwd)
command = "R CMD BATCH " + ...
    "--no-save --no-restore " + ...
    "'--args " + input1 + " " + input2 + "' dartsRProg.R testout";

%Run command in command line
system(command);

%Table with 2 columns, Var1 (n), Var2 (values)
T = readtable('out.csv','NumHeaderLines',1);


out1 = T.Var2(1);
out2 = T.Var2(2);


end

