$offOrder

$Include Define_sets_and_parameters.gms

Scalars
interest_rate                            /0.09/
discount_rate                            /0.02/
ccurt_renew                              /0/
ccurt_load                               /10000/
grid_loss                                /0.01/
indicator_partload                       /0/
indicator_ramping                        /0/
indicator_chp                            /1/
indicator_chp_trimmed                    /1/
indicator_countryefficiency              /1/
indicator_countryavail                   /1/
indicator_varomcost                      /1/
indicator_coalphaseout                   /1/
indicator_divestment                     /1/
indicator_futurechp                      /1/
indicator_fuelprice_countryfactor        /0/
indicator_dailyntc                       /1/
;

Parameter yearnumber(year_all);
yearnumber('2017') = 2017;
yearnumber('2020') = 2020;
yearnumber('2022') = 2022;
yearnumber('2024') = 2024;
yearnumber('2025') = 2025;
yearnumber('2026') = 2026;
yearnumber('2028') = 2028;
yearnumber('2030') = 2030;
yearnumber('2032') = 2032;
yearnumber('2034') = 2034;
yearnumber('2036') = 2036;
yearnumber('2038') = 2038;
yearnumber('2040') = 2040;
yearnumber('2045') = 2045;
yearnumber('2050') = 2050;
yearnumber('2070') = 2070;

$onUNDF
$gdxin Input\Input_h8760.gdx
$load country_all
$load hour_all
$load map_hourmonth
$gdxin
$offUNDF
*Display country_all;

$onUNDF
$gdxin Input\Input_hour_reduced_Every25hour_2ExtremeDays.gdx
$load hour
$load load_structure
$load capfactor_solar
$load capfactor_windonshore
$load capfactor_windoffshore
$load capfactor_runofriver
$load capfactor_reservoir_max
$load capfactor_reservoir_min
$load chp_structure
$load chp_trimmed_structure
$load peakind
$load borderflow
$load map_hourday
$load first_hour
$load last_hour
$load step_hour
$gdxin
$offUNDF

*yearly data
$onUNDF
$gdxin Input\Input_yearly_scenario3.gdx
*$gdxin Input\Input_yearly_scenarios1and2.gdx

$load fuel_conv
$load fuel_renew
$load conv
$load convgrouped
$load renew
$load stor
$load map_convfuel
$load map_convgrouped
$load map_renewfuel
$load load_year
$load ntc_year
$load ntc_year_month
$load ntc_year_day
$load carbonprice_year
$load country_collection
$load inputdata_conv
$load cap_conv_add_forbidden
$load cap_conv_install_old
$load cap_conv_install_old_phaseout
$load eff_conv_old
$load eff_conv_old_phaseout
$load gen_conv_old
$load gen_CHP_conv_old
$load outages_conv
$load avail_month_structure_nuclear
$load carboncontent_conv
$load fuelprice_conv_year
$load fuelprice_countryfactor
$load inputdata_renew
$load covernight_renew
$load cap_renew_install_exogen_year
$load gen_renew_all_year
$load gen_renew_main_year
$load gen_renew_structure_monthly_exogen
$load gen_CHP_renew_all
$load gen_CHP_renew_main
$load fuelprice_renew
$load carboncontent_renew
$load inputdata_stor
$load covernight_kW_stor
$load covernight_kWh_stor
$load storageduration
$load discharge_to_charge_ratio
$load cap_stor_install_exogen_year
$load gen_stor_exogen
$gdxin
$offUNDF

*monthly availability structure
$onUNDF
$gdxin Input\Input_MonthlyAvailabilityStructure.gdx
$load availability_conv_planned
$load availability_renew_month
$gdxin
$offUNDF

Option Profile=2;
Option Profiletol=0.01;
Option limrow=10;
Option limcol=10;
Option reslim=5000000;
Option solvelink=0;
Option LP=cplex;

*############################################################################
*
*        stage 1:
*        - investment and dispatch for Europe
*        - without part-load and startup costs
*        - lower hourly resolution (representative hours)
*
*############################################################################

$Include Model.gms

$Include Declare_sets_and_parameters.gms

Investment.bratio = 1;
Dispatch.bratio = 1;

indicator_partload = 0;
indicator_ramping = 0;

indicator_partload_country(country) = indicator_partload;
indicator_ramping_country(country) = indicator_ramping;

