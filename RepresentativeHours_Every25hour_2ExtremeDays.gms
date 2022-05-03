*Description
$ontext
This file create the reduced hourly dataset for the first stage model. It is based on the method described by DIW.

- Inlcude every 25 hour.
  - Start hour is determined by comparing the residual load in Europe between the full data set (8,760 hours) and all possible reduced datasets (every 25th hour with all possible starting hours).
  - The starting hour which leads to the smallest error regarding the standard deviation is used.

- Include the 24 hours of the day with the highest residual load in Europe.
  - Load and renewable generation factors are overwriten with values of the day with the country-specific highest sum of daily residual load.
  - Within these hours the hour with the highest residual load is overwriten with values of the country-specific highest residual load.

- Include the 24 hours of the day with the lowest residual load in Europe.
  - Load and renewable generation factors are overwriten with values of the day with the country-specific lowest sum of daily residual load.
  - Within these hours the hour with the highest residual load is overwriten with values of the country-specific lowest residual load.

$offtext

Sets
country_all      set of countries
hour_all         set of hours
year_all         set of years    /2017,2020,2025,2030,2040/
renew            set of renewable generation technologies
i                /i1*i351/
j                /j1*j25/
k                /k1*k8737/
day              set of days     /d1*d365/
month            set of months   /m1*m12/

dayhour          set of dayhours /dayhour1*dayhour24/

*subsets
hour_j(j,year_all,hour_all)      set of considered hours
hour(year_all,hour_all)
hour_max(year_all,hour_all)
hour_min(year_all,hour_all)
hour_country_max(country_all,year_all,hour_all)
hour_country_min(country_all,year_all,hour_all)

country(country_all)             set of considered countries
year(year_all)                   set of considered years

*mapping
map_hourday(year_all,hour_all,day)       maps days to hours
map_hourmonth(year_all,hour_all,month)   maps month to hours
;

Alias    (country,country2), (hour,hour2), (hour_all,hour_all2), (year,year2), (j,jj);

Parameters
*excel input
capfactor_solar(year_all,hour_all,country_all)           hourly capacity factor for solar feed-in (MWh per MW)
capfactor_windonshore(year_all,hour_all,country_all)     hourly capacity factor for windonshore feed-in (MWh per MW)
capfactor_windoffshore(year_all,hour_all,country_all)    hourly capacity factor for windoffshore feed-in (MWh per MW)
capfactor_runofriver(year_all,hour_all,country_all)      hourly capacity factor for windoffshore feed-in (MWh per MW)
capfactor_reservoir_max(year_all,hour_all,country_all)
capfactor_reservoir_min(year_all,hour_all,country_all)

chp_structure(year_all,hour_all,country_all)
chp_trimmed_structure(year_all,hour_all,country_all)

peakind(year_all,hour_all,country_all)                           peak indicator (1 if hour is a peak hour)
borderflow(year_all,hour_all,country_all)                        netexport at model borders (MW)

load_structure(year_all,hour_all,country_all)            hourly load structure (normalized to thousand)
load_year(year_all,country_all)                          yearly electrcity consumption (GWh)
gen_renew_all_year(renew,year_all,country_all)           renewable generation from all producers (GWh)
country_collection(country_all,*)

*calculated parameters
genrenew(country_all,renew,year_all,*,hour_all)
sum_genrenew(country_all,renew,year_all,*)
genrenew(country_all,renew,year_all,*,hour_all)
genrenew_europe(renew,year_all,*,hour_all)
sum_load(country_all,year_all,*)
load(country_all,year_all,*,hour_all)
load_europe(year_all,*,hour_all)
resload(country_all,year_all,*,hour_all)
resload_europe(year_all,*,hour_all)

sum_resload_europe_day(year_all,day)
sum_resload_country_day(country_all,year_all,day)

metric_europe(year_all,*)
metric_country(country_all,year_all,*)

load_structure_extrema(country_all,year_all,*)
genrenew_capfactor_extrema(country_all,renew,year_all,*)

load_structure_extremedays(country_all,year_all,*,dayhour)
genrenew_capfactor_extremedays(country_all,renew,year_all,*,dayhour)

size_hour_j(j,year_all)
load_j(j,country_all,year_all,*,hour_all)
sum_load_j(j,country_all,year_all,*)
load_j_europe(j,year_all,*,hour_all)
genrenew_j(j,country_all,renew,year_all,*,hour_all)
sum_genrenew_j(j,country_all,renew,year_all,*)
genrenew_j_europe(j,renew,year_all,*,hour_all)
resload_j(j,country_all,year_all,*,hour_all)
resload_j_europe(j,year_all,*,hour_all)

