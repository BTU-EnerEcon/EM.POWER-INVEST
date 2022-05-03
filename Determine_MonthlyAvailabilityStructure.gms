$offOrder
$include Define_sets_and_parameters.gms
$onUNDF
$gdxin Input\Input_h8760.gdx
$load country_all
$load hour_all
$load map_hourmonth
$load load_structure
$load capfactor_solar
$load capfactor_windonshore
$load capfactor_windoffshore
$load capfactor_runofriver
$gdxin
$offUNDF


*yearly data
$onUNDF
*$gdxin Input\Input_yearly_scenario3.gdx
$gdxin Input\Input_yearly_scenarios1and2.gdx
$load conv
$load renew
$load country_collection
$load load_year
$load outages_conv
$load cap_renew_install_exogen_year
$load gen_renew_all_year
$load inputdata_renew
$gdxin
$offUNDF

Option NLP=ipopt;

Parameters
resload(country_all,year_all,hour_all)
max_monthlyload(year_all,month,country_all)
max_monthlyresload(year_all,month,country_all)
;

country(country_all) = NO;
country(country_all)$(country_collection(country_all,'ETS_all_region_DE+LU') eq 1) = YES;
country('CY') = NO;

year(year_all) = YES;
year('2070') = NO;

map_hourmonth('2022',hour_all,month) = map_hourmonth('2020',hour_all,month);
map_hourmonth('2024',hour_all,month) = map_hourmonth('2025',hour_all,month);
map_hourmonth('2026',hour_all,month) = map_hourmonth('2025',hour_all,month);
map_hourmonth('2028',hour_all,month) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2032',hour_all,month) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2034',hour_all,month) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2036',hour_all,month) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2038',hour_all,month) = map_hourmonth('2040',hour_all,month);
map_hourmonth('2045',hour_all,month) = map_hourmonth('2040',hour_all,month);
map_hourmonth('2050',hour_all,month) = map_hourmonth('2040',hour_all,month);
*Display map_hourmonth;

*Calculate yearly load
load_year('2022',country) = 0.6*load_year('2020',country) + 0.4*load_year('2025',country);
load_year('2024',country) = 0.2*load_year('2020',country) + 0.8*load_year('2025',country);
load_year('2026',country) = 0.8*load_year('2025',country) + 0.2*load_year('2030',country);
load_year('2028',country) = 0.4*load_year('2025',country) + 0.6*load_year('2030',country);
load_year('2032',country) = 0.8*load_year('2030',country) + 0.2*load_year('2040',country);
load_year('2034',country) = 0.6*load_year('2030',country) + 0.4*load_year('2040',country);
load_year('2036',country) = 0.4*load_year('2030',country) + 0.6*load_year('2040',country);
load_year('2038',country) = 0.2*load_year('2030',country) + 0.8*load_year('2040',country);
load_year('2050',country) = load_year('2040',country) + ((load_year('2040',country) - load_year('2030',country))/(2040-2030))*(2050-2040);
load_year('2045',country) = 0.5*load_year('2040',country) + 0.5*load_year('2050',country);
*Display load_year

*Declare hourly load structure
load_structure('2022',hour_all,country) = load_structure('2020',hour_all,country);
load_structure('2024',hour_all,country) = load_structure('2025',hour_all,country);
load_structure('2026',hour_all,country) = load_structure('2025',hour_all,country);
load_structure('2028',hour_all,country) = load_structure('2030',hour_all,country);
load_structure('2032',hour_all,country) = load_structure('2030',hour_all,country);
load_structure('2034',hour_all,country) = load_structure('2030',hour_all,country);
load_structure('2036',hour_all,country) = load_structure('2030',hour_all,country);
load_structure('2038',hour_all,country) = load_structure('2040',hour_all,country);
load_structure('2045',hour_all,country) = load_structure('2040',hour_all,country);
load_structure('2050',hour_all,country) = load_structure('2040',hour_all,country);
*Display load_structure;

*Calculate hourly load
load(country,year,hour_all) = load_year(year,country) * load_structure(year,hour_all,country);
*Display load;

