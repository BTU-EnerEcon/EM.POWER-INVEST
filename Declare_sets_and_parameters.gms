*###############################################################################
*
*                        Declaration of sets and parameter
*
*###############################################################################
country(country_all) = NO;
country(country_all)$(country_collection(country_all,'ETS_all_region_DE+LU') eq 1) = YES;
country('CY') = NO;
*country('DE+LU') = YES;
*country('NL') = YES;
*country('FR') = YES;
*country('ES+PT') = YES;

*Display country;

indicator_loadcurt(country) = 0;

year(year_all) = YES;
year('2025') = NO;

energy_weighting_factor(year)$(yearnumber(year) lt 2070) = sum(i$( (ord(i) ge yearnumber(year)) AND (ord(i) lt yearnumber(year+1)) ), 1 );
money_weighting_factor(year)$(yearnumber(year) lt 2070) = sum(i$( (ord(i) ge yearnumber(year)) AND (ord(i) lt yearnumber(year+1)) ), 1 / power((1 + discount_rate), (ord(i) - 2020)));
discount_factor(year)$(yearnumber(year) lt 2070) = money_weighting_factor(year) / energy_weighting_factor(year);
*Display energy_weighting_factor,money_weighting_factor,discount_factor;

year('2070') = NO;
year('2025') = YES;

discount_factor('2025') = 0.5*discount_factor('2024') + 0.5*discount_factor('2026');

carbonprice(country_all,year) = carbonprice_year(year);

carbonprice('UK',year) = max(20.4, carbonprice('DE',year));
carbonprice('UK(GB)',year) = max(20.4, carbonprice('DE',year));
carbonprice('UK(NIE)',year) = max(20.4, carbonprice('DE',year));
Display carbonprice;

load_year('2025',country) = load_year('2025',country) * 1.1;
load_year('2030',country) = load_year('2030',country) * 1.1;
load_year('2040',country) = load_year('2040',country) * 1.1;

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

load_structure('2022',hour_all,country)$(hour('2020',hour_all)) = load_structure('2020',hour_all,country);
load_structure('2024',hour_all,country)$(hour('2025',hour_all)) = load_structure('2025',hour_all,country);
load_structure('2026',hour_all,country)$(hour('2025',hour_all)) = load_structure('2025',hour_all,country);
load_structure('2028',hour_all,country)$(hour('2030',hour_all)) = load_structure('2030',hour_all,country);
load_structure('2032',hour_all,country)$(hour('2030',hour_all)) = load_structure('2030',hour_all,country);
load_structure('2034',hour_all,country)$(hour('2030',hour_all)) = load_structure('2030',hour_all,country);
load_structure('2036',hour_all,country)$(hour('2030',hour_all)) = load_structure('2030',hour_all,country);
load_structure('2038',hour_all,country)$(hour('2040',hour_all)) = load_structure('2040',hour_all,country);
load_structure('2045',hour_all,country)$(hour('2040',hour_all)) = load_structure('2040',hour_all,country);
load_structure('2050',hour_all,country)$(hour('2040',hour_all)) = load_structure('2040',hour_all,country);
*Display load_structure;

first_hour('2022') = first_hour('2020');
first_hour('2024') = first_hour('2025');
first_hour('2026') = first_hour('2025');
first_hour('2028') = first_hour('2030');
first_hour('2032') = first_hour('2030');
first_hour('2034') = first_hour('2030');
first_hour('2036') = first_hour('2030');
first_hour('2038') = first_hour('2040');
first_hour('2045') = first_hour('2040');
first_hour('2050') = first_hour('2040');

last_hour('2022') = last_hour('2020');
last_hour('2024') = last_hour('2025');
last_hour('2026') = last_hour('2025');
last_hour('2028') = last_hour('2030');
last_hour('2032') = last_hour('2030');
last_hour('2034') = last_hour('2030');
last_hour('2036') = last_hour('2030');
last_hour('2038') = last_hour('2040');
last_hour('2045') = last_hour('2040');
last_hour('2050') = last_hour('2040');

hour('2022',hour_all) = hour('2020',hour_all);
hour('2024',hour_all) = hour('2025',hour_all);
hour('2026',hour_all) = hour('2025',hour_all);
hour('2028',hour_all) = hour('2030',hour_all);
hour('2032',hour_all) = hour('2030',hour_all);
hour('2034',hour_all) = hour('2030',hour_all);
hour('2036',hour_all) = hour('2030',hour_all);
hour('2038',hour_all) = hour('2040',hour_all);
hour('2045',hour_all) = hour('2040',hour_all);
hour('2050',hour_all) = hour('2040',hour_all);

step_hour('2022',hour_all)$(hour('2020',hour_all)) = step_hour('2020',hour_all);
step_hour('2024',hour_all)$(hour('2025',hour_all)) = step_hour('2025',hour_all);
step_hour('2026',hour_all)$(hour('2025',hour_all)) = step_hour('2025',hour_all);
step_hour('2028',hour_all)$(hour('2030',hour_all)) = step_hour('2030',hour_all);
step_hour('2032',hour_all)$(hour('2030',hour_all)) = step_hour('2030',hour_all);
step_hour('2034',hour_all)$(hour('2030',hour_all)) = step_hour('2030',hour_all);
step_hour('2036',hour_all)$(hour('2030',hour_all)) = step_hour('2030',hour_all);
step_hour('2038',hour_all)$(hour('2040',hour_all)) = step_hour('2040',hour_all);
step_hour('2045',hour_all)$(hour('2040',hour_all)) = step_hour('2040',hour_all);
step_hour('2050',hour_all)$(hour('2040',hour_all)) = step_hour('2040',hour_all);
*Display first_hour,last_hour,hour,step_hour;


map_hourmonth('2022',hour_all,month)$(hour('2020',hour_all)) = map_hourmonth('2020',hour_all,month);
map_hourmonth('2024',hour_all,month)$(hour('2025',hour_all)) = map_hourmonth('2025',hour_all,month);
map_hourmonth('2026',hour_all,month)$(hour('2025',hour_all)) = map_hourmonth('2025',hour_all,month);
map_hourmonth('2028',hour_all,month)$(hour('2030',hour_all)) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2032',hour_all,month)$(hour('2030',hour_all)) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2034',hour_all,month)$(hour('2030',hour_all)) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2036',hour_all,month)$(hour('2030',hour_all)) = map_hourmonth('2030',hour_all,month);
map_hourmonth('2038',hour_all,month)$(hour('2040',hour_all)) = map_hourmonth('2040',hour_all,month);
map_hourmonth('2045',hour_all,month)$(hour('2040',hour_all)) = map_hourmonth('2040',hour_all,month);
map_hourmonth('2050',hour_all,month)$(hour('2040',hour_all)) = map_hourmonth('2040',hour_all,month);
*Display map_hourmonth;