metric_europe_j(j,year_all,*)

n
first_hour(year_all)
last_hour(year_all)

data_year_hour(year_all,*,hour_all)

step_hour(year_all,hour_all)

size(year_all)

capfactor_renew_max(country_all,renew,year_all,hour_all)
capfactor_renew_min(country_all,renew,year_all,hour_all)

;

*Option Forlim = 2147483647;


*hourly data
$gdxin Input\Input_h8760.gdx
$load country_all
$load hour_all
$load load_structure
$load capfactor_runofriver
$load capfactor_solar
$load capfactor_windonshore
$load capfactor_windoffshore
$load capfactor_reservoir_max
$load capfactor_reservoir_min
$load chp_structure
$load chp_trimmed_structure
$load peakind
$load borderflow
$load map_hourmonth
$load map_hourday
$gdxin
*Display hour_all,load_structure,capfactor_windonshore,map_hourday;

map_hourday('2040',hour_all,day)=map_hourday('2025',hour_all,day);
map_hourday('2030',hour_all,day)=map_hourday('2025',hour_all,day);

*yearly data
$gdxin Input\Input_yearly_scenario3.gdx
*$gdxin Input\Input_yearly_scenarios1and2.gdx
$load renew
$load load_year
$load gen_renew_all_year
$load country_collection
$gdxin
*Display renew,load_all_year;

country(country_all) = no;
country(country_all)$(country_collection(country_all,'ETS_all_region_DE+LU') eq 1) = YES;
country('CY') = NO;
year(year_all) = no;
year('2017') = yes;
year('2020') = yes;
year('2025') = yes;
year('2030') = yes;
year('2040') = yes;
Display country,year;

load_year('2025',country) = load_year('2025',country);
load_year('2030',country) = load_year('2030',country);
load_year('2040',country) = load_year('2040',country);

genrenew(country,'solar',year,'capfactor',hour_all) = capfactor_solar(year,hour_all,country);
genrenew(country,'windonshore',year,'capfactor',hour_all) = capfactor_windonshore(year,hour_all,country);
genrenew(country,'windoffshore',year,'capfactor',hour_all) = capfactor_windoffshore(year,hour_all,country);
genrenew(country,'runofriver',year,'capfactor',hour_all) = capfactor_runofriver(year,hour_all,country);
*Display genrenew;

*###################################################################################################################
*
*                Determine load,renewable generation and residual load for the full timeset
*
*###################################################################################################################

sum_genrenew(country,renew,year,'capfactor')$(sum(hour_all, genrenew(country,'solar',year,'capfactor',hour_all)) gt 0 ) = sum(hour_all, (genrenew(country,renew,year,'capfactor',hour_all)));
genrenew(country,renew,year,'original',hour_all)$(sum_genrenew(country,renew,year,'capfactor') gt 0) = genrenew(country,renew,year,'capfactor',hour_all) * ( gen_renew_all_year(renew,year,country) / sum_genrenew(country,renew,year,'capfactor') );
sum_genrenew(country,renew,year,'orginal')$(sum_genrenew(country,renew,year,'capfactor') gt 0) = sum(hour_all, genrenew(country,renew,year,'orginal',hour_all));
genrenew_europe(renew,year,'orginal',hour_all)$(sum(country, sum_genrenew(country,renew,year,'capfactor')) gt 0) = sum(country, genrenew(country,renew,year,'original',hour_all));
*Display genrenew,sum_genrenew,gen_renew_all_year;

sum_load(country,year,'loadfactor') = sum(hour_all, load_structure(year,hour_all,country));
load(country,year,'original',hour_all)$(sum_load(country,year,'loadfactor') gt 0) = load_structure(year,hour_all,country) * ( load_year(year,country) / sum_load(country,year,'loadfactor') );
sum_load(country,year,'original') = sum(hour_all, load(country,year,'original',hour_all));
load_europe(year,'original',hour_all) = sum(country, load(country,year,'original',hour_all));
*Display load,sum_load,load_year,load_europe;

resload(country,year,'original',hour_all) = load(country,year,'original',hour_all) - sum(renew, genrenew(country,renew,year,'original',hour_all));
resload_europe(year,'original',hour_all) = sum(country, load(country,year,'original',hour_all) - sum(renew, genrenew(country,renew,year,'original',hour_all)));
*Display resload,resload_europe;

*###################################################################################################################
*
*                Determine metrics for the full timeset
*
*###################################################################################################################

