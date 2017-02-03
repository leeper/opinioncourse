* Download data from: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/22892

use "Klar_AJPS_4.dta"

* analysis focuses only on Democrats
drop if pid > 3

* treatment variable
tab condition_number

gen treatment = .
replace treatment = 1 if condition_number == 2
replace treatment = 4 if condition_number == 3
replace treatment = 2 if condition_number == 4
replace treatment = 5 if condition_number == 5
replace treatment = 3 if condition_number == 6
replace treatment = 6 if condition_number == 7

gen ambivalent = .
replace ambivalent = 1 if treatment < 4
replace ambivalent = 0 if treatment > 3

gen group_type = .
* no group
replace group_type = 0 if treatment == 1 | treatment == 4
* homogeneous
replace group_type = 1 if treatment == 2 | treatment == 5 
* heterogeneous
replace group_type = 2 if treatment == 3 | treatment == 6 


* Figure 1
tabstat energypriority, by(ambivalent)
tabstat healthpriority, by(ambivalent)
** regression version
reg energypriority ambivalent
reg healthpriority ambivalent

* Figure 2
tabstat oil, by(ambivalent)
tabstat alternative, by(ambivalent)
tabstat competition, by(ambivalent)
tabstat subsidies, by(ambivalent)
** regression version
reg oil ambivalent
reg alternative ambivalent
reg competition ambivalent
reg subsidies ambivalent

* Figure 3
tabstat energypriority, by(group_type)
tabstat healthpriority, by(group_type)
** regression version
reg energypriority i.group_type
reg healthpriority i.group_type

* Figure 4
tabstat oil, by(group_type)
tabstat alternative, by(group_type)
tabstat competition, by(group_type)
tabstat subsidies, by(group_type)
** regression version
reg oil i.group_type
reg alternative i.group_type
reg competition i.group_type
reg subsidies i.group_type

* Figure 5
tabstat energypriority, by(treatment)
tabstat healthpriority, by(treatment)
** regression version
reg energypriority i.treatment if treatment != 1 & treatment != 4
reg healthpriority i.treatment if treatment != 1 & treatment != 4

* Figure 6
tabstat oil, by(treatment)
tabstat competition, by(treatment)
** regression version
reg oil i.treatment if treatment != 1 & treatment != 4
reg alternative i.treatment if treatment != 1 & treatment != 4

* Figure 7
tabstat energygroup, by(ambivalent)
tabstat healthgroup, by(ambivalent)
** regression version
reg energygroup i.ambivalent
reg healthgroup i.ambivalent

* Figure 8
tabstat energygroup, by(group_type)
tabstat healthgroup, by(group_type)
** regression version
reg energygroup i.group_type
reg healthgroup i.group_type

* Figure 9
tabstat energygroup, by(treatment)
tabstat healthgroup, by(treatment)
** regression version
reg energygroup i.treatment if treatment != 1 & treatment != 4
reg healthgroup i.treatment if treatment != 1 & treatment != 4
