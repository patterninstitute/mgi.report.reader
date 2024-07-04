# Mappings from report types to readers
report_type_to_reader <-
  list(
    MRK_List1 = read_mrk_list1_rpt,
    MRK_List2 = read_mrk_list2_rpt,
    MGI_MRK_Coord = read_mrk_coord_rpt,
    MGI_Gene_Model_Coord = read_gene_model_coord_rpt,
    MGI_GTGUP = read_gtgup_rpt,
    MRK_Sequence = read_mrk_sequence_rpt,
    MRK_SwissProt_TrEMBL = read_mrk_swissprot_tr_embl_rpt,
    MRK_SwissProt = read_mrk_swissprot_rpt,
    MRK_GeneTrap = read_mrk_genetrap_rpt,
    MRK_ENSEMBL = read_mrk_ensembl_rpt,
    MGI_BioTypeConflict = read_mgi_biotype_conflict_rpt,
    PRB_PrimerSeq = read_prb_primerseq_rpt,
    MGI_InterProDomains = read_mgi_inter_pro_domains_rpt
  )