*##################################
* Limitation of solution space

load_max(country) = smax((hour_all,year)$(hour(year,hour_all)), load(country,year,hour_all));

Loop(convgrouped,
   Loop(conv$( map_convgrouped(conv,convgrouped) AND ( convyear_lo(conv) ge 2020 ) ),
      cap_conv_add_up(country,conv,year) = load_max(country)*1.5;
   );
);

*investment in coal and ccs is allowed
cap_conv_add_forbidden(country,'lignite_ccs_new') = 0;
cap_conv_add_forbidden(country,'hardcoal_ccs_new') = 0;
cap_conv_add_forbidden(country,'ccgt_ccs_new') = 0;
cap_conv_add_forbidden(country,'ocgt_ccs_new') = 0;
cap_conv_add_forbidden(country,'lignite_new') = 0;
cap_conv_add_forbidden(country,'hardcoal_new') = 0;

cap_conv_install_up(country,conv)$(convyear_lo(conv) lt 2020 ) = smax(year, cap_conv_install_old(country,conv,year));
cap_conv_install_up(country,conv)$(convyear_lo(conv) ge 2020 ) = 0$(cap_conv_add_forbidden(country,conv) eq 1) + INF$(cap_conv_add_forbidden(country,conv) eq 0);
*Display cap_conv_add_up,cap_conv_install_up;

indicator_loadcurt(country) = 0;

Investment.optfile=1;

Solve Investment using LP minimizing COST;

*Statistcs for stage 1
output_performance('modelStat','run1') = Investment.modelStat;
output_performance('solveStat','run1') = Investment.solveStat;
output_performance('resGen','run1') = Investment.resGen;
output_performance('resUsd','run1') = Investment.resUsd;
output_performance('etAlg','run1') = Investment.etAlg;
output_performance('etSolve','run1') = Investment.etSolve;
output_performance('etSolver','run1') = Investment.etSolver;
output_performance('numEqu','run1') = Investment.numEqu;
output_performance('numVar','run1') = Investment.numVar;
output_performance('ObjVal','run1') = Investment.ObjVal;

output_configuration('#technologies','run1') = sum(conv$( convyear_lo(conv) le ( sum(year$(ord(year) eq card(year)), yearnumber(year)) )  ), 1);
output_configuration('#countries','run1') = card(country);
output_configuration('#years','run1') = sum(year, 1);
output_configuration('#hours','run1') = sum(hour_all$(hour('2020',hour_all)), 1);
output_configuration('partload','run1') = indicator_partload + EPS;
output_configuration('ramping','run1') = indicator_ramping + EPS;
output_configuration('chp','run1') = indicator_chp + EPS;
output_configuration('chp_trimmed','run1') = indicator_chp_trimmed + EPS;
output_configuration('countryefficiency','run1') = indicator_countryefficiency + EPS;
output_configuration('countryavailability','run1') = indicator_countryavail + EPS;
output_configuration('varomcost','run1') = indicator_varomcost + EPS;
output_configuration('coalphaseout','run1') = indicator_coalphaseout + EPS;
output_configuration('divestment','run1') = indicator_divestment + EPS;
output_configuration('futurechp','run1') = indicator_futurechp + EPS;
output_configuration('fuelprice_countryfactor','run1') = indicator_fuelprice_countryfactor + EPS;

$Include Output_declaration.gms

$onecho > Output\Output_all_stage1.tmp
epsout = 0
par=output_year                  rng=year!A4                     rdim=1  cdim=1
par=output_DE_year               rng=DE_year!A4                  rdim=1  cdim=1
par=output_DE_hour               rng=DE_hour!A4                  rdim=2  cdim=1
par=output_DE_export_year        rng=DE_export_year!A4           rdim=2  cdim=1
par=output_DE_export_hour        rng=DE_export_hour!A4           rdim=2  cdim=2
par=output_NL_year               rng=NL_year!A4                  rdim=1  cdim=1
par=output_NL_hour               rng=NL_hour!A4                  rdim=2  cdim=1
par=output_NL_export_year        rng=NL_export_year!A4           rdim=2  cdim=1
par=output_NL_export_hour        rng=NL_export_hour!A4           rdim=2  cdim=2
par=output_FR_year               rng=FR_year!A4                  rdim=1  cdim=1
par=output_FR_hour               rng=FR_hour!A4                  rdim=2  cdim=1
par=output_FR_export_year        rng=FR_export_year!A4           rdim=2  cdim=1
par=output_FR_export_hour        rng=FR_export_hour!A4           rdim=2  cdim=2
$offecho