map_hourday('2022',hour_all,day)$(hour('2022',hour_all)) = map_hourday('2020',hour_all,day);
map_hourday('2024',hour_all,day)$(hour('2024',hour_all)) = map_hourday('2025',hour_all,day);
map_hourday('2026',hour_all,day)$(hour('2026',hour_all)) = map_hourday('2025',hour_all,day);
map_hourday('2028',hour_all,day)$(hour('2028',hour_all)) = map_hourday('2030',hour_all,day);
map_hourday('2030',hour_all,day)$(hour('2030',hour_all)) = map_hourday('2030',hour_all,day);
map_hourday('2032',hour_all,day)$(hour('2032',hour_all)) = map_hourday('2030',hour_all,day);
map_hourday('2034',hour_all,day)$(hour('2034',hour_all)) = map_hourday('2030',hour_all,day);
map_hourday('2036',hour_all,day)$(hour('2036',hour_all)) = map_hourday('2030',hour_all,day);
map_hourday('2038',hour_all,day)$(hour('2038',hour_all)) = map_hourday('2040',hour_all,day);
map_hourday('2040',hour_all,day)$(hour('2040',hour_all)) = map_hourday('2040',hour_all,day);
map_hourday('2045',hour_all,day)$(hour('2045',hour_all)) = map_hourday('2040',hour_all,day);
map_hourday('2050',hour_all,day)$(hour('2050',hour_all)) = map_hourday('2040',hour_all,day);
*Display hour,map_hourday;

peakind('2022',hour_all,country)$(hour('2020',hour_all)) = peakind('2020',hour_all,country);
peakind('2024',hour_all,country)$(hour('2025',hour_all)) = peakind('2025',hour_all,country);
peakind('2026',hour_all,country)$(hour('2025',hour_all)) = peakind('2025',hour_all,country);
peakind('2028',hour_all,country)$(hour('2030',hour_all)) = peakind('2030',hour_all,country);
peakind('2032',hour_all,country)$(hour('2030',hour_all)) = peakind('2030',hour_all,country);
peakind('2034',hour_all,country)$(hour('2030',hour_all)) = peakind('2030',hour_all,country);
peakind('2036',hour_all,country)$(hour('2030',hour_all)) = peakind('2030',hour_all,country);
peakind('2038',hour_all,country)$(hour('2040',hour_all)) = peakind('2040',hour_all,country);
peakind('2045',hour_all,country)$(hour('2040',hour_all)) = peakind('2040',hour_all,country);
peakind('2050',hour_all,country)$(hour('2040',hour_all)) = peakind('2040',hour_all,country);
*Display peakind;

load(country,year,hour_all)$(hour(year,hour_all)) = load_year(year,country) * load_structure(year,hour_all,country);
*Display load_year,load;

ntc(country,country2,year) = ntc_year(year,country,country2);

ntc(country,country2,'2022') = 0.6*ntc(country,country2,'2020') + 0.4*ntc(country,country2,'2025');
ntc(country,country2,'2024') = 0.2*ntc(country,country2,'2020') + 0.8*ntc(country,country2,'2025');
ntc(country,country2,'2026') = 0.8*ntc(country,country2,'2025') + 0.2*ntc(country,country2,'2030');
ntc(country,country2,'2028') = 0.4*ntc(country,country2,'2025') + 0.6*ntc(country,country2,'2030');
ntc(country,country2,'2032') = 0.8*ntc(country,country2,'2030') + 0.2*ntc(country,country2,'2040');
ntc(country,country2,'2034') = 0.6*ntc(country,country2,'2030') + 0.4*ntc(country,country2,'2040');
ntc(country,country2,'2036') = 0.4*ntc(country,country2,'2030') + 0.6*ntc(country,country2,'2040');
ntc(country,country2,'2038') = 0.2*ntc(country,country2,'2030') + 0.8*ntc(country,country2,'2040');
ntc(country,country2,'2050') = ntc(country,country2,'2040') + ((ntc(country,country2,'2040') - ntc(country,country2,'2030'))/(2040-2030))*(2050-2040);
ntc(country,country2,'2045') = 0.5*ntc(country,country2,'2040') + 0.5*ntc(country,country2,'2050');
*Display ntc;

ntc_hour(country,country2,year,hour_all)$(hour(year,hour_all)) = sum(month$(map_hourmonth(year,hour_all,month)), ntc_year_month(year,month,country,country2)) * (1 - indicator_dailyntc)
                                                                 +
                                                                 sum(day$(map_hourday(year,hour_all,day)), ntc_year_day(year,day,country,country2))*indicator_dailyntc;
*Display ntc_hour,ntc_year_day,map_hourday;

ntc_hour(country,country2,'2022',hour_all)$(hour('2020',hour_all)) = ntc(country,country2,'2022') * ( ntc_hour(country,country2,'2020',hour_all) / ntc(country,country2,'2020') );
ntc_hour(country,country2,'2024',hour_all)$(hour('2025',hour_all)) = ntc(country,country2,'2024') * ( ntc_hour(country,country2,'2025',hour_all) / ntc(country,country2,'2025') );
ntc_hour(country,country2,'2026',hour_all)$(hour('2025',hour_all)) = ntc(country,country2,'2026') * ( ntc_hour(country,country2,'2025',hour_all) / ntc(country,country2,'2025') );
ntc_hour(country,country2,'2028',hour_all)$(hour('2030',hour_all)) = ntc(country,country2,'2028') * ( ntc_hour(country,country2,'2030',hour_all) / ntc(country,country2,'2030') );
ntc_hour(country,country2,'2032',hour_all)$(hour('2030',hour_all)) = ntc(country,country2,'2032') * ( ntc_hour(country,country2,'2030',hour_all) / ntc(country,country2,'2030') );
ntc_hour(country,country2,'2034',hour_all)$(hour('2030',hour_all)) = ntc(country,country2,'2034') * ( ntc_hour(country,country2,'2030',hour_all) / ntc(country,country2,'2030') );
ntc_hour(country,country2,'2036',hour_all)$(hour('2030',hour_all)) = ntc(country,country2,'2036') * ( ntc_hour(country,country2,'2030',hour_all) / ntc(country,country2,'2030') );
ntc_hour(country,country2,'2038',hour_all)$(hour('2040',hour_all)) = ntc(country,country2,'2038') * ( ntc_hour(country,country2,'2040',hour_all) / ntc(country,country2,'2040') );
ntc_hour(country,country2,'2050',hour_all)$(hour('2040',hour_all)) = ntc(country,country2,'2050') * ( ntc_hour(country,country2,'2040',hour_all) / ntc(country,country2,'2040') );
ntc_hour(country,country2,'2045',hour_all)$(hour('2040',hour_all)) = ntc(country,country2,'2045') * ( ntc_hour(country,country2,'2040',hour_all) / ntc(country,country2,'2040') );
*Display hour,ntc_hour;