metric_europe(year,'max_resload') = smax(hour_all, resload_europe(year,'original',hour_all));
metric_europe(year,'min_resload') = smin(hour_all, resload_europe(year,'original',hour_all));
metric_europe(year,'mean_resload') = sum(hour_all, resload_europe(year,'original',hour_all)) / sum(hour_all, 1);
metric_europe(year,'stddev_resload') = sqrt(sum(hour_all, sqr( resload_europe(year,'original',hour_all) - metric_europe(year,'mean_resload') ) ) * ( 1 / 8760 ));

metric_country(country,year,'max_resload') = smax(hour_all, resload(country,year,'original',hour_all));
metric_country(country,year,'min_resload') = smin(hour_all, resload(country,year,'original',hour_all));
metric_country(country,year,'mean_resload') = sum(hour_all, resload(country,year,'original',hour_all)) / sum(hour_all, 1);
metric_country(country,year,'stddev_resload') = sqrt(sum(hour_all, sqr( resload(country,year,'original',hour_all) - metric_country(country,year,'mean_resload') ) ) * ( 1 / 8760 ));

*Determine the country specific values of load structure and renewable capacity facotors at the hour of the highest and lowest residual load
Loop((country,year),
   Loop(hour_all,
      If( resload(country,year,'original',hour_all) = metric_country(country,year,'max_resload'),
         load_structure_extrema(country,year,'max_resload') = load_structure(year,hour_all,country);
         genrenew_capfactor_extrema(country,renew,year,'max_resload') = genrenew(country,renew,year,'capfactor',hour_all);
      );
      If( resload(country,year,'original',hour_all) = metric_country(country,year,'min_resload'),
         load_structure_extrema(country,year,'min_resload') = load_structure(year,hour_all,country);
         genrenew_capfactor_extrema(country,renew,year,'min_resload') = genrenew(country,renew,year,'capfactor',hour_all);
      );
   );
);
*Display metric_europe,metric_country,sum_load,sum_genrenew;

*Determine the daily sum of residual load for Europe in total (sum_resload_europe_day) and for every country (sum_resload_country_day)
sum_resload_europe_day(year,day) = sum(hour_all$(map_hourday(year,hour_all,day)), resload_europe(year,'original',hour_all));
sum_resload_country_day(country,year,day) = sum(hour_all$(map_hourday(year,hour_all,day)), resload(country,year,'original',hour_all));
*Display sum_resload_europe_day;

*Determine the maximum and minimum of daily residual load for Europe in total and every country
metric_europe(year,'max_resload_day') = smax(day, sum_resload_europe_day(year,day));
metric_europe(year,'min_resload_day') = smin(day, sum_resload_europe_day(year,day));
metric_country(country,year,'max_resload_day') = smax(day, sum_resload_country_day(country,year,day));
metric_country(country,year,'min_resload_day') = smin(day, sum_resload_country_day(country,year,day));

*Determine the day with maximum and minimum of daily residual load for Europe
Loop((year,day),
   If( sum_resload_europe_day(year,day) = metric_europe(year,'max_resload_day'),
      metric_europe(year,'day_max_resload_day') = ord(day);
   );
   If( sum_resload_europe_day(year,day) = metric_europe(year,'min_resload_day'),
      metric_europe(year,'day_min_resload_day') = ord(day);
   );
);
*Display metric_europe;

*Determine the day with maximum and minimum of daily residual load for every country
Loop((country,year,day),
   If( sum_resload_country_day(country,year,day) = metric_country(country,year,'max_resload_day'),
      metric_country(country,year,'day_max_resload_day') = ord(day);
   );
   If( sum_resload_country_day(country,year,day) = metric_country(country,year,'min_resload_day'),
      metric_country(country,year,'day_min_resload_day') = ord(day);
   );
);
*Display metric_country;


*Determine a subset of hours which include the hours of the day with the maximum daily residual load for Europe
Loop((year,day)$(ord(day) = metric_europe(year,'day_max_resload_day')),
   hour_max(year,hour_all)$(map_hourday(year,hour_all,day)) = YES;
);

*Determine a subset of hours which include the hours of the day with the minimum daily residual load for Europe
Loop((year,day)$(ord(day) = metric_europe(year,'day_min_resload_day')),
   hour_min(year,hour_all)$(map_hourday(year,hour_all,day)) = YES;
);
*Display hour_max,hour_min;

*Determine a subset of hours which include the hours of the day with the maximum daily residual load for every country
Loop((country,year,day)$(ord(day) = metric_country(country,year,'day_max_resload_day')),
   hour_country_max(country,year,hour_all)$(map_hourday(year,hour_all,day)) = YES;
);
*Display hour_country_max;