put_utility 'gdxout' / 'Output\Output_all_stage1';
execute_unload output_year,output_DE_year,output_DE_hour,output_DE_export_year,output_DE_export_hour,
               output_NL_year,output_NL_hour,output_NL_export_year,output_NL_export_hour,
               output_FR_year,output_FR_hour,output_FR_export_year,output_FR_export_hour;

put_utility 'exec' /'gdxxrw.exe I=Output\Output_all_stage1.gdx O=Output\3stage\Output_all_stage1.xlsx @Output\Output_all_stage1.tmp';

*############################################################################
*
*        stage 2:
*        - dispatch for Europe
*        - without part-load and startup costs
*        - high hourly resolution
*
*############################################################################

hour(year_all,hour_all) = NO;
Option Clear = load;
Option Clear = netexport_border;
Option Clear = availability_conv;
Option Clear = chp_structure_hour;
Option Clear = availability_renew;
Option Clear = capfactor_renew_max;
Option Clear = capfactor_renew_min;
Option Clear = ntc_hour;

Option Clear = output_DE_hour;
Option Clear = output_AT_hour;
Option Clear = output_BE_hour;
Option Clear = output_CH_hour;
Option Clear = output_CZ_hour;
Option Clear = output_DK_hour;
Option Clear = output_FR_hour;
Option Clear = output_NL_hour;
Option Clear = output_PL_hour;
Option Clear = output_SE_hour;

Option Clear = output_DE_export_hour;
Option Clear = output_AT_export_hour;
Option Clear = output_BE_export_hour;
Option Clear = output_CH_export_hour;
Option Clear = output_CZ_export_hour;
Option Clear = output_DK_export_hour;
Option Clear = output_FR_export_hour;
Option Clear = output_NL_export_hour;
Option Clear = output_PL_export_hour;
Option Clear = output_SE_export_hour;

Option Clear = output_BALT_hour;
Option Clear = output_BG_hour;
Option Clear = output_FI_hour;
Option Clear = output_GR_hour;
Option Clear = output_HR_hour;
Option Clear = output_HU_hour;
Option Clear = output_IBER_hour;
Option Clear = output_IE_hour;
Option Clear = output_IT_hour;
Option Clear = output_MT_hour;
Option Clear = output_NO_hour;
Option Clear = output_RO_hour;
Option Clear = output_SI_hour;
Option Clear = output_SK_hour;
Option Clear = output_UK_hour;

Option Clear = output_BALT_export_hour;
Option Clear = output_BG_export_hour;
Option Clear = output_FI_export_hour;
Option Clear = output_GR_export_hour;
Option Clear = output_HR_export_hour;
Option Clear = output_HU_export_hour;
Option Clear = output_IBER_export_hour;
Option Clear = output_IE_export_hour;
Option Clear = output_IT_export_hour;
Option Clear = output_MT_export_hour;
Option Clear = output_NO_export_hour;
Option Clear = output_RO_export_hour;
Option Clear = output_SI_export_hour;
Option Clear = output_SK_export_hour;
Option Clear = output_UK_export_hour;

Option Clear = output_DE_hour_conv;

*Load hourly data in higher hourly resolution
put_utility 'gdxin' / 'Input\Input_h4380.gdx';

execute_load load_structure,capfactor_reservoir_max,capfactor_reservoir_min,capfactor_runofriver,capfactor_solar,capfactor_windonshore,
             capfactor_windoffshore,chp_structure,chp_trimmed_structure,peakind,borderflow,map_hourmonth,map_hourday;

$Include Declare_sets_and_parameters_h4380.gms

*Display ntc,ntc_hour;

*Fix investment and divestment decisions => dispatch problem
cap_conv_install_L(country,conv,year) = CAP_CONV_INSTALL.L(country,conv,year);

indicator_loadcurt(country) = 1;
Dispatch.optfile=1;

Solve Dispatch using LP minimizing COST;

flow_L(year,hour_all,country,country2)$(hour(year,hour_all) AND (ntc(country,country2,year) + ntc(country2,country,year) gt 0)) = FLOW.L(country,country2,year,hour_all) + EPS;