netexport_border(country,year,hour_all)$(hour(year,hour_all)) = borderflow(year,hour_all,country);
netexport_border(country,'2022',hour_all)$(hour('2020',hour_all)) = borderflow('2020',hour_all,country);
netexport_border(country,'2024',hour_all)$(hour('2025',hour_all)) = borderflow('2025',hour_all,country);
netexport_border(country,'2026',hour_all)$(hour('2025',hour_all)) = borderflow('2025',hour_all,country);
netexport_border(country,'2028',hour_all)$(hour('2030',hour_all)) = borderflow('2030',hour_all,country);
netexport_border(country,'2032',hour_all)$(hour('2030',hour_all)) = borderflow('2030',hour_all,country);
netexport_border(country,'2034',hour_all)$(hour('2030',hour_all)) = borderflow('2030',hour_all,country);
netexport_border(country,'2036',hour_all)$(hour('2030',hour_all)) = borderflow('2030',hour_all,country);
netexport_border(country,'2038',hour_all)$(hour('2040',hour_all)) = borderflow('2040',hour_all,country);
netexport_border(country,'2050',hour_all)$(hour('2040',hour_all)) = borderflow('2040',hour_all,country);
netexport_border(country,'2045',hour_all)$(hour('2040',hour_all)) = borderflow('2040',hour_all,country);
*Display borderflow,netexport_border;

*conv parameters
plannedoutages_conv(country,conv,year) = outages_conv('planned_outages',conv,year,country)*indicator_countryavail + inputdata_conv(conv,'planned_outages')*(1 - indicator_countryavail);
plannedoutages_conv(country,conv,'2022') = plannedoutages_conv(country,conv,'2020');
plannedoutages_conv(country,conv,'2024') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2026') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2028') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2032') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2034') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2036') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2038') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2050') = plannedoutages_conv(country,conv,'2025');
plannedoutages_conv(country,conv,'2045') = plannedoutages_conv(country,conv,'2025');

forcedoutages_conv(country,conv,year) = outages_conv('forced_outages',conv,year,country)*indicator_countryavail + inputdata_conv(conv,'forced_outages')*(1 - indicator_countryavail);
forcedoutages_conv(country,conv,'2022') = forcedoutages_conv(country,conv,'2020');
forcedoutages_conv(country,conv,'2024') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2026') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2028') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2032') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2034') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2036') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2038') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2050') = forcedoutages_conv(country,conv,'2025');
forcedoutages_conv(country,conv,'2045') = forcedoutages_conv(country,conv,'2025');

cfix_conv(conv,year) = inputdata_conv(conv,'cfix') * 1000 * (1/discount_factor(year));
cinv_conv(conv,year) = ( inputdata_conv(conv,'covernight') * 1000 ) * ( power((1 + interest_rate), inputdata_conv(conv,'lifetime_eco')) * interest_rate ) / ( power((1 + interest_rate), inputdata_conv(conv,'lifetime_eco')) - 1 ) * (1/discount_factor(year));
ccurt_load_year(year) = ccurt_load * (1/discount_factor(year));
ccurt_renew_year(year) = ccurt_renew * (1/discount_factor(year));
*Display cfix_conv,cinv_conv;

convyear_lo(conv) = inputdata_conv(conv,'year_lo');
convyear_up(conv) = inputdata_conv(conv,'year_up');
*Display convyear_lo,convyear_up;

efficiency_conv_full(country,conv,year) = inputdata_conv(conv,'efficiency')*(1 - indicator_countryefficiency)
                                          +
                                          ( eff_conv_old(country,conv,year) * indicator_countryefficiency * (1 - indicator_coalphaseout) )$(convyear_up(conv) lt 2020)
                                          +
                                          ( eff_conv_old_phaseout(country,conv,year) * indicator_countryefficiency * indicator_coalphaseout )$(convyear_up(conv) lt 2020)
                                          +
                                          (inputdata_conv(conv,'efficiency')*indicator_countryefficiency)$(convyear_up(conv) ge 2022)
;
Display efficiency_conv_full;
efficiency_conv_full(country,conv,year)$(map_convfuel(conv,'hardcoal')) = inputdata_conv(conv,'efficiency')*(1 - indicator_countryefficiency)
                                                                          +
                                                                          ( eff_conv_old(country,conv,year) * indicator_countryefficiency )$(convyear_up(conv) lt 2020)
                                                                          +
                                                                          (inputdata_conv(conv,'efficiency')*indicator_countryefficiency)$(convyear_up(conv) ge 2022)
;
Display efficiency_conv_full;


efficiency_conv_min(country,conv,year) = efficiency_conv_full(country,conv,year) - inputdata_conv(conv,'efficiency_loss_pt') - efficiency_conv_full(country,conv,year)*inputdata_conv(conv,'efficiency_loss');
efficiency_conv_avg(country,conv,year) = ( inputdata_conv(conv,'share_fullload') * efficiency_conv_full(country,conv,year) + ( 1 - inputdata_conv(conv,'share_fullload') ) * efficiency_conv_min(country,conv,year) )$(efficiency_conv_full(country,conv,year));
*Display efficiency_conv_full,efficiency_conv_min,efficiency_conv_avg;

fuelprice_countryfactor(country,year,fuel_conv) = (1*0.75 + fuelprice_countryfactor(country,'2017',fuel_conv)*0.25)$(indicator_fuelprice_countryfactor eq 1) + 1$(indicator_fuelprice_countryfactor eq 0);
fuelprice_conv(country,fuel_conv,year) = fuelprice_conv_year(year,fuel_conv) * fuelprice_countryfactor(country,year,fuel_conv);
Display fuelprice_countryfactor,fuelprice_conv;


*Display fuelprice_countryfactor,fuelprice_conv_year;
Display fuelprice_conv;

gmin_conv(conv) = inputdata_conv(conv,'gmin');
cramp_conv(country,conv,year) = inputdata_conv(conv,'startup_fuelconsumption') * sum(fuel_conv$(map_convfuel(conv,fuel_conv)), fuelprice_conv(country,fuel_conv,year)) + inputdata_conv(conv,'startup_fixcost')*(1/discount_factor(year));
*Display cramp_conv;

cvar_conv_full(country,conv,year) = (( sum(fuel_conv$(map_convfuel(conv,fuel_conv)), fuelprice_conv(country,fuel_conv,year) + carboncontent_conv(fuel_conv)*carbonprice(country,year) ) / efficiency_conv_full(country,conv,year) ) + inputdata_conv(conv,'cvarom')*indicator_varomcost)$(efficiency_conv_full(country,conv,year)) ;
cvar_conv_min(country,conv,year) = (( sum(fuel_conv$(map_convfuel(conv,fuel_conv)), fuelprice_conv(country,fuel_conv,year) + carboncontent_conv(fuel_conv)*carbonprice(country,year) ) / efficiency_conv_min(country,conv,year) ) + inputdata_conv(conv,'cvarom')*indicator_varomcost)$(efficiency_conv_full(country,conv,year)) ;
cvar_conv_avg(country,conv,year) = (( sum(fuel_conv$(map_convfuel(conv,fuel_conv)), fuelprice_conv(country,fuel_conv,year) + carboncontent_conv(fuel_conv)*carbonprice(country,year) ) / efficiency_conv_avg(country,conv,year) ) + inputdata_conv(conv,'cvarom')*indicator_varomcost)$(efficiency_conv_full(country,conv,year)) ;

