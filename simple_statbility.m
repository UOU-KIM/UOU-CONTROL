function simple_statbility


disp('Example in "Lyapunov stability"');

%% system description 
A = [ -1, -2 ; 1, -4];
n = 2;

%% Step 1: Lmi start
setlmis([ ]);
nlmi = 0;

%% Step 2: Lmi variables
vP = lmivar(1, [n, 1]);

%% Step 3: Lmi description
nlmi = nlmi +1;
lmiterm( [nlmi, 1, 1, vP], 1, A, 's');

%% Step 4: Lmi solver
lmisys = getlmis;
options = [0, 5000, 0, 0, 1];
target = 0;
[tmin, xfeas] = feasp(lmisys, options, target);

if ~isempty(xfeas)

    if tmin < 0
        disp('This system is asyptotically stalbe!!');
        P = dec2mat(lmisys, xfeas, vP);
    else
        disp('This system is unstable');
    end
else
    disp('This system is unstable');
end