*Determine a subset of hours which include the hours of the day with the minimum daily residual load for every country
Loop((country,year,day)$(ord(day) = metric_country(country,year,'day_min_resload_day')),
   hour_country_min(country,year,hour_all)$(map_hourday(year,hour_all,day)) = YES;
);
*Display hour_country_min;

*Determine the country specific values of load structure and renewable capacity facotors at the day with the highest maximum daily residual load
Loop((country,year),
   n = 0;
   Loop(hour_all$(hour_country_max(country,year,hour_all)),
      n = n + 1;
      load_structure_extremedays(country,year,'max_resload_day',dayhour)$(ord(dayhour) eq n) = load_structure(year,hour_all,country);
      genrenew_capfactor_extremedays(country,renew,year,'max_resload_day',dayhour)$(ord(dayhour) eq n) = genrenew(country,renew,year,'capfactor',hour_all);
   );
);

*Determine the country specific values of load structure and renewable capacity facotors at the day with the highest minimum daily residual load
Loop((country,year),
   n = 0;
   Loop(hour_all$(hour_country_min(country,year,hour_all)),
      n = n + 1;
      load_structure_extremedays(country,year,'min_resload_day',dayhour)$(ord(dayhour) eq n) = load_structure(year,hour_all,country);
      genrenew_capfactor_extremedays(country,renew,year,'min_resload_day',dayhour)$(ord(dayhour) eq n) = genrenew(country,renew,year,'capfactor',hour_all);
   );
);
*Display load_structure_extremedays,genrenew_capfactor_extremedays;

*Overwrite the load structure and renewable capacity facotors at the day with highest maximum daily residual load in Europe with the country specific values of the the day with highest maximum daily residual load
Loop((country,year),
   n = 0;
   Loop(hour_all$(hour_max(year,hour_all)),
      n = n + 1;
      load_structure(year,hour_all,country) = sum(dayhour$(ord(dayhour) eq n), load_structure_extremedays(country,year,'max_resload_day',dayhour));
      genrenew(country,renew,year,'capfactor',hour_all) = sum(dayhour$(ord(dayhour) eq n), genrenew_capfactor_extremedays(country,renew,year,'max_resload_day',dayhour));
   );
);

*Overwrite the load structure and renewable capacity facotors at the day with highest maximum daily residual load in Europe with the country specific values of the the day with highest maximum daily residual load
Loop((country,year),
   n = 0;
   Loop(hour_all$(hour_min(year,hour_all)),
      n = n + 1;
      load_structure(year,hour_all,country) = sum(dayhour$(ord(dayhour) eq n), load_structure_extremedays(country,year,'min_resload_day',dayhour));
      genrenew(country,renew,year,'capfactor',hour_all) = sum(dayhour$(ord(dayhour) eq n), genrenew_capfactor_extremedays(country,renew,year,'min_resload_day',dayhour));
   );
);
*Display load_structure,genrenew;

*Determine the country specific maximum and minimum residual load within the subset hour_max and hour_min
metric_country(country,year,'max_resload_hourmax') = smax(hour_max(year,hour_all), resload(country,year,'original',hour_all));
metric_country(country,year,'min_resload_hourmin') = smin(hour_min(year,hour_all), resload(country,year,'original',hour_all));

*Overwrite the load structure and renewable capacity facotors with the country specific facotors of the hour with the highest and lowest residual load
Loop((year,country),
   Loop(hour_max(year,hour_all),
      If( resload(country,year,'original',hour_all) = metric_country(country,year,'max_resload_hourmax'),
         load_structure(year,hour_all,country) = load_structure_extrema(country,year,'max_resload');
         genrenew(country,renew,year,'capfactor',hour_all) = genrenew_capfactor_extrema(country,renew,year,'max_resload');
      );
   );
   Loop(hour_min(year,hour_all),
      If( resload(country,year,'original',hour_all) = metric_country(country,year,'min_resload_hourmin'),
         load_structure(year,hour_all,country) = load_structure_extrema(country,year,'min_resload');
         genrenew(country,renew,year,'capfactor',hour_all) = genrenew_capfactor_extrema(country,renew,year,'min_resload');
      );
   );
);

*###################################################################################################################
*
*                Create all possible timesets with the method 'every 25th hour'
*
*###################################################################################################################

hour_j(j,year,hour_all) = NO;
Loop(i,
   Loop(j,
      hour_j(j,year,hour_all)$(ord(hour_all) eq (ord(i) - 1)*25 + ord(j)) = yes;
   );
);
*Display hour_j;