cvar_conv_full(country,conv,year) = (cvar_conv_full(country,conv,year)*(1/discount_factor(year)))$(efficiency_conv_full(country,conv,year));
cvar_conv_min(country,conv,year) = (cvar_conv_min(country,conv,year)*(1/discount_factor(year)))$(efficiency_conv_full(country,conv,year));
cvar_conv_avg(country,conv,year) = (cvar_conv_avg(country,conv,year)*(1/discount_factor(year)))$(efficiency_conv_full(country,conv,year));

*Display cvar_conv_full,cvar_conv_min,cvar_conv_avg;
Display cvar_conv_full;

emf_conv_full(country,conv,year) = ( sum(fuel_conv$(map_convfuel(conv,fuel_conv)), carboncontent_conv(fuel_conv)) / efficiency_conv_full(country,conv,year) ) * ( 1 - inputdata_conv(conv,'carbon_sequestration') )$(efficiency_conv_full(country,conv,year));
emf_conv_min(country,conv,year) = ( sum(fuel_conv$(map_convfuel(conv,fuel_conv)), carboncontent_conv(fuel_conv)) / efficiency_conv_min(country,conv,year) ) * ( 1 - inputdata_conv(conv,'carbon_sequestration') )$(efficiency_conv_full(country,conv,year));
emf_conv_avg(country,conv,year) = ( inputdata_conv(conv,'share_fullload') * emf_conv_full(country,conv,year) + ( 1 - inputdata_conv(conv,'share_fullload') ) * emf_conv_min(country,conv,year) )$(emf_conv_full(country,conv,year));
*Display cfix_conv,cinv_conv,convyear_lo,convyear_up,efficiency_conv_full,efficiency_conv_min,efficiency_conv_avg,gmin_conv,fuelprice_conv,cramp_conv,cvar_conv_full,cvar_conv_min,cvar_conv_avg,emf_conv_full,emf_conv_min,emf_conv_avg;
*Display cap_conv_install_old,cap_conv_install_old_phaseout;

cap_conv_install_old(country,conv,year) = cap_conv_install_old(country,conv,year) * (1 - indicator_coalphaseout)
                                          +
                                          cap_conv_install_old_phaseout(country,conv,year) * indicator_coalphaseout;

cap_conv_install_old(country,conv,year)$(map_convfuel(conv,'hardcoal')) = cap_conv_install_old(country,conv,year) + EPS;


*Display cap_conv_install_old;


year('2025') = NO;
Loop(conv$(convyear_up(conv) lt 2020 ),
   Loop(year$(ord(year) gt 1),
      cap_conv_sub_old(country,conv,year) = cap_conv_install_old(country,conv,year - 1) - cap_conv_install_old(country,conv,year)
   );
);
*Display cap_conv_sub_old;

year('2025') = YES;

*renew parameters
capfactor_renew_max(country,'solar',year,hour_all)$(hour(year,hour_all)) = capfactor_solar(year,hour_all,country);
capfactor_renew_max(country,'windonshore',year,hour_all)$(hour(year,hour_all)) = capfactor_windonshore(year,hour_all,country);
capfactor_renew_max(country,'windoffshore',year,hour_all)$(hour(year,hour_all)) = capfactor_windoffshore(year,hour_all,country);
capfactor_renew_max(country,'runofriver',year,hour_all)$(hour(year,hour_all)) = capfactor_runofriver(year,hour_all,country);
capfactor_renew_max(country,'reservoir',year,hour_all)$(hour(year,hour_all)) = capfactor_reservoir_max(year,hour_all,country);
capfactor_renew_min(country,'reservoir',year,hour_all)$(hour(year,hour_all)) = capfactor_reservoir_min(year,hour_all,country);

