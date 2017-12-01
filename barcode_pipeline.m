function y = barcode_pipeline(codes,reads,annotation)
    clc
    formatSpec = 'Loading Data\n';
    fprintf(formatSpec);
    load data.mat
    formatSpec = 'Done\n';
    fprintf(formatSpec);
    
    prob_path = zeros(1866890,1);
    
    formatSpec = 'Purging Barcodes\n';
    fprintf(formatSpec);
    
  
    m=1;
    for i=1:length(codes)
        if sum(strcmp(barcode_library_complete, codes{i,1})) > 0
            purged_codes{m,1} = codes{i};
            purged_reads(m,:) = reads(i,:);
            m=m+1;
        end
    end
    formatSpec = 'Done\n';
    fprintf(formatSpec);
    
    reads_sum = sum(purged_reads);
    for i=1:size(reads,2)
        purged_freq(:,i) = purged_reads(:,i)./reads_sum(i);
    end
    
    formatSpec = 'Finding minimal recombinations\n';
    fprintf(formatSpec);
    for i=1:length(purged_codes)
        minimal_recom_list(i,1) = min_list(strcmp(barcode_library_complete,purged_codes{i}));
    end
 
    for i=1:11
        freq_min_recom(i,1) = sum(minimal_recom_list == i-1)/length(purged_codes);
        prob_path = prob_path + freq_min_recom(i,1).*path_matrix_ld_complete(:,i);
    end
    formatSpec = 'Done\n';
    fprintf(formatSpec);
    
    
    formatSpec = 'Calculating probabilites\n';
    fprintf(formatSpec);

    
    for i=1:length(purged_codes)
        prob(i,1) = prob_path(find(strcmp(barcode_library_complete,purged_codes{i}) == 1));
    end
    
    formatSpec = 'Done\n';
    fprintf(formatSpec);
    
    
    y.purged_codes = purged_codes;
    y.purged_reads = purged_reads;
    y.purged_freq = purged_freq;
    y.recombination_frequencies = freq_min_recom;
    y.minimal_recom = minimal_recom_list;
    y.pgen = prob;
    y.annotation = annotation;

end