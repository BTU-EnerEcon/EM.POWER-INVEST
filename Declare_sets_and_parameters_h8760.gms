*###############################################################################
*
*                        Declaration of sets and parameter
*
*###############################################################################
year('2017') = YES;
year('2025') = YES;

hour(year,hour_all) = yes;
*Display hour;

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

first_hour('2017') = 1;
first_hour('2020') = 1;
first_hour('2025') = 1;
first_hour('2030') = 1;
first_hour('2040') = 1;

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

last_hour('2017') = 8760;
last_hour('2020') = 8760;
last_hour('2025') = 8760;
last_hour('2030') = 8760;
last_hour('2040') = 8760;

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

step_hour(year,hour_all)$hour(year,hour_all) = 1;
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

map_hourday('2030',hour_all,day)=map_hourday('2025',hour_all,day);
map_hourday('2040',hour_all,day)=map_hourday('2025',hour_all,day);

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
*Display map_hourday;

peakind('2022',hour_all,country) = peakind('2020',hour_all,country);
peakind('2024',hour_all,country) = peakind('2025',hour_all,country);
peakind('2026',hour_all,country) = peakind('2025',hour_all,country);
peakind('2028',hour_all,country) = peakind('2030',hour_all,country);
peakind('2032',hour_all,country) = peakind('2030',hour_all,country);
peakind('2034',hour_all,country) = peakind('2030',hour_all,country);
peakind('2036',hour_all,country) = peakind('2030',hour_all,country);
peakind('2038',hour_all,country) = peakind('2040',hour_all,country);
peakind('2045',hour_all,country) = peakind('2040',hour_all,country);
peakind('2050',hour_all,country) = peakind('2040',hour_all,country);
*Display peakind;

load(country,year,hour_all)$(hour(year,hour_all)) = load_year(year,country) * load_structure(year,hour_all,country);
*Display load_year,load;

ntc_hour(country,country2,year,hour_all)$(hour(year,hour_all)) = sum(month$(map_hourmonth(year,hour_all,month)), ntc_year_month(year,month,country,country2)) * (1 - indicator_dailyntc)
                                                                 +
                                                                 sum(day$(map_hourday(year,hour_all,day)), ntc_year_day(year,day,country,country2))*indicator_dailyntc;
*Display ntc_hour,ntc_year_day;

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
*Display ntc_hour;

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

capfactor_renew_max(country,'geothermal',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'geothermal',year) gt 0)) = ( gen_renew_exogen(country,'geothermal',year) * 1000 ) / ( cap_renew_install_exogen(country,'geothermal',year) * 8760 );
capfactor_renew_max(country,'marine',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'marine',year) gt 0)) = ( gen_renew_exogen(country,'marine',year) * 1000 ) / ( cap_renew_install_exogen(country,'marine',year) * 8760 );
capfactor_renew_max(country,'othergas',year,hour_all)$(hour(year,hour_all) AND (cap_renew_install_exogen(country,'othergas',year) gt 0)) = ( gen_renew_exogen(country,'othergas',year) * 1000 ) / ( cap_renew_install_exogen(country,'othergas',year) * 8760 );
*Display capfactor_renew_max;

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

*################################################################################################################################
*Calculation of montly availability factors

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

availability_conv(country,'nuclear_old_1900-2020','2017',hour_all)$(hour('2017',hour_all)) = ((1 - plannedoutages_conv(country,'nuclear_old_1900-2020','2017') - forcedoutages_conv(country,'nuclear_old_1900-2020','2017')) * sum(month$(map_hourmonth('2017',hour_all,month)), avail_month_structure_nuclear('2017',month,country)))$( sum(month, avail_month_structure_nuclear('2017',month,country)) gt 0)
                                                                                             +
                                                                                             ((1 - plannedoutages_conv(country,'nuclear_old_1900-2020','2017')) * sum(month$(map_hourmonth('2017',hour_all,month)), avail_month_structure('2017',month,country)) - forcedoutages_conv(country,'nuclear_old_1900-2020','2017') )$( sum(month, avail_month_structure_nuclear('2017',month,country)) eq 0);


*Display availability_conv,plannedoutages_conv,forcedoutages_conv;

availability_renew(country,renew_disp,year,hour_all)$(hour(year,hour_all) AND (inputdata_renew(renew_disp,'avail') lt 1)) = inputdata_renew(renew_disp,'avail') * sum(month$(map_hourmonth(year,hour_all,month)), avail_month_structure_resload(year,month,country));
*Display availability_renew;

year('2025') = NO;
year('2017') = NO;
