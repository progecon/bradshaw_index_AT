###################################### custom_functions.R ######################################


####	Being used for Quatro inline text in order to automatise reports.
####	The format_unique_classes function summarizes unique data types in a dataset and provides explanations for each type. 
####	It processes input data to produce a formatted string listing data types with descriptions.

# Custom function to get unique data types with proper formatting and explanations
format_unique_classes <- function(data) {
  # Get unique classes and ensure they are treated as character vectors
  unique_classes <- unique(as.character(sapply(data, class)))
  
  # Prepare explanation texts for each class
  explanations <- c(
    numeric = "`numeric` refers to data in the form of numbers.",
    haven_labelled = "`haven_labelled` is a special form of categorical data created when importing SPSS data into R via the use of the `haven` package. Categorical data are stored as numbers, with the actual category labels stored in a separate attribute. This method is memory-efficient and easier to program with.",
    character = "`character` represents text or string data.",
    POSIXct = "`POSIXct` is used for date and time data."
  )
  
  # Initialize vectors to hold formatted classes and explanations
  formatted_classes <- character()
  explanation_texts <- character()
  
  for (class in unique_classes) {
    # Check if the class is a vector representation
    if (grepl("^c\\(", class)) {
      # Extract the individual classes from the vector representation
      extracted_classes <- gsub("^c\\(|\\)$", "", class) %>% 
        strsplit(", ") %>% 
        unlist()
      
      # Process each extracted class
      for (extracted_class in extracted_classes) {
        cleaned_class <- gsub("\"", "", extracted_class)  # Remove quotes
        if (cleaned_class %in% names(explanations)) {
          formatted_classes <- c(formatted_classes, paste0("`", cleaned_class, "`"))
          explanation_texts <- c(explanation_texts, explanations[cleaned_class])
        }
      }
    } else {
      # Handle individual classes
      if (class %in% names(explanations)) {
        formatted_classes <- c(formatted_classes, paste0("`", class, "`"))
        explanation_texts <- c(explanation_texts, explanations[class])
      }
    }
  }
  
  # Prepare the text for the unique classes
  if (length(formatted_classes) > 1) {
    class_text <- paste(paste(formatted_classes[-length(formatted_classes)], collapse = ", "), "and", formatted_classes[length(formatted_classes)])
  } else {
    class_text <- formatted_classes
  }
  
  # Combine the explanations into a single string
  explanations_combined <- paste(explanation_texts, collapse = " ")
  
  # Combine the class text and explanation text
  final_text <- paste("Our data set includes", length(unique_classes), "unique data types, namely", class_text, ". ", explanations_combined)
  
  return(final_text)
}

