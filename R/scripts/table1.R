# Summary of age
age <- data_unique %>%
  summarize(
    Variable = "Age",
    Mean = round(mean(age, na.rm = TRUE), 1),
    SD = round(sd(age, na.rm = TRUE), 1)
  ) %>%
  mutate(Summary = paste0(Mean, " (", SD, ")")) %>% 
  select(Variable, Summary)
10/52
# Summary of sex 
sex <- data_unique %>% 
  group_by(sex) %>%
  summarize(n = n()) %>%
  mutate(
    percentage = round((n / sum(n) * 100),1),
    Summary = paste0(n, " (", percentage, "%)"),
    Variable = sex
    ) %>%
  select(Variable, Summary)

# Summary of BMI
BMI <- data_unique %>%
  summarize(
    Variable = "BMI",
    Median = round(median(BMI, na.rm = TRUE), 1),
    IQR = paste0("(", 
                 round(quantile(BMI, 0.25, na.rm = TRUE), 1), " - ", 
                 round(quantile(BMI, 0.75, na.rm = TRUE), 1), ")")
  ) %>%
  mutate(Summary = paste(Median, IQR)) %>% 
  select(Variable, Summary)

# Summary of BMI categories
BMI_categories <- data_unique %>% 
  group_by(obesity) %>%
  summarize(n = n()) %>%
  mutate(
    percentage = round((n / number_participants * 100),1),
    Summary = paste0(n, " (", percentage, "%)"),
    Variable = obesity
  ) %>%
  select(Variable, Summary)

# Summary of comorbidities
comorbidities <- data_unique %>% 
  separate_rows(comorbidities, sep = " \\| ") %>% 
  mutate(
    comorbidities = case_when(
      comorbidities == "Overweight" ~ "Overweight/obesity",
      comorbidities == "Obesity" ~ "Overweight/obesity",
      comorbidities == "Status epilepticus" ~ "Epilepsy",
      TRUE ~ comorbidities
    )
  ) %>% 
  count(comorbidities) %>% 
  arrange(desc(is.na(comorbidities)), desc(n)) %>%
  mutate(
    comorbidities = ifelse(is.na(comorbidities), "No comorbidities", comorbidities),
    percentage = round((n / number_participants * 100),1),
    Summary = paste0(n, " (", percentage, "%)"),
    Variable = comorbidities
  ) %>%
  select(Variable, Summary)

# Summary of diagnosis
infectious_diagnosis <- c(
  "Sepsis", "COVID-19", "Community-acquired pneumonia", "Endocarditis",
  "Ventilation-associated pneumonia", "Urinary tract infection", "Influenza",
  "Hospital-acquired pneumonia", "Peritonitis", "Pyelonephritis", 
  "Soft-tissue infection", "Tuberculous meningitis"
)

trauma_diagnosis <- c("Traumatic brain injury", "Polytrauma", "Postsurgical", 
                      "Abdominal trauma", "Burns", "Strangulation")

cardiovascular_diagnosis <- c("Cardiac arrest", "Acute myocardial infarction",
                              "Hypertensive emergency", "Pulmonary thromboembolism")

pattern_sepsis <- paste0(str_replace_all(infectious_diagnosis, fixed("|"), "\\|"), collapse = "|")
pattern_trauma <- paste0(str_replace_all(trauma_diagnosis, fixed("|"), "\\|"), collapse = "|")
pattern_cardiovascular <- paste0(str_replace_all(cardiovascular_diagnosis, fixed("|"), "\\|"), collapse = "|")

diagnosis <- data_unique %>% 
  mutate(
    diagnosis = str_replace_all(diagnosis, pattern_sepsis, "Sepsis"),
    diagnosis = str_replace_all(diagnosis, pattern_trauma, "Trauma/Surgical"),
    diagnosis = str_replace_all(diagnosis, pattern_cardiovascular, "Cardiovascular")
  ) %>%
  separate_rows(diagnosis, sep = " \\| ") %>%
  distinct(ID, diagnosis) %>% 
  filter(diagnosis != "Shock") %>% 
  count(diagnosis) %>% 
  arrange(desc(is.na(diagnosis)), desc(n))  %>%
  mutate(
    percentage = round((n / number_participants * 100),1),
    Summary = paste0(n, " (", percentage, "%)"),
    Variable = diagnosis
  ) %>%
  select(Variable, Summary)

# Combine all summaries
descriptive_table <- rbind(
  c("Age (years)", "Mean (SD)"),
  age, 
  c("Sex", "n (%)"),
  sex, 
  c("BMI", "Median (IQR)"),
  BMI, 
  c("BMI categories", "n (%)"),
  BMI_categories, 
  c("Comorbidities", "n (%)"),
  comorbidities, 
  c("Diagnosis", "n (%)"),
  diagnosis
  )

# Create a Markdown table
markdown_table <- kable(descriptive_table, format = "markdown")

# Save to a Markdown file
writeLines(markdown_table, paste0(tabfolder,"/table_summary.md"))