size_hour_j(j,year) = sum(hour_j(j,year,hour_all), 1);
*Display hour_j,size_hour_j;

*###################################################################################################################
*
*                Determine load,renewable generation and residual load for the reduced timesets
*
*###################################################################################################################

load_j(j,country,year,'unscaled',hour_all)$(hour_j(j,year,hour_all)) = load(country,year,'original',hour_all);
sum_load_j(j,country,year,'unscaled') = sum(hour_all$(hour_j(j,year,hour_all)), load_j(j,country,year,'unscaled',hour_all)) * (8760 / size_hour_j(j,year));
load_j(j,country,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = load_j(j,country,year,'unscaled',hour_all) * ( load_year(year,country) / sum_load_j(j,country,year,'unscaled') );
sum_load_j(j,country,year,'scaled') = sum(hour_all$(hour_j(j,year,hour_all)), load_j(j,country,year,'scaled',hour_all))*(8760/size_hour_j(j,year));
load_j_europe(j,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = sum(country, load_j(j,country,year,'scaled',hour_all));
*Display load_j,sum_load_j,load_all_year,load_j_europe;

genrenew_j(j,country,renew,year,'unscaled',hour_all)$(hour_j(j,year,hour_all)) = genrenew(country,renew,year,'original',hour_all);
sum_genrenew_j(j,country,renew,year,'unscaled') = sum(hour_all$(hour_j(j,year,hour_all)), genrenew_j(j,country,renew,year,'unscaled',hour_all)) * ( 8760 / size_hour_j(j,year) );
genrenew_j(j,country,renew,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = genrenew_j(j,country,renew,year,'unscaled',hour_all) * ( gen_renew_all_year(renew,year,country) / sum_genrenew_j(j,country,renew,year,'unscaled') );
sum_genrenew_j(j,country,renew,year,'scaled')  = sum(hour_all$(hour_j(j,year,hour_all)), genrenew_j(j,country,renew,year,'scaled',hour_all)) * ( 8760 / size_hour_j(j,year) );
genrenew_j_europe(j,renew,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = sum(country, genrenew_j(j,country,renew,year,'scaled',hour_all) );
*Display genrenew_j,sum_genrenew_j,gen_renew_all_year,genrenew_j_europe;

resload_j(j,country,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = load_j(j,country,year,'scaled',hour_all) - sum(renew, genrenew_j(j,country,renew,year,'scaled',hour_all));
resload_j_europe(j,year,'scaled',hour_all)$(hour_j(j,year,hour_all)) = sum(country, load_j(j,country,year,'scaled',hour_all) - sum(renew, genrenew_j(j,country,renew,year,'scaled',hour_all) ) );
*Display resload_j,resload_j_europe;

*###################################################################################################################
*
*                Determine metrics for the reduced timesets
*
*###################################################################################################################

metric_europe_j(j,year,'max_resload') = smax(hour_all$(hour_j(j,year,hour_all)), resload_j_europe(j,year,'scaled',hour_all));
metric_europe_j(j,year,'min_resload') = smin(hour_all$(hour_j(j,year,hour_all)), resload_j_europe(j,year,'scaled',hour_all));
metric_europe_j(j,year,'mean_resload') = sum(hour_all$(hour_j(j,year,hour_all)), resload_j_europe(j,year,'scaled',hour_all)) / size_hour_j(j,year);
metric_europe_j(j,year,'stddev_resload') = sqrt( sum(hour_all$(hour_j(j,year,hour_all)), sqr( resload_j_europe(j,year,'scaled',hour_all) - metric_europe_j(j,year,'mean_resload') ) ) * ( 1 / size_hour_j(j,year) ) );

metric_europe_j(j,year,'error_stddev_resload') = abs( ( metric_europe_j(j,year,'stddev_resload') - metric_europe(year,'stddev_resload')) / metric_europe(year,'stddev_resload') );
metric_europe_j(j,year,'error_max_resload') = abs( ( metric_europe_j(j,year,'max_resload') - metric_europe(year,'max_resload') ) / metric_europe(year,'max_resload') );
metric_europe_j(j,year,'error_min_resload') = abs( ( metric_europe_j(j,year,'min_resload') - metric_europe(year,'min_resload') ) / metric_europe(year,'min_resload') );
*Display metric_europe,metric_europe_j;

*Determine which timeset have the minimum error regards standard deviation
Loop((year,j),
   If( metric_europe_j(j,year,'error_stddev_resload') = smin(jj, metric_europe_j(jj,year,'error_stddev_resload')),
      metric_europe(year,'j_min_error_stddev_resload') = ord(j);
   );
);
*Display metric_europe;

*Determine the subset hour including every 25th beginning with the startinghour which leads to the lowest error  regarding standard deviation of residual load
hour(year,hour_all) = no;
hour(year,hour_all) = sum(j$(ord(j) eq metric_europe(year,'j_min_error_stddev_resload')), hour_j(j,year,hour_all));
*Display hour;

*Add the 24 hours of the day with highest daily residual load in Europe
hour(year,hour_all)$(hour_max(year,hour_all)) = YES;
*Add the 24 hours of the day with lowest daily residual load in Europe
hour(year,hour_all)$(hour_min(year,hour_all)) = YES;
*Display hour;

size(year) = sum(hour(year,hour_all), 1);

load(country,year,'structure_interpolated',hour_all)$(hour(year,hour_all)) = load_structure(year,hour_all,country);
genrenew(country,renew,year,'capfactor_interpolated',hour_all)$(hour(year,hour_all)) = genrenew(country,renew,year,'capfactor',hour_all);
*Display size,load,genrenew;

*Determine the first and last point with known value
Loop(year,
   n = 0;
   Repeat(
      n = n + 1;
   Until sum(hour_all$(ord(hour_all) eq n), load('DE+LU',year,'structure_interpolated',hour_all)) <> EPS);
   first_hour(year) = n;

   n = card(hour_all) + n;
   Repeat(
      n = n - 1;
   Until sum(hour_all$(ord(hour_all) eq n), load('DE+LU',year,'structure_interpolated',hour_all)) <> EPS);
   last_hour(year) = n
);


*Display first_hour,last_hour;

*Determine points for interpolations
Loop(year,
   n = 0;
   Loop(hour_all$( ( ord(hour_all) ge first_hour(year) ) AND ( ord(hour_all) le last_hour(year) ) ),
      Repeat(
         n = n + 1;
      Until sum(hour_all2$(ord(hour_all2) eq n), load('DE+LU',year,'structure_interpolated',hour_all2)) <> EPS );
      data_year_hour(year,'n_start',hour_all) = n;

      Repeat(
         n = n + 1;
      Until sum(hour_all2$(ord(hour_all2) eq n), load('DE+LU',year,'structure_interpolated',hour_all2)) <> EPS );
      data_year_hour(year,'n_end',hour_all) = n;

      If(ord(hour_all) eq data_year_hour(year,'n_end',hour_all),
         n = data_year_hour(year,'n_end',hour_all) - 1;
      Else
         n = data_year_hour(year,'n_start',hour_all) - 1;
      );
   );
);
Display data_year_hour;

Loop(year,
   Loop(hour_all$( ord(hour_all) lt first_hour(year) ),
      data_year_hour(year,'n_start',hour_all) = sum(hour_all2$(ord(hour_all2) eq first_hour(year)), data_year_hour(year,'n_start',hour_all2));
      data_year_hour(year,'n_end',hour_all) = sum(hour_all2$(ord(hour_all2) eq first_hour(year)), data_year_hour(year,'n_end',hour_all2));
   );
   Loop(hour_all$( ord(hour_all) gt last_hour(year) ),
      data_year_hour(year,'n_start',hour_all) = sum(hour_all2$(ord(hour_all2) eq last_hour(year)), data_year_hour(year,'n_start',hour_all2));
      data_year_hour(year,'n_end',hour_all) = sum(hour_all2$(ord(hour_all2) eq last_hour(year)), data_year_hour(year,'n_end',hour_all2));
   );
);
*Display data_year_hour;

Loop((year,hour_all)$(hour(year,hour_all)),
   step_hour(year,hour_all) = ord(hour_all) - data_year_hour(year,'n_start',hour_all);
);
*step_hour(year,hour_all)$(not hour(year_all,hour_all)) = no;
*Display hour,step_hour;

Loop((country,year),
   load(country,year,'structure_interpolated_gradient',hour_all) = ( sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_end',hour_all)), load(country,year,'structure_interpolated',hour_all2)) - sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_start',hour_all)), load(country,year,'structure_interpolated',hour_all2)))/( data_year_hour(year,'n_end',hour_all) - data_year_hour(year,'n_start',hour_all) );
   genrenew(country,renew,year,'capfactor_interpolated_gradient',hour_all) = ( sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_end',hour_all)), genrenew(country,renew,year,'capfactor_interpolated',hour_all2)) - sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_start',hour_all)), genrenew(country,renew,year,'capfactor_interpolated',hour_all2)))/( data_year_hour(year,'n_end',hour_all) - data_year_hour(year,'n_start',hour_all) );


   load(country,year,'structure_interpolated',hour_all) = sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_start',hour_all)), load(country,year,'structure_interpolated',hour_all2))
                                                   +
                                                   load(country,year,'structure_interpolated_gradient',hour_all) * ( ord(hour_all) - data_year_hour(year,'n_start',hour_all));

   genrenew(country,renew,year,'capfactor_interpolated',hour_all) = sum(hour_all2$(ord(hour_all2) eq data_year_hour(year,'n_start',hour_all)), genrenew(country,renew,year,'capfactor_interpolated',hour_all2))
                                                                    +
                                                                    genrenew(country,renew,year,'capfactor_interpolated_gradient',hour_all) * ( ord(hour_all) - data_year_hour(year,'n_start',hour_all));
);

