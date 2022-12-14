  function max_r = maxratio(z, DELTA, NR_LOC, i, j)
    max_r = 1; 
    v = 1:1:NR_LOC;
    for delta = 1:1:DELTA
        s = nchoosek(v, delta);
        for s_idx = 1:1:size(s, 1)
            inst_r = (1 - sum(z(j, s(s_idx, :))))/(1 - sum(z(i, s(s_idx, :)))); 
            if inst_r > max_r
                max_r = inst_r; 
            end
            if inst_r > 9999
                max_r = 9999; 
            end 
        end
    end
end