#' Create ThreeD meta data
#' @description Function to make ThreeD meta data.
#' @param path path for storing csv output. Default is NULL. The path is only needed i csv_output = TRUE.
#' @param csv_output logical; argument csv_output or not.
#' The default is csv_output = FALSE. If csv_output = TRUE a csv file is produced and saved under the path name.
#'
#' @return a tibble and optionally a csv file
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr bind_cols if_else mutate arrange group_by sample_frac ungroup bind_rows case_when left_join filter select row_number
#' @importFrom tidyr crossing
#' @importFrom tibble tibble
#'
#' @examples
#' create_threed_meta_data()
#'
#' @export


create_threed_meta_data <- function(path = NULL, csv_output = FALSE){

  # Create meta data
  # Lia and Joa
  origSiteID <-  c("Liahovden", "Joasete")
  origBlockID <-  c(1:10)
  origPlotID <- tibble(origPlotID = 1:160)
  warming <-  c("A", "W")
  grazing <-  c("C", "M", "I", "N")
  # Nitrogen level needs to be in a certain order
  nitrogen <- tibble(Nlevel = rep(rep(c(1,6,5,3,10,7,4,8,9,2), each = 8), 2))

  # add corresponding N amount in kg per ha and year
  NitrogenDictionary <- tibble(Nlevel = c(1,6,5,3,10,7,4,8,9,2),
                               Namount_kg_ha_y = c(0, 5, 1, 0, 150, 10, 0.5, 50, 100, 0))

  # cross site, block warm and grazing treatment
  meta <- crossing(origSiteID, origBlockID, warming, grazing) %>%
    bind_cols(nitrogen)

  # Vik (is done separately because it is only destination site)
  vik <- tibble(
    origSiteID = factor("Vikesland", levels = c("Liahovden", "Joasete", "Vikesland")),
    origBlockID = rep(1:10, each = 4),
    origPlotID = 161:200,
    destSiteID = factor(NA, levels = c("Liahovden", "Joasete", "Vikesland")),
    Nlevel = rep(c(1,6,5,3,10,7,4,8,9,2), each = 4),
    warming = "W",
    grazing = rep(c("notN", "notN", "notN", "N"), 10),
    fence = if_else(grazing == "N", "out", "in"))

  # randomize warming and grazing treatment
  set.seed(32) # seed is needed to replicate sample_frac
  meta2 <- meta %>%
    # create variable for grazing treatment inside or outside fence
    mutate(fence = if_else(grazing == "N", "out", "in")) %>%
    mutate(origSiteID = factor(origSiteID, levels = c("Liahovden", "Joasete", "Vikesland"))) %>%
    arrange(origSiteID) %>% # site needs to be arranged, because transplant goes only in one direction
    group_by(origSiteID, origBlockID, Nlevel, fence) %>%
    sample_frac() %>% # randomization
    ungroup() %>%
    bind_cols(origPlotID) %>% # add plotID
    mutate(destSiteID = case_when(
      origSiteID == "Liahovden" & warming == "A" ~ "Liahovden",
      origSiteID == "Joasete" & warming == "W" ~ "Vikesland",
      TRUE ~ "Joasete")) %>%
    mutate(destSiteID = factor(destSiteID, levels = c("Liahovden", "Joasete", "Vikesland"))) %>%
    bind_rows(vik) %>% # add Vik
    group_by(origSiteID, origBlockID, warming, fence) %>%
    mutate(rownr = row_number())


  # Join meta2 to warmed plots
  threeD_metadata <- left_join(
    meta2 %>% filter(origPlotID < 161), # remove plots from vik
    # only warmed plots, remove unused rows
    meta2 %>% filter(warming == "W") %>% select(-grazing, -destSiteID, destPlotID = origPlotID),
    by = c("destSiteID" = "origSiteID", "origBlockID" = "origBlockID", "rownr" = "rownr", "fence" = "fence", "Nlevel" = "Nlevel", "warming" = "warming"),
    suffix = c("", "_dest")) %>%
    mutate(destBlockID = origBlockID,
           destPlotID = ifelse(is.na(destPlotID), origPlotID, destPlotID),
           turfID = paste0(origPlotID, " ", warming, "N", Nlevel, grazing,  " ", destPlotID)) %>%
    ungroup() %>%
    select(-fence, -rownr) %>%
    # CHANGE PLOTID 23-103 TO 23 AMBIENT, AND 24 TO 24-103 WARMING (wrong turf was transplanted!)
    mutate(warming = ifelse(origSiteID == "Liahovden" & origPlotID == 23, "A", warming),
           destPlotID = ifelse(origSiteID == "Liahovden" & origPlotID == 23, 23, destPlotID),
           turfID = ifelse(origSiteID == "Liahovden" & origPlotID == 23, "23 AN5N 23", turfID),

           warming = ifelse(origSiteID == "Liahovden" & origPlotID == 24, "W", warming),
           destPlotID = ifelse(origSiteID == "Liahovden" & origPlotID == 24, 103, destPlotID),
           turfID = ifelse(origSiteID == "Liahovden" & origPlotID == 24, "24 WN5N 103", turfID)) %>%
    mutate(destSiteID = as.character(destSiteID)) %>%
    mutate(destSiteID = case_when(turfID == "23 AN5N 23" ~ "Liahovden",
                                  turfID == "24 WN5N 103" ~ "Joasete",
                                  TRUE ~ destSiteID)) |>
    left_join(NitrogenDictionary, by = "Nlevel")

  if(csv_output){
    write_csv(threeD_metadata, path)
  }

  threeD_metadata

}