*Declare plannedoutages_conv
plannedoutages_conv(country,conv,year) = outages_conv('planned_outages',conv,year,country);
plannedoutages_conv(country,conv,'2022') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2024') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2026') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2028') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2030') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2032') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2034') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2036') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2038') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2040') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2045') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2050') = plannedoutages_conv(country,conv,'2020');

*Capacity factors of volatile renewables
capfactor_renew_max(country,'solar',year,hour_all) = capfactor_solar(year,hour_all,country);
capfactor_renew_max(country,'windonshore',year,hour_all) = capfactor_windonshore(year,hour_all,country);
capfactor_renew_max(country,'windoffshore',year,hour_all) = capfactor_windoffshore(year,hour_all,country);
capfactor_renew_max(country,'runofriver',year,hour_all) = capfactor_runofriver(year,hour_all,country);

capfactor_renew_max(country,'solar','2022',hour_all) = capfactor_renew_max(country,'solar','2020',hour_all);
capfactor_renew_max(country,'solar','2024',hour_all) = capfactor_renew_max(country,'solar','2025',hour_all);
capfactor_renew_max(country,'solar','2026',hour_all) = capfactor_renew_max(country,'solar','2025',hour_all);
capfactor_renew_max(country,'solar','2028',hour_all) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2032',hour_all) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2034',hour_all) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2036',hour_all) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2038',hour_all) = capfactor_renew_max(country,'solar','2040',hour_all);
capfactor_renew_max(country,'solar','2045',hour_all) = capfactor_renew_max(country,'solar','2040',hour_all);
capfactor_renew_max(country,'solar','2050',hour_all) = capfactor_renew_max(country,'solar','2040',hour_all);

capfactor_renew_max(country,'windonshore','2022',hour_all) = capfactor_renew_max(country,'windonshore','2020',hour_all);
capfactor_renew_max(country,'windonshore','2024',hour_all) = capfactor_renew_max(country,'windonshore','2025',hour_all);
capfactor_renew_max(country,'windonshore','2026',hour_all) = capfactor_renew_max(country,'windonshore','2025',hour_all);
capfactor_renew_max(country,'windonshore','2028',hour_all) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2032',hour_all) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2034',hour_all) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2036',hour_all) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2038',hour_all) = capfactor_renew_max(country,'windonshore','2040',hour_all);
capfactor_renew_max(country,'windonshore','2045',hour_all) = capfactor_renew_max(country,'windonshore','2040',hour_all);
capfactor_renew_max(country,'windonshore','2050',hour_all) = capfactor_renew_max(country,'windonshore','2040',hour_all);

capfactor_renew_max(country,'windoffshore','2022',hour_all) = capfactor_renew_max(country,'windoffshore','2020',hour_all);
capfactor_renew_max(country,'windoffshore','2024',hour_all) = capfactor_renew_max(country,'windoffshore','2025',hour_all);
capfactor_renew_max(country,'windoffshore','2026',hour_all) = capfactor_renew_max(country,'windoffshore','2025',hour_all);
capfactor_renew_max(country,'windoffshore','2028',hour_all) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2032',hour_all) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2034',hour_all) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2036',hour_all) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2038',hour_all) = capfactor_renew_max(country,'windoffshore','2040',hour_all);
capfactor_renew_max(country,'windoffshore','2045',hour_all) = capfactor_renew_max(country,'windoffshore','2040',hour_all);
capfactor_renew_max(country,'windoffshore','2050',hour_all) = capfactor_renew_max(country,'windoffshore','2040',hour_all);

capfactor_renew_max(country,'runofriver','2022',hour_all) = capfactor_renew_max(country,'runofriver','2020',hour_all);
capfactor_renew_max(country,'runofriver','2024',hour_all) = capfactor_renew_max(country,'runofriver','2025',hour_all);
capfactor_renew_max(country,'runofriver','2026',hour_all) = capfactor_renew_max(country,'runofriver','2025',hour_all);
capfactor_renew_max(country,'runofriver','2028',hour_all) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2032',hour_all) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2034',hour_all) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2036',hour_all) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2038',hour_all) = capfactor_renew_max(country,'runofriver','2040',hour_all);
capfactor_renew_max(country,'runofriver','2045',hour_all) = capfactor_renew_max(country,'runofriver','2040',hour_all);
capfactor_renew_max(country,'runofriver','2050',hour_all) = capfactor_renew_max(country,'runofriver','2040',hour_all);

