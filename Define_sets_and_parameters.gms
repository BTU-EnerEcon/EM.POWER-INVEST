*###############################################################################
*
*                        Definition and declaration of parameter
*
*###############################################################################

Sets
country_all      set of countries
hour_all         set of hours
year_all         set of years    /2017,2020,2022,2024,2025,2026,2028,2030,2032,2034,2036,2038,2040,2045,2050,2070/

month            set of months   /m1*m12/
day              set of days     /d1*d365/
i                                /i1*i10000/

fuel_conv        set of conventional fuels
fuel_renew       set of renewable fuels

conv             set of conventional (non-renewable) generation technologies
convgrouped      set of conventional (non-renewable) generation technology groups
renew            set of renewable generation technologies
stor             set of storage technologies

output_configuration_set set for output_configuration    /'#technologies','#countries','#years','#hours','partload','ramping','chp','chp_trimmed','countryefficiency','countryavailability','varomcost','coalphaseout','divestment','futurechp','fuelprice_countryfactor'/

output_performance_set   set for output_performance      /'modelStat','solveStat','resGen','resUsd','etAlg','etSolve','etSolver','numEqu','numVar','ObjVal'/

output_country_hour_set  set for output_country_hour     /'load','load curtailment','export_sum','import_sum',
                                                          'charge','discharge','level','battery_charge','battery_discharge','battery_level','pumpstorage_charge','pumpstorage_discharge','pumpstorage_level'
                                                          'uranium generation','lignite generation','hardcoal generation','gas generation','oil generation',
                                                          'solar generation','wind generation','hydro generation','bioenergy generation','waste generation','otherres generation',
                                                          'renewable curtailment','electricity price',
                                                          'uranium generation (chp)','lignite generation (chp)','hardcoal generation (chp)','gas generation (chp)','oil generation (chp)','bioenergy generation (chp)','waste generation (chp)',
                                                          'co2 emissions','lignite co2','hardcoal co2','gas co2','oil co2','waste co2',
                                                          'uranium avail cap','lignite avail cap','hardcoal avail cap','gas avail cap','oil avail cap','netexport_border' /

output_country_year_set  set for output_country_year
/
*Prices
'base price','peak price','offpeak price',

*Load and export/import
'load','load curtailment','export_sum','import_sum',

*Generation (fuel specific)
'uranium generation','lignite generation','hardcoal generation','gas generation','oil generation',
'solar generation','wind generation','hydro generation','bioenergy generation','waste generation','otherres generation',
'discharge','charge',
'renewable curtailment',

*CHP Generation (fuel specific)
'uranium generation (chp)','lignite generation (chp)','hardcoal generation (chp)','gas generation (chp)','oil generation (chp)',
'bioenergy generation (chp)','waste generation (chp)',

*CO2 production (fuel spcific)
'lignite co2','hardcoal co2','gas co2','oil co2','waste co2',
'co2 emissions',

*Installation (fuel spcific)
'uranium installation','lignite installation','hardcoal installation','gas installation','oil installation',
'solar installation','wind installation','hydro installation','bioenergy installation','waste installation','otherres installation','storage installation',

*Investment (fuel spcific)
'uranium investment','lignite investment','hardcoal investment','gas investment','oil investment',

*Divestment (fuel spcific)
'uranium divestment','lignite divestment','hardcoal divestment','gas divestment','oil divestment',

*Generation (technology specific)
'nuclear_new generation','nuclear_old generation','lignite_new generation','lignite_ccs_new generation','lignite_old generation',
'hardcoal_new generation','hardcoal_ccs_new generation','hardcoal_old generation','ccgt_new generation','ccgt_ccs_new generation','ccgt_old generation',
'gassteam_old generation','ocgt_new generation','ocgt_ccs_new generation','ocgt_old generation','oil_old generation',
'pumpstorage discharge','battery_discharge','pumpstorage charge','battery_charge',

