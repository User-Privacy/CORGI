function nr_violates = testprunedlocation(z, NR_LOC, nr_removed, epsilon, x_coord, y_coord, MIN_DISTANCE)
    removed_element = randsample(NR_LOC, nr_removed); 
    remained_element = setdiff(1:NR_LOC, removed_element); 
    
    z_pruned = z(remained_element, remained_element); 
    
    for i = 1:1:NR_LOC-nr_removed
        for j = 1:1:NR_LOC-nr_removed
            z_pruned(i, j) = 1/(1 - sum(z(remained_element(i), removed_element)))*z(remained_element(i),remained_element(j)); 
        end
    end

    nr_violates = 0; 
    
    for i = 1:1:NR_LOC-nr_removed
        for j = 1:1:NR_LOC-nr_removed
            distance = haversine([x_coord(i) y_coord(i)], [x_coord(j) y_coord(j)]);
            for l = 1:1:NR_LOC-nr_removed
                % distance = MIN_DISTANCE;
                % distance = ((x_coord(i) - x_coord(j))^2 + (y_coord(i) - y_coord(j))^2)^0.5; 
                if z_pruned(i, l) > exp(epsilon*distance)*z_pruned(j, l) 
                    nr_violates = nr_violates + 1;
                end
                if z_pruned(j, l) > exp(epsilon*distance)*z_pruned(i, l) 
                    nr_violates = nr_violates + 1;
                end
            end
        end
    end
    nr_violates = nr_violates/((NR_LOC-nr_removed-1)*(NR_LOC-nr_removed)^2); 
end