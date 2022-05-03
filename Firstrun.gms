$offOrder

$Include Define_sets_and_parameters.gms

$onecho > Input\Input_h8760.tmp
set=country_all                  rng=load!D11:AM11               rdim=0  cdim=1
set=hour_all                     rng=hour!D11:D8771              rdim=1  cdim=0
set=hour                         rng=hour!D11:D8771              rdim=1  cdim=0
par=load_structure               rng=load!B11:AM43811            rdim=2  cdim=1
par=capfactor_reservoir_max      rng=reservoir_max!B11:AM43811   rdim=2  cdim=1
par=capfactor_reservoir_min      rng=reservoir_min!B11:AM43811   rdim=2  cdim=1
par=capfactor_runofriver         rng=runofriver!B11:AM43811      rdim=2  cdim=1
par=capfactor_solar              rng=solar!B11:AM43811           rdim=2  cdim=1
par=capfactor_windonshore        rng=windonshore!B11:AM43811     rdim=2  cdim=1
par=capfactor_windoffshore       rng=windoffshore!B11:AM43811    rdim=2  cdim=1
par=chp_structure                rng=chp!B11:AM43881             rdim=2  cdim=1
par=chp_trimmed_structure        rng=chp_trimmed!B11:AM43881     rdim=2  cdim=1
par=borderflow                   rng=borderflow!B11:O8771        rdim=2  cdim=1
par=peakind                      rng=peakind!B11:AM43881         rdim=2  cdim=1
set=map_hourmonth                rng=month!C4:E43804             rdim=3  cdim=0
set=map_hourday                  rng=day!C4:E26284               rdim=3  cdim=0
$offecho

$onecho > Input\Input_h4380.tmp
set=country_all                  rng=load!D11:AM11               rdim=0  cdim=1
set=hour                         rng=hour!G11:G4391              rdim=1  cdim=0
par=load_structure               rng=load!AP11:CA21911           rdim=2  cdim=1
par=capfactor_reservoir_max      rng=reservoir_max!AP11:CA21911  rdim=2  cdim=1
par=capfactor_reservoir_min      rng=reservoir_min!AP11:CA21911  rdim=2  cdim=1
par=capfactor_runofriver         rng=runofriver!AP11:CA21911     rdim=2  cdim=1
par=capfactor_solar              rng=solar!AP11:CA21911          rdim=2  cdim=1
par=capfactor_windonshore        rng=windonshore!AP11:CA21911    rdim=2  cdim=1
par=capfactor_windoffshore       rng=windoffshore!AP11:CA21911   rdim=2  cdim=1
par=chp_structure                rng=chp!AP11:CA21911            rdim=2  cdim=1
par=chp_trimmed_structure        rng=chp_trimmed!AP11:CA21911    rdim=2  cdim=1
par=borderflow                   rng=borderflow!R11:AE4391       rdim=2  cdim=1
par=peakind                      rng=peakind!AP11:CA21911        rdim=2  cdim=1
set=map_hourmonth                rng=month!G4:I21904             rdim=3  cdim=0
set=map_hourday                  rng=day!G4:I13144               rdim=3  cdim=0
$offecho

*Conversion of data from xlsx to gdx format
$call gdxxrw.exe I=Input\Input_hourly.xlsx   cmerge=1 @Input\Input_h8760.tmp      O=Input\Input_h8760.gdx
$call gdxxrw.exe I=Input\Input_hourly.xlsx   cmerge=1 @Input\Input_h4380.tmp      O=Input\Input_h4380.gdx