*Smoothing values
*Loop((country,year),
*   load(country,year,'structure_smoothed',hour_all) = sum(hour_all2$( (ord(hour_all2) ge (ord(hour_all) - 6)) AND (ord(hour_all2) le ord(hour_all)) ), load(country,year,'structure_interpolated',hour_all2)) / sum(hour_all2$( (ord(hour_all2) ge (ord(hour_all) - 6)) AND (ord(hour_all2) le ord(hour_all)) ), 1);
*   genrenew(country,renew,year,'capfactor_smoothed',hour_all) = sum(hour_all2$( (ord(hour_all2) ge (ord(hour_all) - 6)) AND (ord(hour_all2) le ord(hour_all)) ), genrenew(country,renew,year,'capfactor_interpolated',hour_all2)) / sum(hour_all2$( (ord(hour_all2) ge (ord(hour_all) - 6)) AND (ord(hour_all2) le ord(hour_all)) ), 1);
*);

*load(country,year,'structure_unscaled',hour_all)$(hour(year,hour_all)) = load(country,year,'structure_smoothed',hour_all);
load(country,year,'structure_unscaled',hour_all)$(hour(year,hour_all)) = load(country,year,'structure_interpolated',hour_all);
load(country,year,'structure_unscaled',hour_all)$(hour_max(year,hour_all)) = load_structure(year,hour_all,country);
load(country,year,'structure_unscaled',hour_all)$(hour_min(year,hour_all)) = load_structure(year,hour_all,country);
*genrenew(country,renew,year,'capfactor_unscaled',hour_all)$(hour(year,hour_all)) = genrenew(country,renew,year,'capfactor_smoothed',hour_all);
genrenew(country,renew,year,'capfactor_unscaled',hour_all)$(hour(year,hour_all)) = genrenew(country,renew,year,'capfactor_interpolated',hour_all);
genrenew(country,renew,year,'capfactor_unscaled',hour_all)$(hour_max(year,hour_all)) = genrenew(country,renew,year,'capfactor',hour_all);
genrenew(country,renew,year,'capfactor_unscaled',hour_all)$(hour_min(year,hour_all)) = genrenew(country,renew,year,'capfactor',hour_all);


