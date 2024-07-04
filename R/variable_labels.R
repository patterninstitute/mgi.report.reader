add_label <- function(x, label) {
  attr(x, "label") <- label
  x
}

# Variable labels.
var_lbl <-
  c(
    marker_id = "Marker identifier",
    marker_id_now = "Replacement marker identifier",
    marker_symbol = "Marker symbol",
    marker_symbol_now = "Replacement marker symbol",
    marker_name = "Marker name",
    marker_type = "Marker type",
    marker_status = "Official (O), Withdrawn (W)",
    genetic_map_pos = "centiMorgan (cM)",
    chromosome = "1-19, X, Y or MT",
    start = "Start position",
    end = "End position",
    strand = "Sense (+), antisense (-)",
    feature_type = "MGI feature type",
    synonyms = "Marker synonyms",
    note = "Note on marker withdrawal",
    assembly = "Genome assembly",
    biotype = "Ensembl's biotype",
    source = "Genomic data provider",
    database = "Genomic dataset or model",
    ensembl_gen_id = "Ensembl gene identifier",
    ensembl_trp_id = "Ensembl transcript identifier",
    ensembl_prt_id = "Ensembl protein identifier",
    entrez_gen_id = "Entrez gene identifier",
    genbank_id = "GenBank identifier",
    refseq_trp_id = "RefSeq transcript identifier",
    refseq_prt_id = "RefSeq protein identifier",
    tr_embl_prt_id = "UniProtKB/TrEMBL identifier",
    swiss_prt_id = "UniProtKB/Swiss-Prot identifier",
    uniprot_id = "UniProtKB identifier",
    unigene_id = "UniGene identifier",
    interpro_id = "InterPro identifier",
    interpro_domain = "InterPro domain",
    cell_line_id = "Mutant cell line identifier",
    is_mgi_rep = "MGI representative gene model",
    gene_id = "Gene identifier",
    primer_id = "Primer pair marker identifier",
    primer_name = "Primer pair marker name",
    primer_fwd_seq = "Forward primer sequence",
    primer_rev_seq = "Reverse primer sequence",
    primer_amplimer_size = "Amplimer size"
  )

add_label_to_marker_id <- function(x) {
  add_label(x, var_lbl["marker_id"])
}

add_label_to_marker_id_now <- function(x) {
  add_label(x, var_lbl["marker_id_now"])
}

add_label_to_marker_symbol <- function(x) {
  add_label(x, var_lbl["marker_symbol"])
}

add_label_to_marker_symbol_now <- function(x) {
  add_label(x, var_lbl["marker_symbol_now"])
}

add_label_to_marker_name <- function(x) {
  add_label(x, var_lbl["marker_name"])
}

add_label_to_marker_type <- function(x) {
  add_label(x, var_lbl["marker_type"])
}

add_label_to_marker_status <- function(x) {
  add_label(x, var_lbl["marker_status"])
}

add_label_to_genetic_map_pos <- function(x) {
  add_label(x, var_lbl["genetic_map_pos"])
}

add_label_to_chromosome <- function(x) {
  add_label(x, var_lbl["chromosome"])
}

add_label_to_start <- function(x) {
  add_label(x, var_lbl["start"])
}

add_label_to_end <- function(x) {
  add_label(x, var_lbl["end"])
}

add_label_to_strand <- function(x) {
  add_label(x, var_lbl["strand"])
}

add_label_to_feature_type <- function(x) {
  add_label(x, var_lbl["feature_type"])
}

add_label_to_synonyms <- function(x) {
  add_label(x, var_lbl["synonyms"])
}

add_label_to_note <- function(x) {
  add_label(x, var_lbl["note"])
}

add_label_to_assembly <- function(x) {
  add_label(x, var_lbl["assembly"])
}

add_label_to_biotype <- function(x) {
  add_label(x, var_lbl["biotype"])
}

add_label_to_source <- function(x) {
  add_label(x, var_lbl["source"])
}

add_label_to_database <- function(x) {
  add_label(x, var_lbl["database"])
}

add_label_to_ensembl_gen_id <- function(x) {
  add_label(x, var_lbl["ensembl_gen_id"])
}

add_label_to_ensembl_trp_id <- function(x) {
  add_label(x, var_lbl["ensembl_trp_id"])
}

add_label_to_ensembl_prt_id <- function(x) {
  add_label(x, var_lbl["ensembl_prt_id"])
}

add_label_to_entrez_gen_id <- function(x) {
  add_label(x, var_lbl["entrez_gen_id"])
}

add_label_to_genbank_id <- function(x) {
  add_label(x, var_lbl["genbank_id"])
}

add_label_to_refseq_trp_id <- function(x) {
  add_label(x, var_lbl["refseq_trp_id"])
}

add_label_to_refseq_prt_id <- function(x) {
  add_label(x, var_lbl["refseq_prt_id"])
}

add_label_to_tr_embl_prt_id <- function(x) {
  add_label(x, var_lbl["tr_embl_prt_id"])
}

add_label_to_swiss_prt_id <- function(x) {
  add_label(x, var_lbl["swiss_prt_id"])
}

add_label_to_uniprot_id <- function(x) {
  add_label(x, var_lbl["uniprot_id"])
}

add_label_to_unigene_id <- function(x) {
  add_label(x, var_lbl["unigene_id"])
}

add_label_to_interpro_id <- function(x) {
  add_label(x, var_lbl["interpro_id"])
}

add_label_to_interpro_domain <- function(x) {
  add_label(x, var_lbl["interpro_domain"])
}

add_label_to_cell_line_id <- function(x) {
  add_label(x, var_lbl["cell_line_id"])
}

add_label_to_is_mgi_rep <- function(x) {
  add_label(x, var_lbl["is_mgi_rep"])
}

add_label_to_gene_id <- function(x) {
  add_label(x, var_lbl["gene_id"])
}

add_label_to_primer_id <- function(x) {
  add_label(x, var_lbl["primer_id"])
}

add_label_to_primer_name <- function(x) {
  add_label(x, var_lbl["primer_name"])
}

add_label_to_primer_fwd_seq <- function(x) {
  add_label(x, var_lbl["primer_fwd_seq"])
}

add_label_to_primer_rev_seq <- function(x) {
  add_label(x, var_lbl["primer_rev_seq"])
}

add_label_to_primer_amplimer_size <- function(x) {
  add_label(x, var_lbl["primer_amplimer_size"])
}