*Installation (technology specific)
'nuclear_new installation','nuclear_old installation','lignite_new installation','lignite_ccs_new installation','lignite_old installation',
'hardcoal_new installation','hardcoal_ccs_new installation','hardcoal_old installation','ccgt_new installation','ccgt_ccs_new installation','ccgt_old installation',
'gassteam_old installation','ocgt_new installation','ocgt_ccs_new installation','ocgt_old installation','oil_old installation',
'pumpstorage installation','battery installation',

*Investment exogenous (technology specific)
'nuclear_old installation exogen','lignite_old installation exogen','hardcoal_old installation exogen',
'ccgt_old installation exogen','gassteam_old installation exogen','ocgt_old installation exogen','oil_old installation exogen',

*Investment (technology specific)
'nuclear_new investment','lignite_new investment','lignite_ccs_new investment','hardcoal_new investment','hardcoal_ccs_new investment',
'ccgt_new investment','ccgt_ccs_new investment','ocgt_new investment','ocgt_ccs_new investment',

*Divestment (technology specific)
'nuclear_new divestment','nuclear_old divestment','lignite_new divestment','lignite_ccs_new divestment','lignite_old divestment',
'hardcoal_new divestment','hardcoal_ccs_new divestment','hardcoal_old divestment','ccgt_new divestment','ccgt_ccs_new divestment','ccgt_old divestment',
'gassteam_old divestment','ocgt_new divestment','ocgt_ccs_new divestment','ocgt_old divestment','oil_old divestment',

*Divestment exogenous (technology specific)
'nuclear_old divestment exogen','lignite_old divestment exogen','hardcoal_old divestment exogen',
'ccgt_old divestment exogen','gassteam_old divestment exogen','ocgt_old divestment exogen','oil_old divestment exogen',

*Other output
'RES_CAP_CONV_NUCLEAR_up.M','carbon price','uranium price','lignite price','hardcoal price','gas price','oil price'
/

output_country_year_conv_set     set for output_country_year_conv
/
'Install','Install exogen','Add','Add exogen','Sub','Sub exogen','Gen','Fuel'
'Revenue','VarCosts','ProfitContribution','MarketValue','Investment costs','Fix costs','ProfitContribution2',
'cvar_full','cvar_min','eff_full','eff_min','SHARE_FULL'/

*subsets
country(country_all)     set of considered countries
renew_disp(renew)        set of dispatchable renewable generation technologies
renew_ndisp(renew)       set of non-dispatchable renewable generation technologies
renew_curt(renew)        set of curtailable renewable generation technologies
renew_ncurt(renew)       set of non-curtailable renewable generation technologies
year(year_all)           set of considered years
hour(year_all,hour_all)  set of considered hours

*mapping
map_convfuel(conv,fuel_conv)             maps conv to fuel
map_convgrouped(conv,convgrouped)        maps conv to convgrouped
map_renewfuel(renew,fuel_renew)          maps renew to fuel
map_hourmonth(year_all,hour_all,month)   maps months to hours
map_hourday(year_all,hour_all,day)       maps days to hours
;

Alias    (country,country2), (conv,conv2), (hour,hour2), (hour_all,hour_all2), (month,month2), (year,year2);


Parameters
*####################################
*excel input

*hourly parameters
capfactor_reservoir_max(year_all,hour_all,country_all)           hourly maximum capacity factor for reservoir feed-in (MWh per MW)
capfactor_reservoir_min(year_all,hour_all,country_all)           hourly minimum capacity factor for reservoir feed-in (MWh per MW)
capfactor_runofriver(year_all,hour_all,country_all)              hourly capacity factor for windoffshore feed-in (MWh per MW)
capfactor_solar(year_all,hour_all,country_all)                   hourly capacity factor for solar feed-in (MWh per MW)
capfactor_windonshore(year_all,hour_all,country_all)             hourly capacity factor for windonshore feed-in (MWh per MW)
capfactor_windoffshore(year_all,hour_all,country_all)            hourly capacity factor for windoffshore feed-in (MWh per MW)
chp_structure(year_all,hour_all,country_all)                     hourly chp production structure (normalized to thousand)
chp_trimmed_structure(year_all,hour_all,country_all)             hourly trimmed chp production structure (normalized to thousand)
load_structure(year_all,hour_all,country_all)                    hourly load structure (normalized to thousand)
peakind(year_all,hour_all,country_all)                           peak indicator (1 if hour is a peak hour)
borderflow(year_all,hour_all,country_all)                        netexport at model borders (MW)

