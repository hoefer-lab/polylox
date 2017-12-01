barcode_pipeline first finds all ‘impossible’ codes in your data set. This can be barcodes containing the same element twice, have an even length, or have unidentifiable elements.
This can be seen by the output ‘Purging barcodes’ and ‘Done’ once it completes successfully.
Afterwards for all true barcodes the minimal number of recombination steps needed to create a certain barcode are looked up in a pre-calculated list. The output is ‘Finding minimal recombinations’ and again ‘Done’ upon successful completion. In the last step the distribution of minimal recombinations is used to calculate for each barcode a probability of generation. The script outputs ‘Calculating probabilities’ and ‘Done’ for this step.

The output of barcode_pipeline is a struct with the fields:

•	purged_codes  - a cell containing true barcodes
•	purged_reads – containing reads for the true barcodes
•	purged_freqs – containing barcode frequencies
•	freq_min_recom – the frequency distribution of the number of minimal recombination steps for the set of barcodes analyzed
•	minimal_recom – the list of minimal recombination steps for each barcode
•	pgen – the probability of generation for each barcode
•	annotation – the population names in a cell