output_AT_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('AT',country2,year) gt 0)) = FLOW.L('AT',country2,year,hour_all) + EPS;
output_AT_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'AT',year) gt 0)) = FLOW.L(country2,'AT',year,hour_all) + EPS;


*Statistcs for stage 2
output_performance('modelStat','run2') = Dispatch.modelStat;
output_performance('solveStat','run2') = Dispatch.solveStat;
output_performance('resGen','run2') = Dispatch.resGen;
output_performance('resUsd','run2') = Dispatch.resUsd;
output_performance('etAlg','run2') = Dispatch.etAlg;
output_performance('etSolve','run2') = Dispatch.etSolve;
output_performance('etSolver','run2') = Dispatch.etSolver;
output_performance('numEqu','run2') = Dispatch.numEqu;
output_performance('numVar','run2') = Dispatch.numVar;
output_performance('ObjVal','run2') = Dispatch.ObjVal;

output_configuration('#technologies','run2') = sum(conv$( convyear_lo(conv) le ( sum(year$(ord(year) eq card(year)), yearnumber(year)) )  ), 1);
output_configuration('#countries','run2') = card(country);
output_configuration('#years','run2') = sum(year, 1);
output_configuration('#hours','run2') = sum(hour_all$(hour('2020',hour_all)), 1);
output_configuration('partload','run2') = indicator_partload + EPS;
output_configuration('ramping','run2') = indicator_ramping + EPS;
output_configuration('chp','run2') = indicator_chp + EPS;
output_configuration('chp_trimmed','run2') = indicator_chp_trimmed + EPS;
output_configuration('countryefficiency','run2') = indicator_countryefficiency + EPS;
output_configuration('countryavailability','run2') = indicator_countryavail + EPS;
output_configuration('varomcost','run2') = indicator_varomcost + EPS;
output_configuration('coalphaseout','run2') = indicator_coalphaseout + EPS;
output_configuration('divestment','run2') = indicator_divestment + EPS;
output_configuration('futurechp','run2') = indicator_futurechp + EPS;
output_configuration('fuelprice_countryfactor','run2') = indicator_fuelprice_countryfactor + EPS;

*Save output of stage 2, in order to have solution values for Europe countries (not considered in stage 3)
$Include Output_declaration.gms


$onecho > Output\Output_all_stage2.tmp
epsout = 0
par=output_year                  rng=year!A4                     rdim=1  cdim=1
par=output_DE_year               rng=DE_year!A4                  rdim=1  cdim=1
par=output_DE_hour               rng=DE_hour!A4                  rdim=2  cdim=1
par=output_DE_export_year        rng=DE_export_year!A4           rdim=2  cdim=1
par=output_DE_export_hour        rng=DE_export_hour!A4           rdim=2  cdim=2
par=output_NL_year               rng=NL_year!A4                  rdim=1  cdim=1
par=output_NL_hour               rng=NL_hour!A4                  rdim=2  cdim=1
par=output_NL_export_year        rng=NL_export_year!A4           rdim=2  cdim=1
par=output_NL_export_hour        rng=NL_export_hour!A4           rdim=2  cdim=2
par=output_FR_year               rng=FR_year!A4                  rdim=1  cdim=1
par=output_FR_hour               rng=FR_hour!A4                  rdim=2  cdim=1
par=output_FR_export_year        rng=FR_export_year!A4           rdim=2  cdim=1
par=output_FR_export_hour        rng=FR_export_hour!A4           rdim=2  cdim=2
par=flow_L                       rng=flow_L!A4                   rdim=2  cdim=2
$offecho


put_utility 'gdxout' / 'Output\Output_all_stage2';
execute_unload output_year,output_DE_year,output_DE_hour,output_DE_export_year,output_DE_export_hour,
               output_NL_year,output_NL_hour,output_NL_export_year,output_NL_export_hour,
               output_FR_year,output_FR_hour,output_FR_export_year,output_FR_export_hour,
               flow_L;

put_utility 'exec' /'gdxxrw.exe I=Output\Output_all_stage2.gdx O=Output\3stage\Output_all_stage2.xlsx @Output\Output_all_stage2.tmp';

*###############################################################################
*
*        stage 3:
*        - investment and dispatch for Germany+Luxembourg and Netherlands
*        - with part-load and startup costs
*        - high hourly resolution
*        - import and exports to neighbours are fixed with solution of stage 2
*
*###############################################################################