*Determine installed renewable capacity
cap_renew_install_exogen(country,renew,year) = cap_renew_install_exogen_year(renew,year,country);
cap_renew_install_exogen(country,renew,'2022') = 0.6*cap_renew_install_exogen(country,renew,'2020') + 0.4*cap_renew_install_exogen(country,renew,'2025');
cap_renew_install_exogen(country,renew,'2024') = 0.2*cap_renew_install_exogen(country,renew,'2020') + 0.8*cap_renew_install_exogen(country,renew,'2025');
cap_renew_install_exogen(country,renew,'2026') = 0.8*cap_renew_install_exogen(country,renew,'2025') + 0.2*cap_renew_install_exogen(country,renew,'2030');
cap_renew_install_exogen(country,renew,'2028') = 0.4*cap_renew_install_exogen(country,renew,'2025') + 0.6*cap_renew_install_exogen(country,renew,'2030');
cap_renew_install_exogen(country,renew,'2032') = 0.8*cap_renew_install_exogen(country,renew,'2030') + 0.2*cap_renew_install_exogen(country,renew,'2040');
cap_renew_install_exogen(country,renew,'2034') = 0.6*cap_renew_install_exogen(country,renew,'2030') + 0.4*cap_renew_install_exogen(country,renew,'2040');
cap_renew_install_exogen(country,renew,'2036') = 0.4*cap_renew_install_exogen(country,renew,'2030') + 0.6*cap_renew_install_exogen(country,renew,'2040');
cap_renew_install_exogen(country,renew,'2038') = 0.2*cap_renew_install_exogen(country,renew,'2030') + 0.8*cap_renew_install_exogen(country,renew,'2040');
cap_renew_install_exogen(country,renew,'2050') = cap_renew_install_exogen(country,renew,'2040') + ((cap_renew_install_exogen(country,renew,'2040') - cap_renew_install_exogen(country,renew,'2030'))/(2040-2030))*(2050-2040);
cap_renew_install_exogen(country,renew,'2045') = 0.5*cap_renew_install_exogen(country,renew,'2040') + 0.5*cap_renew_install_exogen(country,renew,'2050');
*Display cap_renew_install_exogen_year,cap_renew_install_exogen;

*Calculate renewable generation potential
gen_renew_exogen(country,renew,year) = gen_renew_all_year(renew,year,country);
gen_renew_exogen(country,renew,'2022') = 0.6*gen_renew_exogen(country,renew,'2020') + 0.4*gen_renew_exogen(country,renew,'2025');
gen_renew_exogen(country,renew,'2024') = 0.2*gen_renew_exogen(country,renew,'2020') + 0.8*gen_renew_exogen(country,renew,'2025');
gen_renew_exogen(country,renew,'2026') = 0.8*gen_renew_exogen(country,renew,'2025') + 0.2*gen_renew_exogen(country,renew,'2030');
gen_renew_exogen(country,renew,'2028') = 0.4*gen_renew_exogen(country,renew,'2025') + 0.6*gen_renew_exogen(country,renew,'2030');
gen_renew_exogen(country,renew,'2032') = 0.8*gen_renew_exogen(country,renew,'2030') + 0.2*gen_renew_exogen(country,renew,'2040');
gen_renew_exogen(country,renew,'2034') = 0.6*gen_renew_exogen(country,renew,'2030') + 0.4*gen_renew_exogen(country,renew,'2040');
gen_renew_exogen(country,renew,'2036') = 0.4*gen_renew_exogen(country,renew,'2030') + 0.6*gen_renew_exogen(country,renew,'2040');
gen_renew_exogen(country,renew,'2038') = 0.2*gen_renew_exogen(country,renew,'2030') + 0.8*gen_renew_exogen(country,renew,'2040');
gen_renew_exogen(country,renew,'2050') = gen_renew_exogen(country,renew,'2040') + ((gen_renew_exogen(country,renew,'2040') - gen_renew_exogen(country,renew,'2030'))/(2040-2030))*(2050-2040);
gen_renew_exogen(country,renew,'2045') = 0.5*gen_renew_exogen(country,renew,'2040') + 0.5*gen_renew_exogen(country,renew,'2050');