capfactor_solar_lowRES(year_all,hour_all,country_all)            hourly capacity factor for solar feed-in (MWh per MW) for scenario with low RES feed-in in winter
capfactor_windonshore_lowRES(year_all,hour_all,country_all)      hourly capacity factor for windonshore feed-in (MWh per MW) for scenario with low RES feed-in in winter
capfactor_windoffshore_lowRES(year_all,hour_all,country_all)     hourly capacity factor for windoffshore feed-in (MWh per MW) for scenario with low RES feed-in in winter

*scenario parameters
load_year(year_all,country_all)                                  yearly electrcity consumption (GWh)

ntc_year(year_all,country_all,country_all)                       yearly ntc value between two countries (MW)
ntc_year_day(year_all,day,country_all,country_all)               daily ntc value between two countries (MW)
ntc_year_month(year_all,month,country_all,country_all)           monthly ntc value between two countries (MW)
carbonprice_year(year_all)                                       yearly co2 price (EUR per tonne)
carbonprice_month(year_all,month)                                monthly co2 price (EUR per tonne)

*conv parameters
inputdata_conv(conv,*)                                           excel input table for conv
cap_conv_add_forbidden(country_all,conv)                         indicates whether additional installations of that technology is forbidden (=1) or not (=0)
cap_convgrouped_install_up(country_all,convgrouped)              upper bound for installed capacity (MW)
cap_conv_install_old(country_all,conv,year_all)                  installed capacity of existing plants (MW)
cap_conv_install_old_phaseout(country_all,conv,year_all)         installed capacity of existing plants (MW)
eff_conv_old(country_all,conv,year_all)                          efficiency of existing plants (%)
eff_conv_old_phaseout(country_all,conv,year_all)                 efficiency of existing plants (%)
gen_conv_old(country_all,conv,year_all)                          generation of existing plants (GWh) for calibration and validation
gen_CHP_conv_old(country_all,conv,year_all,*)                    chp generation (heat and elec) of existing plants (GWh) for calibration
fuelprice_conv_year(year_all,fuel_conv)                          yearly fuel price (EUR per MWh_th)
fuelprice_conv_year_day(year_all,day,country_all,fuel_conv)      daily fuel price (EUR per MWh_th)
carboncontent_conv(fuel_conv)                                    emission factor (tCO2 per MWh_th)
transportcost_conv(fuel_conv)                                    transport cost (EUR per MWh_th)

avail_month_structure(year_all,month,country_all)
avail_month_structure_nuclear(year_all,month,country_all)
avail_month_structure_lignite(year_all,month,country_all)
avail_month_structure_hardcoal(year_all,month,country_all)
avail_month_structure_gas(year_all,month,country_all)
fuelprice_countryfactor(country_all,year_all,fuel_conv)

outages_conv(*,conv,year_all,country_all)                        country-specific yearly outages (%)
plannedoutages_conv(country_all,conv,year_all)                   country-specific planned outages (%)
forcedoutages_conv(country_all,conv,year_all)                    country-specific forced outages (%)
availability_conv(country_all,conv,year_all,hour_all)                country-specific availability factor (%)

*renew paramters
inputdata_renew(renew,*)                                             excel input table for renew
covernight_renew(renew,year_all)                                     overnight investment cost (€ per kW)
cap_renew_install_exogen_year(renew,year_all,country_all)            capacity installed exogenously (MW)