Option Clear = netexport_border;

country(country_all) = NO;
country('DE+LU') = YES;

netexport_border(country,year,hour_all)$(hour(year,hour_all)) = sum(country_all$(not country2(country_all)), FLOW.L(country,country_all,year,hour_all) - FLOW.L(country_all,country,year,hour_all));


*Unfix investment and divestment decisions
CAP_CONV_INSTALL.LO(country,conv,year) = 0;
CAP_CONV_ADD.LO(country,conv,year) = 0;
CAP_CONV_SUB.LO(country,conv,year) = 0;

CAP_CONV_INSTALL.UP(country,conv,year) = INF;
CAP_CONV_ADD.UP(country,conv,year) = INF;
CAP_CONV_SUB.UP(country,conv,year) = INF;

indicator_partload = 1;
indicator_ramping = 1;

indicator_partload_country(country) = indicator_partload;
indicator_ramping_country(country) = indicator_ramping;

indicator_loadcurt(country) = 1;

Investment.optfile=1;

Solve Investment using LP minimizing COST;

*Statistcs for stage 3
output_performance('modelStat','run3') = Investment.modelStat;
output_performance('solveStat','run3') = Investment.solveStat;
output_performance('resGen','run3') = Investment.resGen;
output_performance('resUsd','run3') = Investment.resUsd;
output_performance('etAlg','run3') = Investment.etAlg;
output_performance('etSolve','run3') = Investment.etSolve;
output_performance('etSolver','run3') = Investment.etSolver;
output_performance('numEqu','run3') = Investment.numEqu;
output_performance('numVar','run3') = Investment.numVar;
output_performance('ObjVal','run3') = Investment.ObjVal;

output_configuration('#technologies','run3') = sum(conv$( convyear_lo(conv) le ( sum(year$(ord(year) eq card(year)), yearnumber(year)) )  ), 1);
output_configuration('#countries','run3') = card(country);
output_configuration('#years','run3') = sum(year, 1);
output_configuration('#hours','run3') = sum(hour_all$(hour('2020',hour_all)), 1);
output_configuration('partload','run3') = indicator_partload + EPS;
output_configuration('ramping','run3') = indicator_ramping + EPS;
output_configuration('chp','run3') = indicator_chp + EPS;
output_configuration('chp_trimmed','run3') = indicator_chp_trimmed + EPS;
output_configuration('countryefficiency','run3') = indicator_countryefficiency + EPS;
output_configuration('countryavailability','run3') = indicator_countryavail + EPS;
output_configuration('varomcost','run3') = indicator_varomcost + EPS;
output_configuration('coalphaseout','run3') = indicator_coalphaseout + EPS;
output_configuration('divestment','run3') = indicator_divestment + EPS;
output_configuration('futurechp','run3') = indicator_futurechp + EPS;
output_configuration('fuelprice_countryfactor','run3') = indicator_fuelprice_countryfactor + EPS;

*Save output of stage 3, i.e. solution for Germany (its solution of stage 2 is overwritten)
$Include Output_declaration.gms

output_DE_hour(year,hour_all,'export_sum')$(hour(year,hour_all)) = sum(country_all$(ntc('DE+LU',country_all,year) gt 0), output_DE_export_hour(year,hour_all,'export',country_all)) + EPS;
output_DE_hour(year,hour_all,'import_sum')$(hour(year,hour_all)) = sum(country_all$(ntc(country_all,'DE+LU',year) gt 0), output_DE_export_hour(year,hour_all,'import',country_all)) + EPS;

output_NL_hour(year,hour_all,'export_sum')$(hour(year,hour_all)) = sum(country_all$(ntc('NL',country_all,year) gt 0), output_NL_export_hour(year,hour_all,'export',country_all)) + EPS;
output_NL_hour(year,hour_all,'import_sum')$(hour(year,hour_all)) = sum(country_all$(ntc(country_all,'NL',year) gt 0), output_NL_export_hour(year,hour_all,'import',country_all)) + EPS;

output_DE_year(year,'export_sum') = sum(country_all$(ntc('DE+LU',country_all,year) gt 0), output_DE_export_year(year,'export',country_all)) + EPS;
output_DE_year(year,'import_sum') = sum(country_all$(ntc(country_all,'DE+LU',year) gt 0), output_DE_export_year(year,'import',country_all)) + EPS;

