PPCRdata %>% dplyr::select(age,bmi,sex,pain,p_intensity,sleepquality,sleepproblems,depression,
                           alcohol,fracture,cancer,diabetes,dementia,arthritis,
                           heartdisease,lungdisease) %>% tbl_summary(
                                   statistic = list(
                                           all_continuous() ~ "{mean} ({sd})",
                                           all_categorical() ~ "{n} ({p}%)")
                           ) %>%
        modify_header(label = "**Variable**") %>%
        modify_caption("Subjects baseline characteristics") %>%
        bold_labels() %>% as_gt() %>% gt::gtsave(filename = "table1.png")

model0 %>% tbl_regression(exponentiate = TRUE, conf.int = TRUE) %>% as_gt() %>%
        gt::gtsave(filename = "unadjusted pain ~ sleepquality.png")

model0Tidy %>% ggplot (aes(Odds.Ratio, term, xmin = conf.low,
                           xmax = conf.high, height = 0)) +
        ## inserting a point for the odds ratio
        geom_point() +
        ## drawing a line at the 1 to improve readability
        geom_vline(xintercept = 1, lty = 4) +
        ## drawing an horizontal line to represent the 
        ## confidence interval
        geom_errorbarh() +
        ## reordering the categorical variables in the
        ## y-axis to improve readability
        ## also removing the intercept, as it's not 
        ## relevant for interpretation
        scale_y_discrete(limits = c('sleepquality.L',
                                    'sleepquality.Q',
                                    'sleepquality.C',
                                    'sleepquality^4')) -> plotmodel0

ggsave(filename = "unadjusted pain ~ sleepquality plot.png",
               plot = plotmodel0)

model3 %>% tbl_regression(exponentiate = TRUE, conf.int = TRUE) %>% as_gt() %>%
        gt::gtsave(filename = "adjusted pain ~ sleepquality.png")

model3Tidy %>% ggplot (aes(Odds.Ratio, term, xmin = conf.low,
                           xmax = conf.high, height = 0)) +
        ## inserting a point for the odds ratio
        geom_point() +
        ## drawing a line at the 1 to improve readability
        geom_vline(xintercept = 1, lty = 4) +
        ## drawing an horizontal line to represent the 
        ## confidence interval
        geom_errorbarh() -> plotmodel3

ggsave(filename = "adjusted pain ~ sleepquality plot.png",
       plot = plotmodel3)

model5 %>% tbl_regression(exponentiate = TRUE, conf.int = TRUE) %>% as_gt() %>%
        gt::gtsave(filename = "adjusted sleepquality ~ pain.png")

model5OddsRatio %>% ggplot (aes(OR, term, xmin = conf.low,
                                xmax = conf.high, height = 0)) +
        geom_point() +
        geom_vline(xintercept = 1, lty = 4) +
        geom_errorbarh() -> plotmodel5

ggsave(filename = "adjusted sleepquality ~ pain plot.png",
       plot = plotmodel5)

model6 %>% tbl_regression(exponentiate = TRUE, conf.int = TRUE) %>% as_gt() %>%
        gt::gtsave(filename = "unadjusted sleepquality ~ pain.png")

model6OddsRatio %>% ggplot (aes(OR, term, xmin = conf.low,
                                xmax = conf.high, height = 0)) +
        geom_point() +
        geom_vline(xintercept = 1, lty = 4) +
        geom_errorbarh() -> plotmodel6

ggsave(filename = "unadjusted sleepquality ~ pain plot.png",
       plot = plotmodel6)