gen_renew_all_year(renew,year_all,country_all)                   renewable generation from all producers (GWh)
gen_renew_main_year(renew,year_all,country_all)                  renewable generation from main producers (GWh)
gen_CHP_renew_all(*,renew,year_all,country_all)                  renewable chp generation from all producers (GWh)
gen_CHP_renew_main(*,renew,year_all,country_all)                 renewable chp generation from main producers (GWh)

fuelprice_renew(year_all,fuel_renew)                                     fuel price (EUR per MWh_th)
carboncontent_renew(fuel_renew)                                          emission factor (tCO2 per MWh_th)
gen_renew_structure_monthly_exogen(renew,year_all,month,country_all)     monthly generation structure for renewables (%)


*stor parameters
inputdata_stor(stor,*)                                                   excel input table for stor
covernight_kW_stor(stor,year_all)                                        overnight investment cost for storage turbine (€ per kW)
covernight_kWh_stor(stor,year_all)                                       overnight investment cost for storage (€ per kWh)
storageduration(stor,country_all)                                        storage duration (hours)
discharge_to_charge_ratio(stor,country_all)                              discharge (turbine) to charge (pump) ratio (-)
cap_stor_install_exogen_year(stor,year_all,country_all)                  capacity installed exogenously (MW)
gen_stor_exogen(stor,year_all,country_all)                               generation exogenously (GWh) for calibration and validation

*other parameters
country_collection(country_all,*)
discount_factor(year_all)                discount factor
energy_weighting_factor(year_all)        energy weighting factor
money_weighting_factor(year_all)         money weighting factor
emissionreduction(year_all)              emission reduction (% of year '2017')

*####################################
*calculated input

*yearly parameters
carbonprice(country_all,year_all)                        considered co2 price path (EUR per tonne)
carbonprice_hour(country_all,year_all,hour_all)

load(country_all,year_all,hour_all)                      considered load (MWh per h)
ntc(country_all,country_all,year_all)                    considered ntc path (MW)
ntc_hour(country_all,country_all,year_all,hour_all)      considered ntc path (MW)
emission
netexport_border(country_all,year_all,hour_all)          netexport at model borders (MW)

*conv parameters
avail_conv(country_all,conv,year_all,hour_all)           average hourly availability
avail_conv_month(country_all,conv,year_all,month)        average monthly availability
correction_factor_avail_conv_month(country_all,conv)
cap_conv_install_up(country_all,conv)                    upper bound for installed capacity (MW)
cap_conv_sub_old(country_all,conv,year_all)              capacity decommissioned (MW)
cfix_conv(conv,year_all)                                 yearly fix cost (€ per MW)
cinv_conv(conv,year_all)                                 annual investment cost (€ per MW and year)
convyear_lo(conv)                                        first investment year
convyear_up(conv)                                        last investment year
cramp_conv(country_all,conv,year_all)                    ramping cost (€ per MW)

cvar_conv_full(country_all,conv,year_all)        variable generation cost at full capacity (€ per MWh)
cvar_conv_min(country_all,conv,year_all)         variable generation cost at minimum capacity (€ per MWh)
cvar_conv_avg(country_all,conv,year_all)         variable generation cost at average capacity (€ per MWh)

cvar_conv_full_hour(country_all,conv,year_all,hour_all)        variable generation cost at full capacity (€ per MWh)
cvar_conv_min_hour(country_all,conv,year_all,hour_all)         variable generation cost at minimum capacity (€ per MWh)
cvar_conv_avg_hour(country_all,conv,year_all,hour_all)         variable generation cost at average capacity (€ per MWh)


efficiency_conv_full(country_all,conv,year_all)  efficiency at full capacity (%)
efficiency_conv_min(country_all,conv,year_all)   efficiency at minimum capacity (%)
efficiency_conv_avg(country_all,conv,year_all)   efficiency at average capacity (%)