capfactor_renew_max(country,'solar','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_max(country,'solar','2020',hour_all);
capfactor_renew_max(country,'solar','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'solar','2025',hour_all);
capfactor_renew_max(country,'solar','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'solar','2025',hour_all);
capfactor_renew_max(country,'solar','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'solar','2030',hour_all);
capfactor_renew_max(country,'solar','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'solar','2040',hour_all);
capfactor_renew_max(country,'solar','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'solar','2040',hour_all);
capfactor_renew_max(country,'solar','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'solar','2040',hour_all);

capfactor_renew_max(country,'windonshore','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_max(country,'windonshore','2020',hour_all);
capfactor_renew_max(country,'windonshore','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'windonshore','2025',hour_all);
capfactor_renew_max(country,'windonshore','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'windonshore','2025',hour_all);
capfactor_renew_max(country,'windonshore','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windonshore','2030',hour_all);
capfactor_renew_max(country,'windonshore','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windonshore','2040',hour_all);
capfactor_renew_max(country,'windonshore','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windonshore','2040',hour_all);
capfactor_renew_max(country,'windonshore','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windonshore','2040',hour_all);

capfactor_renew_max(country,'windoffshore','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_max(country,'windoffshore','2020',hour_all);
capfactor_renew_max(country,'windoffshore','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'windoffshore','2025',hour_all);
capfactor_renew_max(country,'windoffshore','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'windoffshore','2025',hour_all);
capfactor_renew_max(country,'windoffshore','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'windoffshore','2030',hour_all);
capfactor_renew_max(country,'windoffshore','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windoffshore','2040',hour_all);
capfactor_renew_max(country,'windoffshore','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windoffshore','2040',hour_all);
capfactor_renew_max(country,'windoffshore','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'windoffshore','2040',hour_all);

capfactor_renew_max(country,'windoffshore',year,hour_all)$(sum(hour_all2, capfactor_renew_max(country,'windoffshore',year,hour_all2)) eq 0) = capfactor_renew_max(country,'windonshore',year,hour_all);

capfactor_renew_max(country,'runofriver','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_max(country,'runofriver','2020',hour_all);
capfactor_renew_max(country,'runofriver','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'runofriver','2025',hour_all);
capfactor_renew_max(country,'runofriver','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'runofriver','2025',hour_all);
capfactor_renew_max(country,'runofriver','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'runofriver','2030',hour_all);
capfactor_renew_max(country,'runofriver','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'runofriver','2040',hour_all);
capfactor_renew_max(country,'runofriver','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'runofriver','2040',hour_all);
capfactor_renew_max(country,'runofriver','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'runofriver','2040',hour_all);

capfactor_renew_max(country,'reservoir','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_max(country,'reservoir','2020',hour_all);
capfactor_renew_max(country,'reservoir','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'reservoir','2025',hour_all);
capfactor_renew_max(country,'reservoir','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_max(country,'reservoir','2025',hour_all);
capfactor_renew_max(country,'reservoir','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'reservoir','2030',hour_all);
capfactor_renew_max(country,'reservoir','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'reservoir','2030',hour_all);
capfactor_renew_max(country,'reservoir','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'reservoir','2030',hour_all);
capfactor_renew_max(country,'reservoir','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_max(country,'reservoir','2030',hour_all);
capfactor_renew_max(country,'reservoir','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'reservoir','2040',hour_all);
capfactor_renew_max(country,'reservoir','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'reservoir','2040',hour_all);
capfactor_renew_max(country,'reservoir','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_max(country,'reservoir','2040',hour_all);

capfactor_renew_min(country,'reservoir','2022',hour_all)$(hour('2020',hour_all)) = capfactor_renew_min(country,'reservoir','2020',hour_all);
capfactor_renew_min(country,'reservoir','2024',hour_all)$(hour('2025',hour_all)) = capfactor_renew_min(country,'reservoir','2025',hour_all);
capfactor_renew_min(country,'reservoir','2026',hour_all)$(hour('2025',hour_all)) = capfactor_renew_min(country,'reservoir','2025',hour_all);
capfactor_renew_min(country,'reservoir','2028',hour_all)$(hour('2030',hour_all)) = capfactor_renew_min(country,'reservoir','2030',hour_all);
capfactor_renew_min(country,'reservoir','2032',hour_all)$(hour('2030',hour_all)) = capfactor_renew_min(country,'reservoir','2030',hour_all);
capfactor_renew_min(country,'reservoir','2034',hour_all)$(hour('2030',hour_all)) = capfactor_renew_min(country,'reservoir','2030',hour_all);
capfactor_renew_min(country,'reservoir','2036',hour_all)$(hour('2030',hour_all)) = capfactor_renew_min(country,'reservoir','2030',hour_all);
capfactor_renew_min(country,'reservoir','2038',hour_all)$(hour('2040',hour_all)) = capfactor_renew_min(country,'reservoir','2040',hour_all);
capfactor_renew_min(country,'reservoir','2045',hour_all)$(hour('2040',hour_all)) = capfactor_renew_min(country,'reservoir','2040',hour_all);
capfactor_renew_min(country,'reservoir','2050',hour_all)$(hour('2040',hour_all)) = capfactor_renew_min(country,'reservoir','2040',hour_all);
*Display capfactor_renew_max,capfactor_renew_min;

cfix_renew(renew,year) = inputdata_renew(renew,'cfix') * 1000 * (1/discount_factor(year));
cinv_renew(renew,year) = ( covernight_renew(renew,year) * 1000 ) * (1/discount_factor(year)) * ( power((1 + interest_rate), inputdata_renew(renew,'lifetime_eco')) * interest_rate ) / ( power((1 + interest_rate), inputdata_renew(renew,'lifetime_eco')) - 1 );
efficiency_renew(renew) = inputdata_renew(renew,'efficiency');
*Display cfix_renew,cinv_renew,efficiency_renew;

fuelprice_renew('2022',fuel_renew) = 0.6*fuelprice_renew('2020',fuel_renew) + 0.4*fuelprice_renew('2025',fuel_renew);
fuelprice_renew('2024',fuel_renew) = 0.2*fuelprice_renew('2020',fuel_renew) + 0.8*fuelprice_renew('2025',fuel_renew);
fuelprice_renew('2026',fuel_renew) = 0.8*fuelprice_renew('2025',fuel_renew) + 0.2*fuelprice_renew('2030',fuel_renew);
fuelprice_renew('2028',fuel_renew) = 0.4*fuelprice_renew('2025',fuel_renew) + 0.6*fuelprice_renew('2030',fuel_renew);
fuelprice_renew('2032',fuel_renew) = 0.8*fuelprice_renew('2030',fuel_renew) + 0.2*fuelprice_renew('2040',fuel_renew);
fuelprice_renew('2034',fuel_renew) = 0.6*fuelprice_renew('2030',fuel_renew) + 0.4*fuelprice_renew('2040',fuel_renew);
fuelprice_renew('2036',fuel_renew) = 0.4*fuelprice_renew('2030',fuel_renew) + 0.6*fuelprice_renew('2040',fuel_renew);
fuelprice_renew('2038',fuel_renew) = 0.2*fuelprice_renew('2030',fuel_renew) + 0.8*fuelprice_renew('2040',fuel_renew);
fuelprice_renew('2050',fuel_renew) = fuelprice_renew('2040',fuel_renew) + ((fuelprice_renew('2040',fuel_renew) - fuelprice_renew('2030',fuel_renew))/(2040-2030))*(2050-2040);
fuelprice_renew('2045',fuel_renew) = 0.5*fuelprice_renew('2040',fuel_renew) + 0.5*fuelprice_renew('2050',fuel_renew);

cvar_renew(country,renew,year) = ( sum(fuel_renew$(map_renewfuel(renew,fuel_renew)), fuelprice_renew(year,fuel_renew) + carboncontent_renew(fuel_renew)*carbonprice(country,year) ) / efficiency_renew(renew) )$(efficiency_renew(renew)) + inputdata_renew(renew,'cvarom');
cvar_renew(country,renew,year) = cvar_renew(country,renew,year) * (1/discount_factor(year));
*Display fuelprice_renew,cvar_renew;

emf_renew(renew) = ( sum(fuel_renew$(map_renewfuel(renew,fuel_renew)), carboncontent_renew(fuel_renew)) / efficiency_renew(renew) )$(efficiency_renew(renew));
emf_renew_countryyear(country,renew,year) = emf_renew(renew);
*Display emf_renew;

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

gen_renew_exogen(country,renew,year) = gen_renew_all_year(renew,year,country)*1 + gen_renew_main_year(renew,year,country)*0;

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
*Display gen_renew_exogen;

gen_renew_exogen(country,'runofriver','2045') = gen_renew_exogen(country,'runofriver','2040');
gen_renew_exogen(country,'runofriver','2050') = gen_renew_exogen(country,'runofriver','2040');

gen_renew_exogen(country,'reservoir','2045') = gen_renew_exogen(country,'reservoir','2040');
gen_renew_exogen(country,'reservoir','2050') = gen_renew_exogen(country,'reservoir','2040');

gen_renew_exogen(country,'bioenergy','2045') = gen_renew_exogen(country,'bioenergy','2040');
gen_renew_exogen(country,'bioenergy','2050') = gen_renew_exogen(country,'bioenergy','2040');

gen_renew_exogen(country,'waste','2045') = gen_renew_exogen(country,'waste','2040');
gen_renew_exogen(country,'waste','2050') = gen_renew_exogen(country,'waste','2040');
*Display gen_renew_exogen;

cap_renew_install_exogen2(country,'solar',year)$(gen_renew_exogen(country,'solar',year) gt 0) = (gen_renew_exogen(country,'solar',year) * 1000) / ( sum(hour(year,hour_all), capfactor_renew_max(country,'solar',year,hour_all)) * (8760 / sum(hour(year,hour_all), 1)) );
cap_renew_install_exogen2(country,'windonshore',year)$(gen_renew_exogen(country,'windonshore',year) gt 0) = (gen_renew_exogen(country,'windonshore',year) * 1000) / ( sum(hour(year,hour_all), capfactor_renew_max(country,'windonshore',year,hour_all)) * (8760 / sum(hour(year,hour_all), 1)) );
cap_renew_install_exogen2(country,'windoffshore',year)$(gen_renew_exogen(country,'windoffshore',year) gt 0) = (gen_renew_exogen(country,'windoffshore',year) * 1000) / ( sum(hour(year,hour_all), capfactor_renew_max(country,'windoffshore',year,hour_all)) * (8760 / sum(hour(year,hour_all), 1)) );
cap_renew_install_exogen2(country,'runofriver',year)$(gen_renew_exogen(country,'runofriver',year) gt 0) = (gen_renew_exogen(country,'runofriver',year) * 1000) / ( sum(hour(year,hour_all), capfactor_renew_max(country,'runofriver',year,hour_all)) * (8760 / sum(hour(year,hour_all), 1)) );

gen_renew_exogen2(country,'solar',year)$(gen_renew_exogen(country,'solar',year) gt 0) = sum(hour(year,hour_all), cap_renew_install_exogen2(country,'solar',year) *  ( capfactor_renew_max(country,'solar',year,hour_all) / 1000 ) )  * (8760 / sum(hour(year,hour_all), 1));
gen_renew_exogen2(country,'windonshore',year)$(gen_renew_exogen(country,'windonshore',year) gt 0) = sum(hour(year,hour_all), cap_renew_install_exogen2(country,'windonshore',year) *  ( capfactor_renew_max(country,'windonshore',year,hour_all) / 1000 ) )  * (8760 / sum(hour(year,hour_all), 1));
gen_renew_exogen2(country,'windoffshore',year)$(gen_renew_exogen(country,'windoffshore',year) gt 0) = sum(hour(year,hour_all), cap_renew_install_exogen2(country,'windoffshore',year) *  ( capfactor_renew_max(country,'windoffshore',year,hour_all) / 1000 ) )  * (8760 / sum(hour(year,hour_all), 1));
gen_renew_exogen2(country,'runofriver',year)$(gen_renew_exogen(country,'runofriver',year) gt 0) = sum(hour(year,hour_all), cap_renew_install_exogen2(country,'runofriver',year) *  ( capfactor_renew_max(country,'runofriver',year,hour_all) / 1000 ) )  * (8760 / sum(hour(year,hour_all), 1));
*Display cap_renew_install_exogen,cap_renew_install_exogen2,gen_renew_exogen,gen_renew_exogen2;

cap_renew_install_exogen(country,'solar',year) = cap_renew_install_exogen2(country,'solar',year);
cap_renew_install_exogen(country,'windonshore',year) = cap_renew_install_exogen2(country,'windonshore',year);
cap_renew_install_exogen(country,'windoffshore',year) = cap_renew_install_exogen2(country,'windoffshore',year);
cap_renew_install_exogen(country,'runofriver',year) = cap_renew_install_exogen2(country,'runofriver',year);
*Display capfactor_renew_max,gen_renew_exogen,gen_renew_exogen2;

year('2025') = NO;
Loop(year$(ord(year) gt 1),
         cap_renew_add_exogen(country,renew,year) = cap_renew_install_exogen(country,renew,year) - cap_renew_install_exogen(country,renew,year - 1);
);

*Display cap_renew_install_exogen,cap_renew_add_exogen,gen_renew_exogen;
year('2025') = YES;

capfactor_renew_max(country,'geothermal',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'geothermal',year) gt 0)) = ( gen_renew_exogen(country,'geothermal',year) * 1000 ) / ( cap_renew_install_exogen(country,'geothermal',year) * 8760 );
capfactor_renew_max(country,'marine',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'marine',year) gt 0)) = ( gen_renew_exogen(country,'marine',year) * 1000 ) / ( cap_renew_install_exogen(country,'marine',year) * 8760 );
capfactor_renew_max(country,'othergas',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'othergas',year) gt 0)) = ( gen_renew_exogen(country,'othergas',year) * 1000 ) / ( cap_renew_install_exogen(country,'othergas',year) * 8760 );


*Display capfactor_renew_max;

renew_disp(renew)$(inputdata_renew(renew,'renew_disp') eq 1) = YES;
renew_ndisp(renew)$(inputdata_renew(renew,'renew_disp') eq 0) = YES;
renew_curt(renew)$(inputdata_renew(renew,'renew_curt') eq 1) = YES;
renew_ncurt(renew)$((inputdata_renew(renew,'renew_curt') eq 0) AND (inputdata_renew(renew,'renew_disp') eq 0)) = YES;
*Display renew_disp,renew_ndisp,renew_curt,renew_ncurt;

fuelpotential_renew(country,renew_disp,year) = (( gen_renew_exogen(country,renew_disp,year) * 1000 ) / efficiency_renew(renew_disp)) + EPS;
gen_renew_structure_monthly(country,renew_disp,year,month) = gen_renew_structure_monthly_exogen(renew_disp,'2017',month,country) + EPS;
*Display gen_renew_exogen,gen_renew_structure_monthly,fuelpotential_renew;

gen_renew_exogen2(country,'runofriver',year) = sum(hour(year,hour_all), capfactor_renew_max(country,'runofriver',year,hour_all) * (cap_renew_install_exogen(country,'runofriver',year) / 1000)) * (8760 / sum(hour(year,hour_all), 1)) + EPS;
gen_renew_exogen2(country,'reservoir',year) = (fuelpotential_renew(country,'reservoir',year)/1000) * efficiency_renew('reservoir') + EPS;
*Display gen_renew_exogen,gen_renew_exogen2,cap_renew_install_exogen;

*stor parameters
avail_stor(stor) = inputdata_stor(stor,'avail');
cap_stor_install_exogen(country,stor,year) = cap_stor_install_exogen_year(stor,year,country);

cap_stor_install_exogen(country,stor,'2022') = 0.6*cap_stor_install_exogen(country,stor,'2020') + 0.4*cap_stor_install_exogen(country,stor,'2025');
cap_stor_install_exogen(country,stor,'2024') = 0.2*cap_stor_install_exogen(country,stor,'2020') + 0.8*cap_stor_install_exogen(country,stor,'2025');
cap_stor_install_exogen(country,stor,'2026') = 0.8*cap_stor_install_exogen(country,stor,'2025') + 0.2*cap_stor_install_exogen(country,stor,'2030');
cap_stor_install_exogen(country,stor,'2028') = 0.4*cap_stor_install_exogen(country,stor,'2025') + 0.6*cap_stor_install_exogen(country,stor,'2030');
cap_stor_install_exogen(country,stor,'2032') = 0.8*cap_stor_install_exogen(country,stor,'2030') + 0.2*cap_stor_install_exogen(country,stor,'2040');
cap_stor_install_exogen(country,stor,'2034') = 0.6*cap_stor_install_exogen(country,stor,'2030') + 0.4*cap_stor_install_exogen(country,stor,'2040');
cap_stor_install_exogen(country,stor,'2036') = 0.4*cap_stor_install_exogen(country,stor,'2030') + 0.6*cap_stor_install_exogen(country,stor,'2040');
cap_stor_install_exogen(country,stor,'2038') = 0.2*cap_stor_install_exogen(country,stor,'2030') + 0.8*cap_stor_install_exogen(country,stor,'2040');
cap_stor_install_exogen(country,stor,'2050') = cap_stor_install_exogen(country,stor,'2040') + ((cap_stor_install_exogen(country,stor,'2040') - cap_stor_install_exogen(country,stor,'2030'))/(2040-2030))*(2050-2040);
cap_stor_install_exogen(country,stor,'2045') = 0.5*cap_stor_install_exogen(country,stor,'2040') + 0.5*cap_stor_install_exogen(country,stor,'2050');

cfix_stor(stor,year) = inputdata_stor(stor,'cfix') * 1000 * (1/discount_factor(year));
cinv_MW_stor(stor,year) = ( covernight_kW_stor(stor,year) * 1000 ) * (1/discount_factor(year)) * ( power((1 + interest_rate), inputdata_stor(stor,'lifetime_eco')) * interest_rate ) / ( power((1 + interest_rate), inputdata_stor(stor,'lifetime_eco')) - 1 );
cinv_MWh_stor(stor,year) = ( covernight_kWh_stor(stor,year) * 1000 ) * (1/discount_factor(year)) * ( power((1 + interest_rate), inputdata_stor(stor,'lifetime_eco')) * interest_rate ) / ( power((1 + interest_rate), inputdata_stor(stor,'lifetime_eco')) - 1 );
efficiency_stor(stor) = inputdata_stor(stor,'efficiency');
storageduration(stor) = inputdata_stor(stor,'storageduration');
*Display avail_stor,cap_stor_install_exogen,cap_stor_install_exogen_year,cfix_stor,cinv_MW_stor,cinv_MWh_stor,efficiency_stor,storageduration;

$ontext
*other parameters
emissioncap('2017') = sum(country,
                         sum(conv$(emf_conv_avg(country,conv,'2017') gt 0),
                                 gen_conv_old(country,conv,'2017') * 1000 * emf_conv_avg(country,conv,'2017')
                         )

                         +

                         sum(renew$(emf_renew(renew) gt 0),
                                 gen_renew_exogen(country,renew,'2017') * 1000 * emf_renew(renew)
                         )
                      )
;

emissioncap(year) = emissioncap('2017') * emissionreduction(year);
*Display emissionreduction,emissioncap;
$offtext


*#####################################################
*Calibration of chp data
chp_structure_hour(country,year,hour_all)$(hour(year,hour_all)) = ( chp_structure(year,hour_all,country) * (1 - indicator_chp_trimmed) + chp_trimmed_structure(year,hour_all,country) * indicator_chp_trimmed ) / 1000 + EPS;

chp_structure_hour(country,'2022',hour_all)$(hour('2020',hour_all)) =chp_structure_hour(country,'2020',hour_all);
chp_structure_hour(country,'2024',hour_all)$(hour('2025',hour_all)) = chp_structure_hour(country,'2025',hour_all);
chp_structure_hour(country,'2026',hour_all)$(hour('2025',hour_all)) = chp_structure_hour(country,'2025',hour_all);
chp_structure_hour(country,'2028',hour_all)$(hour('2030',hour_all)) = chp_structure_hour(country,'2030',hour_all);
chp_structure_hour(country,'2032',hour_all)$(hour('2030',hour_all)) = chp_structure_hour(country,'2030',hour_all);
chp_structure_hour(country,'2034',hour_all)$(hour('2030',hour_all)) = chp_structure_hour(country,'2030',hour_all);
chp_structure_hour(country,'2036',hour_all)$(hour('2030',hour_all)) = chp_structure_hour(country,'2030',hour_all);
chp_structure_hour(country,'2038',hour_all)$(hour('2040',hour_all)) = chp_structure_hour(country,'2040',hour_all);
chp_structure_hour(country,'2045',hour_all)$(hour('2040',hour_all)) = chp_structure_hour(country,'2040',hour_all);
chp_structure_hour(country,'2050',hour_all)$(hour('2040',hour_all)) = chp_structure_hour(country,'2040',hour_all);
*Display chp_structure_hour;

Loop(conv$(convyear_up(conv) lt 2020),
   flh_chp_conv(country,conv)$(gen_CHP_conv_old(country,conv,'2017','elec') gt 0) = gen_CHP_conv_old(country,conv,'2017','elec') * 1000 / cap_conv_install_old(country,conv,'2017');
);
*Display gen_CHP_conv_old,cap_conv_install_old,flh_chp_conv;

*Calibration for new power plants
Loop(convgrouped,
   Loop(conv$( map_convgrouped(conv,convgrouped) AND ( convyear_lo(conv) ge 2020 ) ),
      flh_chp_conv(country,conv)$( sum(conv2$( map_convgrouped(conv2,convgrouped) AND ( convyear_up(conv2) le 2017 ) ), gen_CHP_conv_old(country,conv2,'2017','elec') ) gt 0) =
         sum(conv2$( map_convgrouped(conv2,convgrouped) AND ( convyear_up(conv2) le 2017 ) ), gen_CHP_conv_old(country,conv2,'2017','elec') * 1000 ) / sum(conv2$( map_convgrouped(conv2,convgrouped) AND ( convyear_up(conv2) le 2017 ) ), cap_conv_install_old(country,conv2,'2017') )*indicator_futurechp;
   );
);
*Display flh_chp_conv;
*Display gen_CHP_renew_exogen,cap_renew_install_exogen;
flh_chp_renew(country,renew)$((gen_CHP_renew_all('elec',renew,'2017',country) + gen_CHP_renew_main('elec',renew,'2017',country))  gt 0) = ( ( ( gen_CHP_renew_all('elec',renew,'2017',country)*1 + gen_CHP_renew_main('elec',renew,'2017',country)*0) * 1000 ) / cap_renew_install_exogen(country,renew,'2017') ) + EPS;
*Display flh_chp_renew;

indicator_divestment_country(country) = indicator_divestment;
*indicator_divestment_country(country)$(country_collection(country,'DE+neighbours') eq 1) = indicator_divestment;
*indicator_divestment_country('DE') = indicator_divestment;

indicator_partload_country(country) = indicator_partload;
*indicator_partload_country(country)$(country_collection(country,'DE+neighbours') eq 1) = indicator_partload;
*indicator_partload_country('DE') = indicator_partload;

indicator_ramping_country(country) = indicator_ramping;
*indicator_ramping_country(country)$(country_collection(country,'DE+neighbours') eq 1) = indicator_ramping;
*indicator_ramping_country('DE') = indicator_ramping;

*Display indicator_divestment_country,indicator_partload_country,indicator_ramping_country;

*################################################################################################################################
*Calculation of montly availability factors

Parameters
resload(country_all,year_all,hour_all)
max_monthlyload(year_all,month,country_all)
max_monthlyresload(year_all,month,country_all)
sum_max_monthlyload(year_all,country_all)
sum_max_monthlyresload(year_all,country_all)
avail_month_structure_load(year_all,month,country_all)
avail_month_structure_resload(year_all,month,country_all)
sum_avail_month_structure_load(year_all,country_all)
sum_avail_month_structure_resload(year_all,country_all)
number_over_threshold_load(year_all,country_all)
number_over_threshold_resload(year_all,country_all)
counter
correction_factor_load(year_all,country_all)
correction_factor_resload(year_all,country_all)
;

*Display avail_month_structure;

resload(country,year,hour_all)$(hour(year,hour_all)) = load(country,year,hour_all)
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

max_monthlyload(year,month,country) = smax(hour_all$(hour(year,hour_all) AND map_hourmonth(year,hour_all,month)), load(country,year,hour_all)) + EPS;
max_monthlyresload(year,month,country) = smax(hour_all$(hour(year,hour_all) AND map_hourmonth(year,hour_all,month)), resload(country,year,hour_all)) + EPS;


sum_max_monthlyload(year,country) = sum(month, max_monthlyload(year,month,country)) + EPS;
sum_max_monthlyresload(year,country) = sum(month, max_monthlyresload(year,month,country)) + EPS;

avail_month_structure_load(year,month,country) = (max_monthlyload(year,month,country) /  sum_max_monthlyload(year,country)) * 12 + EPS;
avail_month_structure_resload(year,month,country) = (max_monthlyresload(year,month,country) /  sum_max_monthlyresload(year,country)) * 12 + EPS;

*Display max_monthlyload,max_monthlyresload,avail_month_structure_load,avail_month_structure_resload;

avail_month_structure_load(year,month,country) = min(avail_month_structure_load(year,month,country), 1/0.85) + EPS;
avail_month_structure_resload(year,month,country) = min(avail_month_structure_resload(year,month,country), 1/0.85) + EPS;

sum_avail_month_structure_load(year,country) = sum(month, avail_month_structure_load(year,month,country)) + EPS;
sum_avail_month_structure_resload(year,country) = sum(month, avail_month_structure_resload(year,month,country)) + EPS;
*Display avail_month_structure_load,avail_month_structure_resload,sum_avail_month_structure_load,sum_avail_month_structure_resload;

Loop((year,country),
   counter = 0;
   Loop(month$(avail_month_structure_load(year,month,country) gt 1.15),
         counter = counter + 1;
   );
   number_over_threshold_load(year,country) = counter;

   counter = 0;
   Loop(month$(avail_month_structure_resload(year,month,country) gt 1.15),
         counter = counter + 1;
   );
   number_over_threshold_resload(year,country) = counter;
);

correction_factor_load(year,country) = (( 12 - sum_avail_month_structure_load(year,country) ) / ( 12 - number_over_threshold_load(year,country) ))$(number_over_threshold_load(year,country) gt 0) + EPS;
correction_factor_resload(year,country) = (( 12 - sum_avail_month_structure_resload(year,country) ) / ( 12 - number_over_threshold_resload(year,country) ))$(number_over_threshold_resload(year,country) gt 0) + EPS;
*Display number_over_threshold_load,number_over_threshold_resload,correction_factor_load,correction_factor_resload;

Loop((year,country),
   Loop(month$(avail_month_structure_load(year,month,country) le 1.15),
         avail_month_structure_load(year,month,country) = avail_month_structure_load(year,month,country) + correction_factor_load(year,country);
   );

   Loop(month$(avail_month_structure_resload(year,month,country) le 1.15),
         avail_month_structure_resload(year,month,country) = avail_month_structure_resload(year,month,country) + correction_factor_resload(year,country);
   );
);
sum_avail_month_structure_load(year,country) = sum(month, avail_month_structure_load(year,month,country)) + EPS;
sum_avail_month_structure_resload(year,country) = sum(month, avail_month_structure_resload(year,month,country)) + EPS;
*Display avail_month_structure_load,avail_month_structure_resload,sum_avail_month_structure_load,sum_avail_month_structure_resload;

availability_conv(country,conv,year,hour_all)$(hour(year,hour_all)) = (1 - plannedoutages_conv(country,conv,year)) * sum(month$(map_hourmonth(year,hour_all,month)), avail_month_structure_resload(year,month,country)) - forcedoutages_conv(country,conv,year);

*$ontext
availability_conv(country,'nuclear_old_1900-2020','2017',hour_all)$(hour('2017',hour_all)) = ((1 - plannedoutages_conv(country,'nuclear_old_1900-2020','2017') - forcedoutages_conv(country,'nuclear_old_1900-2020','2017')) * sum(month$(map_hourmonth('2017',hour_all,month)), avail_month_structure_nuclear('2017',month,country)))$( sum(month, avail_month_structure_nuclear('2017',month,country)) gt 0)
                                                                                             +
                                                                                             ((1 - plannedoutages_conv(country,'nuclear_old_1900-2020','2017')) * sum(month$(map_hourmonth('2017',hour_all,month)), avail_month_structure('2017',month,country)) - forcedoutages_conv(country,'nuclear_old_1900-2020','2017') )$( sum(month, avail_month_structure_nuclear('2017',month,country)) eq 0);
*$offtext

*Display availability_conv,plannedoutages_conv,forcedoutages_conv,avail_month_structure,map_hourmonth;

availability_renew(country,renew_disp,year,hour_all)$(hour(year,hour_all) AND (inputdata_renew(renew_disp,'avail') lt 1)) = inputdata_renew(renew_disp,'avail') * sum(month$(map_hourmonth(year,hour_all,month)), avail_month_structure_resload(year,month,country));
*Display availability_renew;


*##################################################################################################################################################

year('2025') = NO;
year('2017') = NO;