*yearly data
$onecho > Input\Input_yearly.tmp
set=fuel_conv                            rng=fuel_conv!C4:H4                     rdim=0  cdim=1
set=fuel_renew                           rng=fuel_renew!B4:I4                    rdim=0  cdim=1
set=conv                                 rng=tech_conv!B4:B43                    rdim=1  cdim=0
set=convgrouped                          rng=tech_conv!AQ4:AQ11                  rdim=1  cdim=0
set=renew                                rng=tech_renew!B4:B14                   rdim=1  cdim=0
set=stor                                 rng=tech_stor!B4:B6                     rdim=1  cdim=0
set=map_convfuel                         rng=tech_conv!V4:W43                    rdim=2  cdim=0
set=map_convgrouped                      rng=tech_conv!Z4:AA43                   rdim=2  cdim=0
set=map_renewfuel                        rng=tech_renew!M4:N14                   rdim=2  cdim=0
par=load_year                            rng=load!C5:AM10                        rdim=1  cdim=1
par=ntc_year                             rng=ntc!C6:EO12                         rdim=1  cdim=2
par=ntc_year_month                       rng=ntc!B15:EO76                        rdim=2  cdim=2
par=ntc_year_day                         rng=ntc!B79:EO1905                      rdim=2  cdim=2
par=country_collection                   rng=country!C5:I41                      rdim=1  cdim=1
par=carbonprice_year                     rng=co2!C5:D19                          rdim=1  cdim=0
par=carbonprice_month                    rng=co2!G5:I29                          rdim=2  cdim=0
par=inputdata_conv                       rng=tech_conv!B4:S43                    rdim=1  cdim=1
par=cap_conv_add_forbidden               rng=tech_conv!AE4:AN40                  rdim=1  cdim=1
par=cap_conv_install_old                 rng=cap_conv_old!B4:Q496                rdim=2  cdim=1
par=cap_conv_install_old_phaseout        rng=cap_conv_old_phaseout!B4:Q496       rdim=2  cdim=1
par=eff_conv_old                         rng=eff_conv_old!B4:Q496                rdim=2  cdim=1
par=eff_conv_old_phaseout                rng=eff_conv_old_phaseout!B4:Q496       rdim=2  cdim=1
par=gen_conv_old                         rng=gen_conv_old!B4:D496                rdim=2  cdim=1
par=gen_CHP_conv_old                     rng=gen_CHP_conv_old!B3:E496            rdim=2  cdim=2
par=outages_conv                         rng=outages_conv!C3:DH121               rdim=2  cdim=2
par=avail_month_structure_nuclear        rng=outages_conv!DK4:EV16               rdim=2  cdim=1
par=avail_month_structure_lignite        rng=outages_conv!DK33:EV45              rdim=2  cdim=1
par=avail_month_structure_hardcoal       rng=outages_conv!DK70:EV82              rdim=2  cdim=1
par=avail_month_structure_gas            rng=outages_conv!DK108:EV120            rdim=2  cdim=1
par=carboncontent_conv                   rng=fuel_conv!B21:C25                   rdim=1  cdim=0
par=fuelprice_conv_year                  rng=fuel_conv!C4:H18                    rdim=1  cdim=1
par=fuelprice_conv_year_day              rng=fuel_conv!V3:Z369                   rdim=2  cdim=2
par=fuelprice_countryfactor              rng=fuel_conv!AE3:AJ40                  rdim=1  cdim=2
par=inputdata_renew                      rng=tech_renew!B4:J14                   rdim=1  cdim=1
par=covernight_renew                     rng=tech_renew!B17:G27                  rdim=1  cdim=1
par=cap_renew_install_exogen_year        rng=cap_renew!B5:AM55                   rdim=2  cdim=1
par=gen_renew_all_year                   rng=gen_renew!B5:AM55                   rdim=2  cdim=1
par=gen_renew_main_year                  rng=gen_renew!B61:AM111                 rdim=2  cdim=1
par=gen_renew_structure_monthly_exogen   rng=gen_renew!A117:AM153                rdim=3  cdim=1
par=gen_CHP_renew_all                    rng=gen_CHP_renew!B4:AN10               rdim=3  cdim=1
par=gen_CHP_renew_main                   rng=gen_CHP_renew!B14:AN20              rdim=3  cdim=1
par=fuelprice_renew                      rng=fuel_renew!B4:I9                    rdim=1  cdim=1
par=carboncontent_renew                  rng=fuel_renew!B16:C18                  rdim=1  cdim=0
par=inputdata_stor                       rng=tech_stor!B4:H6                     rdim=1  cdim=1
par=covernight_kW_stor                   rng=tech_stor!B9:G11                    rdim=1  cdim=1
par=covernight_kWh_stor                  rng=tech_stor!B14:G16                   rdim=1  cdim=1
par=storageduration                      rng=tech_stor!B19:AL21                  rdim=1  cdim=1
par=discharge_to_charge_ratio            rng=tech_stor!B24:AL26                  rdim=1  cdim=1
par=cap_stor_install_exogen_year         rng=cap_stor!B5:AM15                    rdim=2  cdim=1
par=gen_stor_exogen                      rng=gen_stor!B5:AM15                    rdim=2  cdim=1
$offecho

*Conversion of data from xlsx to gdx format
$call gdxxrw.exe I=Input\Input_yearly_scenario3.xlsx   cmerge=1 @Input\Input_yearly.tmp      O=Input\Input_yearly_scenario3.gdx
$call gdxxrw.exe I=Input\Input_yearly_scenarios1and2.xlsx   cmerge=1 @Input\Input_yearly.tmp      O=Input\Input_yearly_scenarios1and2.gdx