emf_conv_full(country_all,conv,year_all)         emission factor at full capacity (tCO2 per MWh_el)
emf_conv_min(country_all,conv,year_all)          emission factor at minimum capacity (tCO2 per MWh_el)
emf_conv_avg(country_all,conv,year_all)          emission factor at average capacity (tCO2 per MWh_el)
fuelprice_conv(country_all,fuel_conv,year_all)   considered hourly fuel price path (EUR per MWh_th)
fuelprice_conv_hour(country_all,fuel_conv,year_all,hour_all)
gmin_conv(conv)                                  minimum generation level

cap_conv_add_up(country_all,conv,year_all)
cap_conv_install_up(country_all,conv)
load_max(country_all)

cap_conv_install_L(country_all,conv,year_all)
flow_L(year_all,hour_all,country_all,country_all)


*renew paramters
availability_renew(country_all,renew,year_all,hour_all)  availability of dispatchable renewables
cap_renew_add_exogen(country_all,renew,year_all)         capacity added (MW)
cap_renew_install_exogen(country_all,renew,year_all)     capacity installed exogenously (MW)
cap_renew_install_exogen2(country_all,renew,year_all)    capacity installed exogenously (MW)
capfactor_renew_max(country_all,renew,year_all,hour_all) maximum capacity factor for renewables
capfactor_renew_min(country_all,renew,year_all,hour_all) minimum capacity factor for renewables
cfix_renew(renew,year_all)                               yearly fix cost (€ per MW)
cinv_renew(renew,year_all)                               annual investment cost (€ per MW and year)
cvar_renew(country_all,renew,year_all)                   variable generation cost (€ per MWh)
cvar_renew_hour(country_all,renew,year_all,hour_all)
efficiency_renew(renew)                                  efficiency (%)
emf_renew(renew)                                         emission factor (tCO2 per MWh_el)
emf_renew_countryyear(country_all,renew,year_all)
flh_reservoir(country_all)                               full load hours of reservoir (hours per year)
gen_renew_exogen(country_all,renew,year_all)             generation exogenously (GWh)
gen_renew_exogen2(country_all,renew,year_all)
gen_renew_structure_monthly(country_all,renew,year_all,month)
fuelpotential_renew(country_all,renew,year_all)
ctransport(fuel_conv)

*stor parameters
avail_stor(stor)                                         average yearly availability
cap_stor_install_exogen(country_all,stor,year_all)       capacity installed exogenously (MW)
cfix_stor(stor,year_all)                                 yearly fix cost (€ per MW)
cinv_MW_stor(stor,year_all)                              annual investment cost for storage turbine (€ per MW and year)
cinv_MWh_stor(stor,year_all)                             annual investment cost for storage (€ per MWh and year)
efficiency_stor(stor)                                    efficiency (%)
duration_stor(country_all,stor)                          duration to charge the storage (h)
discharge_to_charge_ratio_stor(country_all,stor)         discharge (turbine) to charge (pump) ratio (-)

*other parameters
ccurt_load_year(year_all)
ccurt_renew_year(year_all)
emissioncap(year_all)                                    yearly emission cap (tCO2)

*paramters for chp calibration
chp_structure_hour(country_all,year_all,hour_all)        hourly chp production structure
flh_chp_conv(country_all,conv)                           full load hours of chp generation
flh_chp_renew(country_all,renew)                         full load hours of chp generation


indicator_divestment_country(country_all)
indicator_partload_country(country_all)
indicator_ramping_country(country_all)

indicator_loadcurt(country_all)

first_hour(year_all)
last_hour(year_all)
step_hour(year_all,hour_all)
n

*Parameters for calculation of monthly availability structure
max_monthlyresload_norm(country_all,year_all,month)
availability_conv_planned(country_all,conv,year_all,month)
sum_availability_conv_planned(country_all,conv,year_all)
availability_renew_month(country_all,renew,year_all,month)
sum_availability_renew_month(country_all,renew,year_all)

