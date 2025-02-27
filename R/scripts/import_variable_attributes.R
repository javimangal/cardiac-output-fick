import_variable_attributes <- function(data, dictionary) {
  #' Import Variable Attributes
  #'
  #' This function converts the variables in the input dataframe `data` based on the specifications provided in the `dictionary` dataframe.
  #' It updates the data types, adds labels, and units to the variables as specified.
  #'
  #' @param data A dataframe containing the raw data to be transformed.
  #' @param dictionary A dataframe containing the variable specifications, including `Variable`, `Measurement_unit`, `Label`, and `Units`.
  #' 
  #' @return A dataframe with updated variable attributes based on the dictionary specifications.
  #' @export
  #'
  #' @examples
  #' # Assuming `data` and `dictionary` are pre-defined dataframes:
  #' new_data <- import_variable_attributes(data, dictionary)

    data <- data %>%
    mutate(across(
      all_of(dictionary$Variable),
      ~ {
        col_type <- dictionary$Measurement_unit[match(cur_column(), dictionary$Variable)]
        label <- dictionary$Label[match(cur_column(), dictionary$Variable)]
        unit <- dictionary$Units[match(cur_column(), dictionary$Variable)]
        
        # Convert based on Measurement_unit
        converted_col <- if (col_type == "Numeric") {
          as.numeric(.)
        } else if (col_type == "Categorical") {
          as.factor(.)
        } else if (col_type == "Character") {
          as.character(.)
        } else {
          stop(paste(
            "Error: No matching type found for column", cur_column(),
            "in dictionary's Measurement_unit. Found:", col_type
          ))
        }
        
        # Add label to the column
        attr(converted_col, "label") <- label
        
        # Add the unit only if it's not NA
        if (!is.na(unit)) {
          attr(converted_col, "unit") <- unit
        }
        
        converted_col
      }
    ))
  
  return(data)
}