output_NL_year(year,'export_sum') = sum(country_all$(ntc('NL',country_all,year) gt 0), output_NL_export_year(year,'export',country_all)) + EPS;
output_NL_year(year,'import_sum') = sum(country_all$(ntc(country_all,'NL',year) gt 0), output_NL_export_year(year,'import',country_all)) + EPS;


*###############################################################################
*Export output to excel file
$onecho > Output\Output_all_stage3_DE.tmp
epsout = 0
par=output_configuration         rng=configuration!A4            rdim=1  cdim=1
par=output_performance           rng=performance!A4              rdim=1  cdim=1
par=output_year                  rng=year!A4                     rdim=1  cdim=1
par=output_DE_year               rng=DE_year!A4                  rdim=1  cdim=1
par=output_AT_year               rng=AT_year!A4                  rdim=1  cdim=1
par=output_BE_year               rng=BE_year!A4                  rdim=1  cdim=1
par=output_CH_year               rng=CH_year!A4                  rdim=1  cdim=1
par=output_CZ_year               rng=CZ_year!A4                  rdim=1  cdim=1
par=output_DK_year               rng=DK_year!A4                  rdim=1  cdim=1
par=output_FR_year               rng=FR_year!A4                  rdim=1  cdim=1
par=output_NL_year               rng=NL_year!A4                  rdim=1  cdim=1
par=output_NO_year               rng=NO_year!A4                  rdim=1  cdim=1
par=output_PL_year               rng=PL_year!A4                  rdim=1  cdim=1
par=output_SE_year               rng=SE_year!A4                  rdim=1  cdim=1
par=output_UK_year               rng=UK_year!A4                  rdim=1  cdim=1
par=output_DE_export_year        rng=DE_export_year!A4           rdim=2  cdim=1
par=output_AT_export_year        rng=AT_export_year!A4           rdim=2  cdim=1
par=output_BE_export_year        rng=BE_export_year!A4           rdim=2  cdim=1
par=output_CH_export_year        rng=CH_export_year!A4           rdim=2  cdim=1
par=output_CZ_export_year        rng=CZ_export_year!A4           rdim=2  cdim=1
par=output_DK_export_year        rng=DK_export_year!A4           rdim=2  cdim=1
par=output_FR_export_year        rng=FR_export_year!A4           rdim=2  cdim=1
par=output_NL_export_year        rng=NL_export_year!A4           rdim=2  cdim=1
par=output_NO_export_year        rng=NO_export_year!A4           rdim=2  cdim=1
par=output_PL_export_year        rng=PL_export_year!A4           rdim=2  cdim=1
par=output_SE_export_year        rng=SE_export_year!A4           rdim=2  cdim=1
par=output_UK_export_year        rng=UK_export_year!A4           rdim=2  cdim=1
par=output_DE_hour               rng=DE_hour!A4                  rdim=2  cdim=1
par=output_AT_hour               rng=AT_hour!A4                  rdim=2  cdim=1
par=output_BE_hour               rng=BE_hour!A4                  rdim=2  cdim=1
par=output_CH_hour               rng=CH_hour!A4                  rdim=2  cdim=1
par=output_CZ_hour               rng=CZ_hour!A4                  rdim=2  cdim=1
par=output_DK_hour               rng=DK_hour!A4                  rdim=2  cdim=1
par=output_FR_hour               rng=FR_hour!A4                  rdim=2  cdim=1
par=output_NL_hour               rng=NL_hour!A4                  rdim=2  cdim=1
par=output_NO_hour               rng=NO_hour!A4                  rdim=2  cdim=1
par=output_PL_hour               rng=PL_hour!A4                  rdim=2  cdim=1
par=output_SE_hour               rng=SE_hour!A4                  rdim=2  cdim=1
par=output_UK_hour               rng=UK_hour!A4                  rdim=2  cdim=1
par=output_DE_export_hour        rng=DE_export_hour!A4           rdim=2  cdim=2
par=output_AT_export_hour        rng=AT_export_hour!A4           rdim=2  cdim=2
par=output_BE_export_hour        rng=BE_export_hour!A4           rdim=2  cdim=2
par=output_CH_export_hour        rng=CH_export_hour!A4           rdim=2  cdim=2
par=output_CZ_export_hour        rng=CZ_export_hour!A4           rdim=2  cdim=2
par=output_DK_export_hour        rng=DK_export_hour!A4           rdim=2  cdim=2
par=output_FR_export_hour        rng=FR_export_hour!A4           rdim=2  cdim=2
par=output_NL_export_hour        rng=NL_export_hour!A4           rdim=2  cdim=2
par=output_NO_export_hour        rng=NO_export_hour!A4           rdim=2  cdim=2
par=output_PL_export_hour        rng=PL_export_hour!A4           rdim=2  cdim=2
par=output_SE_export_hour        rng=SE_export_hour!A4           rdim=2  cdim=2
par=output_UK_export_hour        rng=UK_export_hour!A4           rdim=2  cdim=2
par=output_DE_hour_conv          rng=DE_hour_conv!A4             rdim=2  cdim=2
par=output_DE_year_conv          rng=DE_year_conv!A4             rdim=2  cdim=1
par=output_country_year_conv     rng=country_year_conv!A4        rdim=3  cdim=1
$offecho