*output
output_country_hour(country_all,year_all,hour_all,output_country_hour_set)
output_country_hour_conv(country_all,conv,year_all,hour_all,*)

output_country_year(country_all,year_all,output_country_year_set)
output_country_year_conv(country_all,conv,year_all,output_country_year_conv_set)
output_year(year_all,output_country_year_set)
output_country_conv(country_all,conv,*)
output_configuration(output_configuration_set,*)
output_performance(output_performance_set,*)


output_vc_full_conv(country_all,year_all,hour_all,conv)
output_vc_min_conv(country_all,year_all,hour_all,conv)
output_vc_avg_conv(country_all,year_all,hour_all,conv)
output_vc_renew(country_all,year_all,hour_all,renew)

output_availcap_conv(country_all,year_all,hour_all,conv)
output_availcap_renew(country_all,year_all,hour_all,renew)

CAP_CONV_RTO_L(country_all,year_all,hour_all,conv)
CAP_CONV_UP_L(country_all,year_all,hour_all,conv)
CAP_CONV_DOWN_L(country_all,year_all,hour_all,conv)
GEN_CONV_L(country_all,year_all,hour_all,conv)
GEN_CONV_FULL_L(country_all,year_all,hour_all,conv)
GEN_CONV_MIN_L(country_all,year_all,hour_all,conv)
GEN_CONV_ELEC_CHP_L(country_all,year_all,hour_all,conv)

SHARE_FULL_country(country_all,year_all,conv)
SHARE_MIN_country(country_all,year_all,conv)
SHARE_FULL(year_all,conv)
SHARE_MIN(year_all,conv)

output_DE_hour(year_all,hour_all,output_country_hour_set)
output_DE_year(year_all,output_country_year_set)
output_DE_export_hour(year_all,hour_all,*,country_all)
output_DE_export_year(year_all,*,country_all)
output_DE_hour_conv(conv,hour_all,year_all,*)
output_DE_year_conv(year_all,conv,output_country_year_conv_set)

output_country_year_conv(country_all,conv,year_all,output_country_year_conv_set)

output_AT_hour(year_all,hour_all,output_country_hour_set)
output_AT_year(year_all,output_country_year_set)
output_AT_export_hour(year_all,hour_all,*,country_all)
output_AT_export_year(year_all,*,country_all)

output_BALT_hour(year_all,hour_all,output_country_hour_set)
output_BALT_year(year_all,output_country_year_set)
output_BALT_export_hour(year_all,hour_all,*,country_all)
output_BALT_export_year(year_all,*,country_all)

output_BE_hour(year_all,hour_all,output_country_hour_set)
output_BE_year(year_all,output_country_year_set)
output_BE_export_hour(year_all,hour_all,*,country_all)
output_BE_export_year(year_all,*,country_all)

output_BG_hour(year_all,hour_all,output_country_hour_set)
output_BG_year(year_all,output_country_year_set)
output_BG_export_hour(year_all,hour_all,*,country_all)
output_BG_export_year(year_all,*,country_all)

output_CH_hour(year_all,hour_all,output_country_hour_set)
output_CH_year(year_all,output_country_year_set)
output_CH_export_hour(year_all,hour_all,*,country_all)
output_CH_export_year(year_all,*,country_all)

output_CZ_hour(year_all,hour_all,output_country_hour_set)
output_CZ_year(year_all,output_country_year_set)
output_CZ_export_hour(year_all,hour_all,*,country_all)
output_CZ_export_year(year_all,*,country_all)

output_DK_hour(year_all,hour_all,output_country_hour_set)
output_DK_year(year_all,output_country_year_set)
output_DK_export_hour(year_all,hour_all,*,country_all)
output_DK_export_year(year_all,*,country_all)

