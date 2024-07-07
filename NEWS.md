# mgi.report.reader 0.1.3

* Added `marker_type_definitions` data set.
* Renamed `update_marker_symbol()` to `symbol_to_symbol()`.
* Renamed `convert_to_marker_id()` to `symbol_to_identifier()`.
* `symbol_to_symbol()` and `symbol_to_identifier()` use data table backend with
keyed column for improved look-up performance.
* Mappings from symbols to symbols/identifiers is backed up by memoised functions
making interactive experience a bit nicer.
* Added bundled tiny examples of MRK_List1.rpt, accessible with
`report_example()`, for examples and unit tests.
* Renamed `open_marker_in_mgi()` to `open_marker_id_in_mgi()`, and added
`open_marker_symbol_in_mgi()`.

# mgi.report.reader 0.1.2

* Fix a bug in `create_symbol_mapping()` and `create_id_mapping()` regarding the
removal of rows that appear more than once, but that are effectively the same
mapping.

# mgi.report.reader 0.1.1

* Fix a bug in `create_symbol_mapping()` and `create_id_mapping()` regarding the
removal of rows that appear more than once, i.e. rows that correspond to
unresolvable mappings.

# mgi.report.reader 0.1.0

* Extensive documentation for supported MGI reports.
* More flexible interface for `read_report()`.
* Report data is now accompanied by attributes providing report last
modification date and source: `report_last_modified()` and `report_source()`.
* Marker crosswalks from old symbols: `update_marker_symbol()` and
`convert_to_marker_id()`.
* New helper to quickly browse information about an MGI marker:
`open_marker_in_mgi()`.

# mgi.report.reader 0.0.1

* Initial CRAN submission.