gen_renew_exogen(country,'runofriver','2045') = gen_renew_exogen(country,'runofriver','2040');
gen_renew_exogen(country,'runofriver','2050') = gen_renew_exogen(country,'runofriver','2040');
*Display gen_renew_exogen;


*Calibrate values
cap_renew_install_exogen2(country,'solar',year)$(gen_renew_exogen(country,'solar',year) gt 0) = (gen_renew_exogen(country,'solar',year) * 1000) / ( sum(hour_all, capfactor_renew_max(country,'solar',year,hour_all)));
cap_renew_install_exogen2(country,'windonshore',year)$(gen_renew_exogen(country,'windonshore',year) gt 0) = (gen_renew_exogen(country,'windonshore',year) * 1000) / ( sum(hour_all, capfactor_renew_max(country,'windonshore',year,hour_all)));
cap_renew_install_exogen2(country,'windoffshore',year)$(gen_renew_exogen(country,'windoffshore',year) gt 0) = (gen_renew_exogen(country,'windoffshore',year) * 1000) / ( sum(hour_all, capfactor_renew_max(country,'windoffshore',year,hour_all)));
cap_renew_install_exogen2(country,'runofriver',year)$(gen_renew_exogen(country,'runofriver',year) gt 0) = (gen_renew_exogen(country,'runofriver',year) * 1000) / ( sum(hour_all, capfactor_renew_max(country,'runofriver',year,hour_all)));

gen_renew_exogen2(country,'solar',year)$(gen_renew_exogen(country,'solar',year) gt 0) = sum(hour_all, cap_renew_install_exogen2(country,'solar',year) *  ( capfactor_renew_max(country,'solar',year,hour_all) / 1000 ) );
gen_renew_exogen2(country,'windonshore',year)$(gen_renew_exogen(country,'windonshore',year) gt 0) = sum(hour_all, cap_renew_install_exogen2(country,'windonshore',year) *  ( capfactor_renew_max(country,'windonshore',year,hour_all) / 1000 ) );
gen_renew_exogen2(country,'windoffshore',year)$(gen_renew_exogen(country,'windoffshore',year) gt 0) = sum(hour_all, cap_renew_install_exogen2(country,'windoffshore',year) *  ( capfactor_renew_max(country,'windoffshore',year,hour_all) / 1000 ) );
gen_renew_exogen2(country,'runofriver',year)$(gen_renew_exogen(country,'runofriver',year) gt 0) = sum(hour_all, cap_renew_install_exogen2(country,'runofriver',year) *  ( capfactor_renew_max(country,'runofriver',year,hour_all) / 1000 ) );
*Display cap_renew_install_exogen,cap_renew_install_exogen2,gen_renew_exogen,gen_renew_exogen2;

cap_renew_install_exogen(country,'solar',year) = cap_renew_install_exogen2(country,'solar',year);
cap_renew_install_exogen(country,'windonshore',year) = cap_renew_install_exogen2(country,'windonshore',year);
cap_renew_install_exogen(country,'windoffshore',year) = cap_renew_install_exogen2(country,'windoffshore',year);
cap_renew_install_exogen(country,'runofriver',year) = cap_renew_install_exogen2(country,'runofriver',year);
*Display capfactor_renew_max,gen_renew_exogen,gen_renew_exogen2;

capfactor_renew_max(country,'geothermal',year,hour_all)$(cap_renew_install_exogen(country,'geothermal',year) gt 0) = ( gen_renew_exogen(country,'geothermal',year) * 1000 ) / ( cap_renew_install_exogen(country,'geothermal',year) * 8760 );
capfactor_renew_max(country,'marine',year,hour_all)$(cap_renew_install_exogen(country,'marine',year) gt 0) = ( gen_renew_exogen(country,'marine',year) * 1000 ) / ( cap_renew_install_exogen(country,'marine',year) * 8760 );

