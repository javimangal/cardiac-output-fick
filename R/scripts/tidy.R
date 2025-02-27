check_non_unique_x <- function(data, id_col, x_col) {
  # Group by ID and summarize to count unique values of x for each ID
  non_unique_ids <- data %>%
    group_by(!!sym(id_col)) %>% # Group by the ID column
    summarize(unique_x_count = n_distinct(!!sym(x_col))) %>% # Count unique values of x
    filter(unique_x_count > 1) %>% # Filter IDs where x is not unique
    pull(!!sym(id_col)) # Pull the IDs where x is not unique

  # Return the non-unique IDs
  return(non_unique_ids)
}