sum_load(country,year,'structure_unscaled') = sum(hour(year,hour_all), load(country,year,'structure_unscaled',hour_all));
sum_load(country,year,'resload_hourmax') = sum(hour_max(year,hour_all), load_structure(year,hour_all,country));
sum_load(country,year,'resload_hourmin') = sum(hour_min(year,hour_all), load_structure(year,hour_all,country));

sum_genrenew(country,renew,year,'capfactor_unscaled') = sum(hour(year,hour_all), genrenew(country,renew,year,'capfactor_unscaled',hour_all));
sum_genrenew(country,renew,year,'resload_hourmax') = sum(hour_max(year,hour_all), genrenew(country,renew,year,'capfactor',hour_all));
sum_genrenew(country,renew,year,'resload_hourmin') = sum(hour_min(year,hour_all), genrenew(country,renew,year,'capfactor',hour_all));

sum_load(country,year,'scalingfactor') = ( ( size(year) * ( sum_load(country,year,'loadfactor') / 8760 ) ) - ( sum_load(country,year,'resload_hourmax') + sum_load(country,year,'resload_hourmin') ) ) / ( sum_load(country,year,'structure_unscaled') - ( sum_load(country,year,'resload_hourmax') + sum_load(country,year,'resload_hourmin') ) );
sum_genrenew(country,renew,year,'scalingfactor')$(sum_genrenew(country,renew,year,'capfactor') gt 0) = ( ( size(year) * ( sum_genrenew(country,renew,year,'capfactor') / 8760 ) ) - ( sum_genrenew(country,renew,year,'resload_hourmax') + sum_genrenew(country,renew,year,'resload_hourmin') ) ) / ( sum_genrenew(country,renew,year,'capfactor_unscaled') - ( sum_genrenew(country,renew,year,'resload_hourmax') + sum_genrenew(country,renew,year,'resload_hourmin') ) );

