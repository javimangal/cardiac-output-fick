summary_table <- data %>%
  select(lactate:ExO2) %>%
  tbl_summary(
    type = all_continuous() ~ "continuous2",
    statistic = list(
      all_continuous() ~ c("{mean} ({sd})", "{median} ({p25} - {p75})")
    ),
    digits = all_continuous() ~ 2,
    label = list(
      lactate     = "lactate (mmol/L)",
      FiO2        = "FiO2 (%)",
      pH          = "pH",
      HCO3        = "HCO3 (mmol/L)",
      base_deficit = "base deficit (mmol/L)",
      PaO2        = "PaO2 (mmHg)",
      PaCO2       = "PaCO2 (mmHg)",
      SaO2        = "SaO2 (%)",
      PvO2        = "PvO2 (mmHg)",
      PvCO2       = "PvCO2 (mmHg)",
      SvO2        = "SvO2 (%)",
      PAlvO2      = "PAlvO2 (mmHg)",
      CcO2        = "CcO2 (%)",
      CaO2        = "CaO2 (ml/dl)",
      CvO2        = "CvO2 (ml/dl)",
      DavO2       = "DavO2 (ml/dl)",
      ExO2        = "ExO2 (%)"
    )
  ) %>%
  modify_header(label = "**Variable (Unit)**") %>%
  modify_caption("**Table 2.** Summary of blood gas analysis at the moment of measurement") %>%
  modify_footnote(
    all_stat_cols() ~ paste0(
      "Abbreviations: ",
      "Alveolar oxygen pressure (PAlvO2), ",
      "Arterial oxygen content (CaO2), ",
      "Arterial oxygen saturation (SaO2), ",
      "Arteriovenous oxygen difference (DavO2), ",
      "Capillary oxygen content (CcO2), ",
      "Hydrogen potential (pH), ",
      "Inspiratory fraction of Oxygen (FiO2), ",
      "Oxygen extraction (ExO2), ",
      "Oxygen saturation in venous blood (SvO2), ",
      "Partial pressure of carbon dioxide (PaCO2), ",
      "Partial pressure of oxygen (PaO2), ",
      "Partial pressure of oxygen in venous blood (PvO2), ",
      "Q1 (25th percentile), ",
      "Q3 (75th percentile), ",
      "SD (Standard deviation), ",
      "Serum bicarbonate (HCO3), ",
      "Serum Lactate (lactate), ",
      "Venous oxygen content (CvO2), ",
      "Venous partial pressure of CO2 (PvCO2)"
    )
  )

# Create a Markdown table
markdown_table <- kable(summary_table, format = "markdown")

# Save to a Markdown file
writeLines(markdown_table, paste0(tabfolder,"/table_blood_gas.md"))