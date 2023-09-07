function simple_stabilization


disp('Example in "Lyapunov stability"');

%% system description 
A = [ 1, -2 ; 1, 4];
B = [1; 0.1];
n = 2;
m =1;

%% Step 1: Lmi start
setlmis([ ]);
nlmi = 0;

%% Step 2: Lmi variables
vbP = lmivar(1, [n, 1]);
vbK = lmivar(2, [m,n]);

%% Step 3: Lmi description
nlmi = nlmi +1;
lmiterm( [-nlmi, 1, 1, vbP], 1, 1);

nlmi = nlmi +1;
lmiterm( [nlmi, 1, 1, vbP], A, 1, 's');
lmiterm( [nlmi, 1, 1, vbK], B, 1, 's');

%% Step 4: Lmi solver
lmisys = getlmis;
options = [0, 5000, 0, 0, 1];
target = 0;
[tmin, xfeas] = feasp(lmisys, options, target);


if ~isempty(xfeas)

    if tmin < 0
        disp('feasible!');
        bP = dec2mat(lmisys, xfeas, vbP);
        bK = dec2mat(lmisys, xfeas, vbK);
        P = inv(bP);
        K = bK * P;
    else
        disp('imfeasible');
    end
else
    disp('imfeasible');
end