*Export output to excel file
$onecho > Output\Output_all_stage3_outside.tmp
epsout = 0
par=output_BALT_year             rng=BALT_year!A4                rdim=1  cdim=1
par=output_BG_year               rng=BG_year!A4                  rdim=1  cdim=1
par=output_FI_year               rng=FI_year!A4                  rdim=1  cdim=1
par=output_GR_year               rng=GR_year!A4                  rdim=1  cdim=1
par=output_HR_year               rng=HR_year!A4                  rdim=1  cdim=1
par=output_HU_year               rng=HU_year!A4                  rdim=1  cdim=1
par=output_IBER_year             rng=IBER_year!A4                rdim=1  cdim=1
par=output_IE_year               rng=IE_year!A4                  rdim=1  cdim=1
par=output_IT_year               rng=IT_year!A4                  rdim=1  cdim=1
par=output_MT_year               rng=MT_year!A4                  rdim=1  cdim=1
par=output_RO_year               rng=RO_year!A4                  rdim=1  cdim=1
par=output_SI_year               rng=SI_year!A4                  rdim=1  cdim=1
par=output_SK_year               rng=SK_year!A4                  rdim=1  cdim=1
par=output_BALT_export_year      rng=BALT_export_year!A4         rdim=2  cdim=1
par=output_BG_export_year        rng=BG_export_year!A4           rdim=2  cdim=1
par=output_FI_export_year        rng=FI_export_year!A4           rdim=2  cdim=1
par=output_GR_export_year        rng=GR_export_year!A4           rdim=2  cdim=1
par=output_HR_export_year        rng=HR_export_year!A4           rdim=2  cdim=1
par=output_HU_export_year        rng=HU_export_year!A4           rdim=2  cdim=1
par=output_IBER_export_year      rng=IBER_export_year!A4         rdim=2  cdim=1
par=output_IE_export_year        rng=IE_export_year!A4           rdim=2  cdim=1
par=output_MT_export_year        rng=MT_export_year!A4           rdim=2  cdim=1
par=output_RO_export_year        rng=RO_export_year!A4           rdim=2  cdim=1
par=output_SI_export_year        rng=SI_export_year!A4           rdim=2  cdim=1
par=output_SK_export_year        rng=SK_export_year!A4           rdim=2  cdim=1
par=output_BALT_hour             rng=BALT_hour!A4                rdim=2  cdim=1
par=output_BG_hour               rng=BG_hour!A4                  rdim=2  cdim=1
par=output_FI_hour               rng=FI_hour!A4                  rdim=2  cdim=1
par=output_GR_hour               rng=GR_hour!A4                  rdim=2  cdim=1
par=output_HR_hour               rng=HR_hour!A4                  rdim=2  cdim=1
par=output_HU_hour               rng=HU_hour!A4                  rdim=2  cdim=1
par=output_IBER_hour             rng=IBER_hour!A4                rdim=2  cdim=1
par=output_IE_hour               rng=IE_hour!A4                  rdim=2  cdim=1
par=output_IT_hour               rng=IT_hour!A4                  rdim=2  cdim=1
par=output_MT_hour               rng=MT_hour!A4                  rdim=2  cdim=1
par=output_RO_hour               rng=RO_hour!A4                  rdim=2  cdim=1
par=output_SI_hour               rng=SI_hour!A4                  rdim=2  cdim=1
par=output_SK_hour               rng=SK_hour!A4                  rdim=2  cdim=1
par=output_BALT_export_hour      rng=BALT_export_hour!A4         rdim=2  cdim=2
par=output_BG_export_hour        rng=BG_export_hour!A4           rdim=2  cdim=2
par=output_FI_export_hour        rng=FI_export_hour!A4           rdim=2  cdim=2
par=output_GR_export_hour        rng=GR_export_hour!A4           rdim=2  cdim=2
par=output_HR_export_hour        rng=HR_export_hour!A4           rdim=2  cdim=2
par=output_HU_export_hour        rng=HU_export_hour!A4           rdim=2  cdim=2
par=output_IBER_export_hour      rng=IBER_export_hour!A4         rdim=2  cdim=2
par=output_IE_export_hour        rng=IE_export_hour!A4           rdim=2  cdim=2
par=output_IT_export_hour        rng=IT_export_hour!A4           rdim=2  cdim=2
par=output_MT_export_hour        rng=MT_export_hour!A4           rdim=2  cdim=2
par=output_RO_export_hour        rng=RO_export_hour!A4           rdim=2  cdim=2
par=output_SI_export_hour        rng=SI_export_hour!A4           rdim=2  cdim=2
par=output_SK_export_hour        rng=SK_export_hour!A4           rdim=2  cdim=2
$offecho