output_FI_hour(year_all,hour_all,output_country_hour_set)
output_FI_year(year_all,output_country_year_set)
output_FI_export_hour(year_all,hour_all,*,country_all)
output_FI_export_year(year_all,*,country_all)

output_FR_hour(year_all,hour_all,output_country_hour_set)
output_FR_year(year_all,output_country_year_set)
output_FR_export_hour(year_all,hour_all,*,country_all)
output_FR_export_year(year_all,*,country_all)

output_GR_hour(year_all,hour_all,output_country_hour_set)
output_GR_year(year_all,output_country_year_set)
output_GR_export_hour(year_all,hour_all,*,country_all)
output_GR_export_year(year_all,*,country_all)

output_HR_hour(year_all,hour_all,output_country_hour_set)
output_HR_year(year_all,output_country_year_set)
output_HR_export_hour(year_all,hour_all,*,country_all)
output_HR_export_year(year_all,*,country_all)

output_HU_hour(year_all,hour_all,output_country_hour_set)
output_HU_year(year_all,output_country_year_set)
output_HU_export_hour(year_all,hour_all,*,country_all)
output_HU_export_year(year_all,*,country_all)

output_IBER_hour(year_all,hour_all,output_country_hour_set)
output_IBER_year(year_all,output_country_year_set)
output_IBER_export_hour(year_all,hour_all,*,country_all)
output_IBER_export_year(year_all,*,country_all)

output_IE_hour(year_all,hour_all,output_country_hour_set)
output_IE_year(year_all,output_country_year_set)
output_IE_export_hour(year_all,hour_all,*,country_all)
output_IE_export_year(year_all,*,country_all)

output_IT_hour(year_all,hour_all,output_country_hour_set)
output_IT_year(year_all,output_country_year_set)
output_IT_export_hour(year_all,hour_all,*,country_all)
output_IT_export_year(year_all,*,country_all)

output_MT_hour(year_all,hour_all,output_country_hour_set)
output_MT_year(year_all,output_country_year_set)
output_MT_export_hour(year_all,hour_all,*,country_all)
output_MT_export_year(year_all,*,country_all)

output_NL_hour(year_all,hour_all,output_country_hour_set)
output_NL_year(year_all,output_country_year_set)
output_NL_export_hour(year_all,hour_all,*,country_all)
output_NL_export_year(year_all,*,country_all)

output_NO_hour(year_all,hour_all,output_country_hour_set)
output_NO_year(year_all,output_country_year_set)
output_NO_export_hour(year_all,hour_all,*,country_all)
output_NO_export_year(year_all,*,country_all)

output_PL_hour(year_all,hour_all,output_country_hour_set)
output_PL_year(year_all,output_country_year_set)
output_PL_export_hour(year_all,hour_all,*,country_all)
output_PL_export_year(year_all,*,country_all)

output_RO_hour(year_all,hour_all,output_country_hour_set)
output_RO_year(year_all,output_country_year_set)
output_RO_export_hour(year_all,hour_all,*,country_all)
output_RO_export_year(year_all,*,country_all)

output_SE_hour(year_all,hour_all,output_country_hour_set)
output_SE_year(year_all,output_country_year_set)
output_SE_export_hour(year_all,hour_all,*,country_all)
output_SE_export_year(year_all,*,country_all)

output_SI_hour(year_all,hour_all,output_country_hour_set)
output_SI_year(year_all,output_country_year_set)
output_SI_export_hour(year_all,hour_all,*,country_all)
output_SI_export_year(year_all,*,country_all)

output_SK_hour(year_all,hour_all,output_country_hour_set)
output_SK_year(year_all,output_country_year_set)
output_SK_export_hour(year_all,hour_all,*,country_all)
output_SK_export_year(year_all,*,country_all)

output_UK_hour(year_all,hour_all,output_country_hour_set)
output_UK_year(year_all,output_country_year_set)
output_UK_export_hour(year_all,hour_all,*,country_all)
output_UK_export_year(year_all,*,country_all)
;