renew_disp(renew)$(inputdata_renew(renew,'renew_disp') eq 1) = YES;


year('2025') = NO;

*Calculate resload
resload(country,year,hour_all) = load(country,year,hour_all)
                                                      -
                                                      capfactor_renew_max(country,'solar',year,hour_all) * cap_renew_install_exogen(country,'solar',year)
                                                      -
                                                      capfactor_renew_max(country,'windonshore',year,hour_all) * cap_renew_install_exogen(country,'windonshore',year)
                                                      -
                                                      capfactor_renew_max(country,'windoffshore',year,hour_all) * cap_renew_install_exogen(country,'windoffshore',year)
                                                      -
                                                      capfactor_renew_max(country,'runofriver',year,hour_all) * cap_renew_install_exogen(country,'runofriver',year)
                                                      -
                                                      capfactor_renew_max(country,'geothermal',year,hour_all) * cap_renew_install_exogen(country,'geothermal',year)
                                                      -
                                                      capfactor_renew_max(country,'marine',year,hour_all) * cap_renew_install_exogen(country,'marine',year) + EPS
;
*Display resload;

max_monthlyload(year,month,country) = smax(hour_all$(map_hourmonth(year,hour_all,month)), load(country,year,hour_all)) + EPS;
max_monthlyresload(year,month,country) = smax(hour_all$(map_hourmonth(year,hour_all,month)), resload(country,year,hour_all)) + EPS;
max_monthlyresload_norm(country,year,month) = max_monthlyresload(year,month,country) / smax(month2, max_monthlyresload(year,month2,country));
Display max_monthlyresload,max_monthlyresload_norm;

*###############################################################################
*
*                                        Model
*
*###############################################################################

Variables
OBJ_EXPONENT
;

Positive Variables
EXPONENT_conv(country_all,conv,year_all)
EXPONENT_renew(country_all,renew,year_all)
;

Equations
DEF_OBJ_EXPONENT
DEF_EXPONENT_conv
DEF_EXPONENT_renew
;

*###############################################
*Equations for calculation of availability structure

DEF_OBJ_EXPONENT..
         OBJ_EXPONENT =E= 1
;
DEF_EXPONENT_conv(country,conv,year)..
         sum(month, max_monthlyresload_norm(country,year,month)**EXPONENT_conv(country,conv,year)) =E= (1 - plannedoutages_conv(country,conv,year))*12
;

DEF_EXPONENT_renew(country,renew_disp,year)$(inputdata_renew(renew_disp,'avail') lt 1)..
         sum(month, max_monthlyresload_norm(country,year,month)**EXPONENT_renew(country,renew_disp,year)) =E= inputdata_renew(renew_disp,'avail')*12
;

Model Determine_Exponent
/
DEF_OBJ_EXPONENT
DEF_EXPONENT_conv
DEF_EXPONENT_renew
/;

Solve Determine_Exponent using NLP minimizing OBJ_EXPONENT;
Display Determine_Exponent.modelStat,Determine_Exponent.solveStat,EXPONENT_conv.L,EXPONENT_renew.L;

availability_conv_planned(country,conv,year,month) =  max_monthlyresload_norm(country,year,month)**EXPONENT_conv.L(country,conv,year);
sum_availability_conv_planned(country,conv,year) = sum(month, availability_conv_planned(country,conv,year,month));
Display availability_conv_planned,sum_availability_conv_planned;

availability_renew_month(country,renew_disp,year,month)$(inputdata_renew(renew_disp,'avail') lt 1) = max_monthlyresload_norm(country,year,month)**EXPONENT_renew.L(country,renew_disp,year);
sum_availability_renew_month(country,renew_disp,year)$(inputdata_renew(renew_disp,'avail') lt 1) = sum(month, availability_renew_month(country,renew_disp,year,month));
Display availability_renew_month,sum_availability_renew_month;

put_utility 'gdxout' / 'Input\Input_MonthlyAvailabilityStructure';
execute_unload availability_conv_planned,availability_renew_month;