load(country,year,'structure_scaled',hour_all)$(hour(year,hour_all)) = load(country,year,'structure_unscaled',hour_all) * sum_load(country,year,'scalingfactor');
load(country,year,'structure_scaled',hour_all)$(hour_max(year,hour_all)) = load_structure(year,hour_all,country);
load(country,year,'structure_scaled',hour_all)$(hour_min(year,hour_all)) = load_structure(year,hour_all,country);

genrenew(country,renew,year,'capfactor_scaled',hour_all)$(hour(year,hour_all)) = genrenew(country,renew,year,'capfactor_unscaled',hour_all) * sum_genrenew(country,renew,year,'scalingfactor');
genrenew(country,renew,year,'capfactor_scaled',hour_all)$(hour_max(year,hour_all)) = genrenew(country,renew,year,'capfactor',hour_all);
genrenew(country,renew,year,'capfactor_scaled',hour_all)$(hour_min(year,hour_all)) = genrenew(country,renew,year,'capfactor',hour_all);

sum_load(country,year,'structure_scaled') = sum(hour(year,hour_all), load(country,year,'structure_scaled',hour_all)) * ( 8760 / size(year) );
sum_genrenew(country,renew,year,'capfactor_scaled')$(sum_genrenew(country,renew,year,'capfactor') gt 0) = sum(hour(year,hour_all), genrenew(country,renew,year,'capfactor_scaled',hour_all)) * ( 8760 / size(year) );
Display load,sum_load,genrenew,sum_genrenew;

load_structure(year,hour_all,country)$(hour(year,hour_all)) = load(country,year,'structure_scaled',hour_all);
load_structure(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_solar(year,hour_all,country)$(hour(year,hour_all)) = genrenew(country,'solar',year,'capfactor_scaled',hour_all);
capfactor_solar(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_windonshore(year,hour_all,country)$(hour(year,hour_all)) = genrenew(country,'windonshore',year,'capfactor_scaled',hour_all);
capfactor_windonshore(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_windoffshore(year,hour_all,country)$(hour(year,hour_all)) = genrenew(country,'windoffshore',year,'capfactor_scaled',hour_all);
capfactor_windoffshore(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_runofriver(year,hour_all,country)$(hour(year,hour_all)) = genrenew(country,'runofriver',year,'capfactor_scaled',hour_all);
capfactor_runofriver(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_reservoir_max(year,hour_all,country)$(hour(year,hour_all)) = capfactor_reservoir_max(year,hour_all,country);
capfactor_reservoir_max(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

capfactor_reservoir_min(year,hour_all,country)$(hour(year,hour_all)) = capfactor_reservoir_min(year,hour_all,country);
capfactor_reservoir_min(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

chp_structure(year,hour_all,country)$(hour(year,hour_all)) = chp_structure(year,hour_all,country);
chp_structure(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

chp_trimmed_structure(year,hour_all,country)$(hour(year,hour_all)) = chp_trimmed_structure(year,hour_all,country);
chp_trimmed_structure(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

peakind(year,hour_all,country)$(hour(year,hour_all)) = peakind('2020',hour_all,country);
peakind(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

borderflow(year,hour_all,country)$(hour(year,hour_all)) = borderflow('2017',hour_all,country);
borderflow(year_all,hour_all,country_all)$(not hour(year_all,hour_all)) = no;

map_hourmonth(year,hour_all,month)$(hour(year,hour_all)) = map_hourmonth(year,hour_all,month);
map_hourmonth(year_all,hour_all,month)$(not hour(year_all,hour_all)) = no;

map_hourday(year,hour_all,day)$(hour(year,hour_all)) = map_hourday('2020',hour_all,day);
map_hourday(year_all,hour_all,day)$(not hour(year_all,hour_all)) = no;

put_utility 'gdxout' / 'Input\Input_hour_reduced_Every25hour_2ExtremeDays';
execute_unload hour,load_structure,capfactor_solar,capfactor_windonshore,capfactor_windoffshore,capfactor_runofriver,capfactor_reservoir_max,capfactor_reservoir_min,chp_structure,chp_trimmed_structure,peakind,borderflow,map_hourmonth,map_hourday,first_hour,last_hour,step_hour;