put_utility 'gdxout' / 'Output\Output_all_stage3_DE';
execute_unload output_configuration,output_performance,output_year,
               output_DE_year,output_AT_year,output_BE_year,output_CH_year,output_CZ_year,output_DK_year,
               output_FR_year,output_NL_year,output_NO_year,output_PL_year,output_SE_year,output_UK_year
               output_DE_export_year,output_AT_export_year,output_BE_export_year,output_CH_export_year,output_CZ_export_year,output_DK_export_year,
               output_FR_export_year,output_NL_export_year,output_NO_export_year,output_PL_export_year,output_SE_export_year,output_UK_export_year,
               output_DE_hour,output_AT_hour,output_BE_hour,output_CH_hour,output_CZ_hour,output_DK_hour,
               output_FR_hour,output_NL_hour,output_NO_hour,output_PL_hour,output_SE_hour,output_UK_hour,
               output_DE_export_hour,output_AT_export_hour,output_BE_export_hour,output_CH_export_hour,output_CZ_export_hour,output_DK_export_hour,
               output_FR_export_hour,output_NL_export_hour,output_NO_export_hour,output_PL_export_hour,output_SE_export_hour,output_UK_export_hour,
               output_DE_hour_conv,output_DE_year_conv,
               output_country_year_conv;

put_utility 'exec' /'gdxxrw.exe I=Output\Output_all_stage3_DE.gdx O=Output\3stage\Output_all_stage3_DE.xlsx @Output\Output_all_stage3_DE.tmp';

put_utility 'gdxout' / 'Output\Output_all_stage3_outside';
execute_unload output_BALT_year,output_BG_year,output_FI_year,output_GR_year,
               output_HR_year,output_HU_year,output_IBER_year,output_IE_year,
               output_IT_year,output_MT_year,output_RO_year,output_SI_year,output_SK_year,
               output_BALT_export_year,output_BG_export_year,output_FI_export_year,output_GR_export_year,
               output_HR_export_year,output_HU_export_year,output_IBER_export_year,output_IE_export_year,
               output_IT_export_year,output_MT_export_year,output_RO_export_year,output_SI_export_year,output_SK_export_year,
               output_BALT_hour,output_BG_hour,output_FI_hour,output_GR_hour,
               output_HR_hour,output_HU_hour,output_IBER_hour,output_IE_hour,
               output_IT_hour,output_MT_hour,output_RO_hour,output_SI_hour,output_SK_hour,
               output_BALT_export_hour,output_BG_export_hour,output_FI_export_hour,output_GR_export_hour,
               output_HR_export_hour,output_HU_export_hour,output_IBER_export_hour,output_IE_export_hour,
               output_IT_export_hour,output_MT_export_hour,output_RO_export_hour,output_SI_export_hour,output_SK_export_hour;

put_utility 'exec' /'gdxxrw.exe I=Output\Output_all_stage3_outside.gdx O=Output\3stage\Output_all_stage3_outside.xlsx @Output\Output_all_stage3_outside.tmp';

