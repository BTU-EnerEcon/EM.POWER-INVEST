*###############################################################################
*
*                        Output declaration
*
*###############################################################################

output_country_hour(country,year,hour_all,'load')$(hour(year,hour_all)) = load(country,year,hour_all) - CURT_LOAD.L(country,year,hour_all)$(indicator_loadcurt(country) eq 1) + EPS;
output_country_hour(country,year,hour_all,'charge')$(hour(year,hour_all)) = sum(stor, CHARGE.L(country,stor,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'discharge')$(hour(year,hour_all)) = sum(stor, DISCHARGE.L(country,stor,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'level')$(hour(year,hour_all)) = sum(stor, LEVEL.L(country,stor,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'export_sum')$(hour(year,hour_all)) = sum(country2, FLOW.L(country,country2,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'import_sum')$(hour(year,hour_all)) = sum(country2, FLOW.L(country2,country,year,hour_all)) + EPS;

output_country_hour(country,year,hour_all,'uranium generation')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'uranium')), GEN_CONV.L(country,conv,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'lignite generation')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'lignite')), GEN_CONV.L(country,conv,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'hardcoal generation')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'hardcoal')), GEN_CONV.L(country,conv,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'gas generation')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'gas')), GEN_CONV.L(country,conv,year,hour_all)) + sum(renew$(map_renewfuel(renew,'othergas')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'oil generation')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'oil')), GEN_CONV.L(country,conv,year,hour_all)) + EPS;

output_country_hour(country,year,hour_all,'solar generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'solar')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'wind generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'wind')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'hydro generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'hydro')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'bioenergy generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'bioenergy')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'waste generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'waste')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'otherres generation')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'otherres')), GEN_RENEW.L(country,renew,year,hour_all)) + EPS;

output_country_hour(country,year,hour_all,'load curtailment')$(hour(year,hour_all)) = CURT_LOAD.L(country,year,hour_all)$(indicator_loadcurt(country) eq 1) + EPS;
output_country_hour(country,year,hour_all,'renewable curtailment')$(hour(year,hour_all)) = sum(renew_curt, CURT_RENEW.L(country,renew_curt,year,hour_all)) + EPS;
output_country_hour(country,year,hour_all,'electricity price')$(hour(year,hour_all)) = MCC.M(country,year,hour_all) * ((sum(hour_all2$(hour(year,hour_all2)), 1)/8760) / energy_weighting_factor(year)) + EPS;

output_country_hour(country,year,hour_all,'co2 emissions')$(hour(year,hour_all)) = sum(conv$(emf_conv_full(country,conv,year) gt 0),
                                                                 emf_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                 +
                                                                 emf_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                 +
                                                                 emf_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                         )
                                                         +
                                                         sum(renew$(emf_renew_countryyear(country,renew,year) gt 0),
                                                                 emf_renew_countryyear(country,renew,year) * GEN_RENEW.L(country,renew,year,hour_all)
                                                         )
                                                         +
                                                         EPS
;

output_country_hour(country,year,hour_all,'uranium generation (chp)')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'uranium')), flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'lignite generation (chp)')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'lignite')), flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'hardcoal generation (chp)')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'hardcoal')), flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'gas generation (chp)')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'gas')), flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'oil generation (chp)') = sum(conv$(map_convfuel(conv,'oil')), flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'bioenergy generation (chp)')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'bioenergy')), flh_chp_renew(country,renew) * chp_structure_hour(country,year,hour_all) * cap_renew_install_exogen(country,renew,year) ) * indicator_chp + EPS;
output_country_hour(country,year,hour_all,'waste generation (chp)')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'waste')), flh_chp_renew(country,renew) * chp_structure_hour(country,year,hour_all) * cap_renew_install_exogen(country,renew,year) ) * indicator_chp + EPS;

output_country_hour(country,year,hour_all,'lignite co2')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'lignite')),
                                                                 emf_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                 +
                                                                 emf_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                 +
                                                                 emf_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                       ) + EPS;

output_country_hour(country,year,hour_all,'hardcoal co2')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'hardcoal')),
                                                                 emf_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                 +
                                                                 emf_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                 +
                                                                 emf_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                        ) + EPS;

output_country_hour(country,year,hour_all,'gas co2')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'gas')),
                                                                 emf_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                 +
                                                                 emf_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                 +
                                                                 emf_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)

                                                   )
                                                   +
                                                   sum(renew$(map_renewfuel(renew,'othergas')),
                                                                 emf_renew(renew) * GEN_RENEW.L(country,renew,year,hour_all)
                                                   ) + EPS;

output_country_hour(country,year,hour_all,'oil co2')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'oil')),
                                                                 emf_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                 +
                                                                 emf_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                 +
                                                                 emf_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                   ) + EPS;

output_country_hour(country,year,hour_all,'waste co2')$(hour(year,hour_all)) = sum(renew$(map_renewfuel(renew,'waste')),
                                                                 emf_renew(renew) * GEN_RENEW.L(country,renew,year,hour_all)
                                                     ) + EPS;

output_country_hour(country,year,hour_all,'battery_charge')$(hour(year,hour_all)) = CHARGE.L(country,'battery',year,hour_all) + EPS;
output_country_hour(country,year,hour_all,'battery_discharge')$(hour(year,hour_all)) = DISCHARGE.L(country,'battery',year,hour_all) + EPS;
output_country_hour(country,year,hour_all,'battery_level')$(hour(year,hour_all)) = LEVEL.L(country,'battery',year,hour_all) + EPS;

output_country_hour(country,year,hour_all,'pumpstorage_charge')$(hour(year,hour_all)) = CHARGE.L(country,'pumpstorage',year,hour_all) + EPS;
output_country_hour(country,year,hour_all,'pumpstorage_discharge')$(hour(year,hour_all)) = DISCHARGE.L(country,'pumpstorage',year,hour_all) + EPS;
output_country_hour(country,year,hour_all,'pumpstorage_level')$(hour(year,hour_all)) = LEVEL.L(country,'pumpstorage',year,hour_all) + EPS;

output_country_hour(country,year,hour_all,'uranium avail cap')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'uranium')), availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) + EPS;
output_country_hour(country,year,hour_all,'lignite avail cap')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'lignite')), availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) + EPS;
output_country_hour(country,year,hour_all,'hardcoal avail cap')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'hardcoal')), availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) + EPS;
output_country_hour(country,year,hour_all,'gas avail cap')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'gas')), availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) )
                                                                                   +
                                                                                   ( capfactor_renew_max(country,'othergas',year,hour_all) * cap_renew_install_exogen(country,'othergas',year) ) + EPS
;
output_country_hour(country,year,hour_all,'oil avail cap')$(hour(year,hour_all)) = sum(conv$(map_convfuel(conv,'oil')), availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) ) + EPS;

output_country_hour_conv(conv,hour_all,country,year,'GEN')$(hour(year,hour_all)) = GEN_CONV.L(country,conv,year,hour_all) + EPS;
output_country_hour_conv(conv,hour_all,country,year,'GEN_FULL')$(hour(year,hour_all)) = GEN_CONV_FULL.L(country,conv,year,hour_all) + EPS;
output_country_hour_conv(conv,hour_all,country,year,'GEN_MIN')$(hour(year,hour_all)) = GEN_CONV_MIN.L(country,conv,year,hour_all) + EPS;

output_country_hour_conv(conv,hour_all,country,year,'FUEL')$(hour(year,hour_all)) =  ((1 / efficiency_conv_avg(country,conv,year)) * GEN_CONV.L(country,conv,year,hour_all) * ( 1 - indicator_partload_country(country) )
                                                                                     +
                                                                                     (1 / efficiency_conv_full(country,conv,year)) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                                     +
                                                                                     (1 / efficiency_conv_min(country,conv,year)) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country))$(efficiency_conv_avg(country,conv,year)) + EPS
;



output_country_hour_conv(conv,hour_all,country,year,'CAP_RTO')$(hour(year,hour_all)) = CAP_CONV_RTO.L(country,conv,year,hour_all) + EPS;
output_country_hour_conv(conv,hour_all,country,year,'CAP_UP')$(hour(year,hour_all)) = CAP_CONV_UP.L(country,conv,year,hour_all) + EPS;
output_country_hour_conv(conv,hour_all,country,year,'CAP_DOWN')$(hour(year,hour_all)) = CAP_CONV_DOWN.L(country,conv,year,hour_all) + EPS;

output_country_hour_conv(conv,hour_all,country,year,'Revenue')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,country,year,'Gen')*output_country_hour(country,year,hour_all,'electricity price')*(1/discount_factor(year)) + EPS;
output_country_hour_conv(conv,hour_all,country,year,'VarCosts')$(hour(year,hour_all)) = cvar_conv_avg(country,conv,year) * GEN_CONV.L(country,conv,year,hour_all) * (1 - indicator_partload_country(country))
                                                                                        +
                                                                                        cvar_conv_full(country,conv,year) * GEN_CONV_FULL.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                                        +
                                                                                        cvar_conv_min(country,conv,year) * GEN_CONV_MIN.L(country,conv,year,hour_all) * indicator_partload_country(country)
                                                                                        +
                                                                                        cramp_conv(country,conv,year) * ( CAP_CONV_UP.L(country,conv,year,hour_all) + CAP_CONV_DOWN.L(country,conv,year,hour_all) ) * indicator_ramping_country(country) + EPS;

output_country_hour_conv(conv,hour_all,country,year,'ProfitContribution')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,country,year,'Revenue') - output_country_hour_conv(conv,hour_all,country,year,'VarCosts') + EPS;

output_country_hour_conv(conv,hour_all,country,year,'CAP_AVAIL')$(hour(year,hour_all)) = availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL.L(country,conv,year) + EPS;


*##############################################################################################################################################################
*
*                        output_country_year(country,year,*)
*
*##############################################################################################################################################################

*############################################################################################################################
*Prices
output_country_year(country,year,'base price') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'electricity price')) / sum(hour_all$(hour(year,hour_all)), 1)) + EPS;
output_country_year(country,year,'peak price') = (sum(hour_all$(hour(year,hour_all)), peakind(year,hour_all,country) * output_country_hour(country,year,hour_all,'electricity price')) / sum(hour_all$(hour(year,hour_all)), peakind(year,hour_all,country))) + EPS;
output_country_year(country,year,'offpeak price') = (sum(hour_all$(hour(year,hour_all)), (1 - peakind(year,hour_all,country)) * output_country_hour(country,year,hour_all,'electricity price')) / sum(hour_all$(hour(year,hour_all)), (1 - peakind(year,hour_all,country)))) + EPS;

*############################################################################################################################
*Load and export/import
output_country_year(country,year,'load') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'load')) * (8760/sum(hour(year,hour_all), 1))) / 1000   + EPS;
output_country_year(country,year,'load curtailment') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'load curtailment')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'export_sum') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'export_sum')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'import_sum') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'import_sum')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

*############################################################################################################################
*Generation (fuel specific)
output_country_year(country,year,'uranium generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'uranium generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'lignite generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'lignite generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'hardcoal generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'hardcoal generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'gas generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'gas generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'oil generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'oil generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'solar generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'solar generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'wind generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'wind generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'hydro generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'hydro generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'bioenergy generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'bioenergy generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'waste generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'waste generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'otherres generation') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'otherres generation')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'discharge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'discharge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'charge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'charge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'renewable curtailment') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'renewable curtailment')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

*############################################################################################################################
*CHP Generation (fuel specific)
output_country_year(country,year,'uranium generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'uranium generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'lignite generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'lignite generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'hardcoal generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'hardcoal generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'gas generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'gas generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'oil generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'oil generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'bioenergy generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'bioenergy generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'waste generation (chp)') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'waste generation (chp)')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

*############################################################################################################################
*CO2 production (fuel spcific)
output_country_year(country,year,'lignite co2') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'lignite co2')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;
output_country_year(country,year,'hardcoal co2') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'hardcoal co2')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;
output_country_year(country,year,'gas co2') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'gas co2')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;
output_country_year(country,year,'oil co2') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'oil co2')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;
output_country_year(country,year,'waste co2') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'waste co2')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;
output_country_year(country,year,'co2 emissions') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'co2 emissions')) * (8760/sum(hour(year,hour_all), 1))) / (1000 * 1000) + EPS;

*############################################################################################################################
*Installation (fuel spcific)
output_country_year(country,year,'uranium installation') = sum(conv$(map_convfuel(conv,'uranium')), CAP_CONV_INSTALL.L(country,conv,year)) + EPS;
output_country_year(country,year,'lignite installation') = sum(conv$(map_convfuel(conv,'lignite')), CAP_CONV_INSTALL.L(country,conv,year)) + EPS;
output_country_year(country,year,'hardcoal installation') = sum(conv$(map_convfuel(conv,'hardcoal')), CAP_CONV_INSTALL.L(country,conv,year)) + EPS;
output_country_year(country,year,'gas installation') = sum(conv$(map_convfuel(conv,'gas')), CAP_CONV_INSTALL.L(country,conv,year)) + sum(renew$(map_renewfuel(renew,'othergas')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'oil installation') = sum(conv$(map_convfuel(conv,'oil')), CAP_CONV_INSTALL.L(country,conv,year)) + EPS;

output_country_year(country,year,'solar installation') = sum(renew$(map_renewfuel(renew,'solar')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'wind installation') = sum(renew$(map_renewfuel(renew,'wind')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'hydro installation') = sum(renew$(map_renewfuel(renew,'hydro')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'bioenergy installation') = sum(renew$(map_renewfuel(renew,'bioenergy')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'waste installation') = sum(renew$(map_renewfuel(renew,'waste')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'otherres installation') = sum(renew$(map_renewfuel(renew,'otherres')), cap_renew_install_exogen(country,renew,year)) + EPS;
output_country_year(country,year,'storage installation') = sum(stor, cap_stor_install_exogen(country,stor,year)) + EPS;

*############################################################################################################################
*Investment (fuel spcific)
output_country_year(country,year,'uranium investment') = sum(conv$(map_convfuel(conv,'uranium')), CAP_CONV_ADD.L(country,conv,year)) + EPS;
output_country_year(country,year,'lignite investment') = sum(conv$(map_convfuel(conv,'lignite')), CAP_CONV_ADD.L(country,conv,year)) + EPS;
output_country_year(country,year,'hardcoal investment') = sum(conv$(map_convfuel(conv,'hardcoal')), CAP_CONV_ADD.L(country,conv,year)) + EPS;
output_country_year(country,year,'gas investment') = sum(conv$(map_convfuel(conv,'gas')), CAP_CONV_ADD.L(country,conv,year)) + EPS;
output_country_year(country,year,'oil investment') = sum(conv$(map_convfuel(conv,'oil')), CAP_CONV_ADD.L(country,conv,year)) + EPS;

*############################################################################################################################
*Divestment (fuel spcific)
output_country_year(country,year,'uranium divestment') = sum(conv$(map_convfuel(conv,'uranium')),
                                                            CAP_CONV_SUB.L(country,conv,year)$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                            +
                                                            cap_conv_sub_old(country,conv,year)$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                         ) + EPS;

output_country_year(country,year,'lignite divestment') = sum(conv$(map_convfuel(conv,'lignite')),
                                                            CAP_CONV_SUB.L(country,conv,year)$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                            +
                                                            cap_conv_sub_old(country,conv,year)$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                         ) + EPS;

output_country_year(country,year,'hardcoal divestment') = sum(conv$(map_convfuel(conv,'hardcoal')),
                                                            CAP_CONV_SUB.L(country,conv,year)$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                            +
                                                            cap_conv_sub_old(country,conv,year)$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                         ) + EPS;

output_country_year(country,year,'gas divestment') = sum(conv$(map_convfuel(conv,'gas')),
                                                            CAP_CONV_SUB.L(country,conv,year)$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                            +
                                                            cap_conv_sub_old(country,conv,year)$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                         ) + EPS;

output_country_year(country,year,'oil divestment') = sum(conv$(map_convfuel(conv,'oil')),
                                                            CAP_CONV_SUB.L(country,conv,year)$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                            +
                                                            cap_conv_sub_old(country,conv,year)$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                         ) + EPS;

*############################################################################################################################
*Generation (technology specific)
output_country_year(country,year,'nuclear_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'nuclear_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'nuclear_old generation') = output_country_year(country,year,'uranium generation') - output_country_year(country,year,'nuclear_new generation') + EPS;

output_country_year(country,year,'lignite_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'lignite_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'lignite_ccs_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'lignite_ccs_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'lignite_old generation') = output_country_year(country,year,'lignite generation') - output_country_year(country,year,'lignite_new generation') - output_country_year(country,year,'lignite_ccs_new generation') + EPS;

output_country_year(country,year,'hardcoal_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'hardcoal_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'hardcoal_ccs_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'hardcoal_ccs_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'hardcoal_old generation') = output_country_year(country,year,'hardcoal generation') - output_country_year(country,year,'hardcoal_new generation') - output_country_year(country,year,'hardcoal_ccs_new generation') + EPS;

output_country_year(country,year,'ccgt_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'ccgt_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'ccgt_ccs_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'ccgt_ccs_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'ccgt_old generation') = (sum(hour_all$(hour(year,hour_all)),
                                                                 GEN_CONV.L(country,'ccgt_old_1900-2020',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ccgt_old_1900-1992',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ccgt_old_1992-2005',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ccgt_old_2005-2020',year,hour_all)
                                                               ) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'gassteam_old generation') = (sum(hour_all$(hour(year,hour_all)),
                                                                 GEN_CONV.L(country,'gassteam_old_1900-2020',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'gassteam_old_1900-1985',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'gassteam_old_1985-2000',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'gassteam_old_2000-2020',year,hour_all)
                                                               ) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'ocgt_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'ocgt_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'ocgt_ccs_new generation') = (sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,'ocgt_ccs_new',year,hour_all)) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'ocgt_old generation') = (sum(hour_all$(hour(year,hour_all)),
                                                                 GEN_CONV.L(country,'ocgt_old_1900-2020',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ocgt_old_1900-1985',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ocgt_old_1985-2000',year,hour_all)
                                                                 +
                                                                 GEN_CONV.L(country,'ocgt_old_2000-2020',year,hour_all)
                                                               ) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'oil_old generation') = output_country_year(country,year,'oil generation') + EPS;

output_country_year(country,year,'pumpstorage discharge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'pumpstorage_discharge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'battery_discharge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'battery_discharge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

output_country_year(country,year,'pumpstorage charge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'pumpstorage_charge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;
output_country_year(country,year,'battery_charge') = (sum(hour_all$(hour(year,hour_all)), output_country_hour(country,year,hour_all,'battery_charge')) * (8760/sum(hour(year,hour_all), 1))) / 1000 + EPS;

*############################################################################################################################
*Installation (technology specific)
output_country_year(country,year,'nuclear_new installation') = CAP_CONV_INSTALL.L(country,'nuclear_new',year) + EPS;
output_country_year(country,year,'nuclear_old installation') = output_country_year(country,year,'uranium installation') - output_country_year(country,year,'nuclear_new installation') + EPS;

output_country_year(country,year,'lignite_new installation') = CAP_CONV_INSTALL.L(country,'lignite_new',year) + EPS;
output_country_year(country,year,'lignite_ccs_new installation') = CAP_CONV_INSTALL.L(country,'lignite_ccs_new',year) + EPS;
output_country_year(country,year,'lignite_old installation') = output_country_year(country,year,'lignite installation') - output_country_year(country,year,'lignite_new installation') - output_country_year(country,year,'lignite_ccs_new installation') + EPS;

output_country_year(country,year,'hardcoal_new installation') = CAP_CONV_INSTALL.L(country,'hardcoal_new',year) + EPS;
output_country_year(country,year,'hardcoal_ccs_new installation') = CAP_CONV_INSTALL.L(country,'hardcoal_ccs_new',year) + EPS;
output_country_year(country,year,'hardcoal_old installation') = output_country_year(country,year,'hardcoal installation') - output_country_year(country,year,'hardcoal_new installation') - output_country_year(country,year,'hardcoal_ccs_new installation') + EPS;

output_country_year(country,year,'ccgt_new installation') = CAP_CONV_INSTALL.L(country,'ccgt_new',year) + EPS;
output_country_year(country,year,'ccgt_ccs_new installation') = CAP_CONV_INSTALL.L(country,'ccgt_ccs_new',year) + EPS;
output_country_year(country,year,'ccgt_old installation') = CAP_CONV_INSTALL.L(country,'ccgt_old_1900-2020',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ccgt_old_1900-1992',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ccgt_old_1992-2005',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ccgt_old_2005-2020',year) + EPS;

output_country_year(country,year,'gassteam_old installation') = CAP_CONV_INSTALL.L(country,'gassteam_old_1900-2020',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'gassteam_old_1900-1985 ',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'gassteam_old_1985-2000',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'gassteam_old_2000-2020',year) + EPS;

output_country_year(country,year,'ocgt_new installation') = CAP_CONV_INSTALL.L(country,'ocgt_new',year) + EPS;
output_country_year(country,year,'ocgt_ccs_new installation') = CAP_CONV_INSTALL.L(country,'ocgt_ccs_new',year) + EPS;
output_country_year(country,year,'ocgt_old installation') = CAP_CONV_INSTALL.L(country,'ocgt_old_1900-2020',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ocgt_old_1900-1985 ',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ocgt_old_1985-2000',year)
                                                            +
                                                            CAP_CONV_INSTALL.L(country,'ocgt_old_2000-2020',year) + EPS;

output_country_year(country,year,'oil_old installation') = output_country_year(country,year,'oil installation') + EPS;

output_country_year(country,year,'pumpstorage installation') = cap_stor_install_exogen(country,'pumpstorage',year) + EPS;
output_country_year(country,year,'battery installation') = cap_stor_install_exogen(country,'battery',year) + EPS;

*############################################################################################################################
*Installation exogenous (technology specific)
output_country_year(country,year,'nuclear_old installation exogen') = cap_conv_install_old(country,'nuclear_old_1900-2020',year) + EPS;

output_country_year(country,year,'lignite_old installation exogen') = cap_conv_install_old(country,'lignite_old_1900-2020',year)
                                                                      +
                                                                      cap_conv_install_old(country,'lignite_old_1900-1970',year)
                                                                      +
                                                                      cap_conv_install_old(country,'lignite_old_1970-1985',year)
                                                                      +
                                                                      cap_conv_install_old(country,'lignite_old_1985-2000',year)
                                                                      +
                                                                      cap_conv_install_old(country,'lignite_old_2000-2020',year)
                                                                      +
                                                                      EPS;

output_country_year(country,year,'hardcoal_old installation exogen') = cap_conv_install_old(country,'hardcoal_old_1900-2020',year)
                                                                       +
                                                                       cap_conv_install_old(country,'hardcoal_old_1900-1970',year)
                                                                       +
                                                                       cap_conv_install_old(country,'hardcoal_old_1970-1985',year)
                                                                       +
                                                                       cap_conv_install_old(country,'hardcoal_old_1985-2000',year)
                                                                       +
                                                                       cap_conv_install_old(country,'hardcoal_old_2000-2020',year)
                                                                       +
                                                                       EPS;

output_country_year(country,year,'ccgt_old installation exogen') = cap_conv_install_old(country,'ccgt_old_1900-2020',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ccgt_old_1900-1992',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ccgt_old_1992-2005',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ccgt_old_2005-2020',year)
                                                                   +
                                                                   EPS;

output_country_year(country,year,'gassteam_old installation exogen') = cap_conv_install_old(country,'gassteam_old_1900-2020',year)
                                                                       +
                                                                       cap_conv_install_old(country,'gassteam_old_1900-1985',year)
                                                                       +
                                                                       cap_conv_install_old(country,'gassteam_old_1985-2000',year)
                                                                       +
                                                                       cap_conv_install_old(country,'gassteam_old_2000-2020',year)
                                                                       +
                                                                       EPS;

output_country_year(country,year,'ocgt_old installation exogen') = cap_conv_install_old(country,'ocgt_old_1900-2020',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ocgt_old_1900-1985',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ocgt_old_1985-2000',year)
                                                                   +
                                                                   cap_conv_install_old(country,'ocgt_old_2000-2020',year)
                                                                   +
                                                                   EPS;

output_country_year(country,year,'oil_old installation exogen') = cap_conv_install_old(country,'oilsteam_old_1900-2020',year)
                                                                  +
                                                                  cap_conv_install_old(country,'oilsteam_old_1900-1990',year)
                                                                  +
                                                                  cap_conv_install_old(country,'oilsteam_old_1990-2020',year)
                                                                  +
                                                                  cap_conv_install_old(country,'ocot_old_1900-2020',year)
                                                                  +
                                                                  cap_conv_install_old(country,'ocot_old_1900-1990 ',year)
                                                                  +
                                                                  cap_conv_install_old(country,'ocot_old_1990-2020',year)
                                                                  +
                                                                  cap_conv_install_old(country,'ccot_old_1900-2020',year)
                                                                  +
                                                                  cap_conv_install_old(country,'ccot_old_1900-2020',year)
                                                                  +
                                                                  EPS;

*############################################################################################################################
*Investment (technology specific)
output_country_year(country,year,'nuclear_new investment') = CAP_CONV_ADD.L(country,'nuclear_new',year) + EPS;

output_country_year(country,year,'lignite_new investment') = CAP_CONV_ADD.L(country,'lignite_new',year) + EPS;
output_country_year(country,year,'lignite_ccs_new investment') = CAP_CONV_ADD.L(country,'lignite_ccs_new',year) + EPS;

output_country_year(country,year,'hardcoal_new investment') = CAP_CONV_ADD.L(country,'hardcoal_new',year) + EPS;
output_country_year(country,year,'hardcoal_ccs_new investment') = CAP_CONV_ADD.L(country,'hardcoal_ccs_new',year) + EPS;

output_country_year(country,year,'ccgt_new investment') = CAP_CONV_ADD.L(country,'ccgt_new',year) + EPS;
output_country_year(country,year,'ccgt_ccs_new investment') = CAP_CONV_ADD.L(country,'ccgt_ccs_new',year) + EPS;

output_country_year(country,year,'ocgt_new investment') = CAP_CONV_ADD.L(country,'ocgt_new',year) + EPS;
output_country_year(country,year,'ocgt_ccs_new investment') = CAP_CONV_ADD.L(country,'ocgt_ccs_new',year) + EPS;

*############################################################################################################################
*Divestment (technology specific)
output_country_year(country,year,'nuclear_new divestment') = CAP_CONV_SUB.L(country,'nuclear_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'nuclear_old divestment') = output_country_year(country,year,'uranium divestment') - output_country_year(country,year,'nuclear_new divestment') + EPS;

output_country_year(country,year,'lignite_new divestment') = CAP_CONV_SUB.L(country,'lignite_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'lignite_ccs_new divestment') = CAP_CONV_SUB.L(country,'lignite_ccs_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'lignite_old divestment') = output_country_year(country,year,'lignite divestment') - output_country_year(country,year,'lignite_new divestment') - output_country_year(country,year,'lignite_ccs_new divestment') + EPS;

output_country_year(country,year,'hardcoal_new divestment') = CAP_CONV_SUB.L(country,'hardcoal_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'hardcoal_ccs_new divestment') = CAP_CONV_SUB.L(country,'hardcoal_ccs_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'hardcoal_old divestment') = output_country_year(country,year,'hardcoal divestment') - output_country_year(country,year,'hardcoal_new divestment') - output_country_year(country,year,'hardcoal_ccs_new divestment') + EPS;

output_country_year(country,year,'ccgt_new divestment') = CAP_CONV_SUB.L(country,'ccgt_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'ccgt_ccs_new divestment') = CAP_CONV_SUB.L(country,'ccgt_ccs_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'ccgt_old divestment') = ( CAP_CONV_SUB.L(country,'ccgt_old_1900-2020',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ccgt_old_1900-1992',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ccgt_old_1992-2005',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ccgt_old_2005-2020',year)
                                                          )$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                          +
                                                          ( cap_conv_sub_old(country,'ccgt_old_1900-2020',year)
                                                            +
                                                            cap_conv_sub_old(country,'ccgt_old_1900-1992',year)
                                                            +
                                                            cap_conv_sub_old(country,'ccgt_old_1992-2005',year)
                                                            +
                                                            cap_conv_sub_old(country,'ccgt_old_2005-2020',year)
                                                          )$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                          +
                                                          EPS;

output_country_year(country,year,'gassteam_old divestment') = ( CAP_CONV_SUB.L(country,'gassteam_old_1900-2020',year)
                                                                +
                                                                CAP_CONV_SUB.L(country,'gassteam_old_1900-1985',year)
                                                                +
                                                                CAP_CONV_SUB.L(country,'gassteam_old_1985-2000',year)
                                                                +
                                                                CAP_CONV_SUB.L(country,'gassteam_old_2000-2020',year)
                                                              )$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                              +
                                                              ( cap_conv_sub_old(country,'gassteam_old_1900-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'gassteam_old_1900-1985',year)
                                                                +
                                                                cap_conv_sub_old(country,'gassteam_old_1985-2000',year)
                                                                +
                                                                cap_conv_sub_old(country,'gassteam_old_2000-2020',year)
                                                              )$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                              +
                                                              EPS;

output_country_year(country,year,'ocgt_new divestment') = CAP_CONV_SUB.L(country,'ocgt_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'ocgt_ccs_new divestment') = CAP_CONV_SUB.L(country,'ocgt_ccs_new',year) * indicator_divestment_country(country) + EPS;
output_country_year(country,year,'ocgt_old divestment') = ( CAP_CONV_SUB.L(country,'ocgt_old_1900-2020',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ocgt_old_1900-1985',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ocgt_old_1985-2000',year)
                                                            +
                                                            CAP_CONV_SUB.L(country,'ocgt_old_2000-2020',year)
                                                          )$( ( indicator_divestment_country(country) eq 1 ) AND ( yearnumber(year) gt 2020 ))
                                                          +
                                                          ( cap_conv_sub_old(country,'ocgt_old_1900-2020',year)
                                                            +
                                                            cap_conv_sub_old(country,'ocgt_old_1900-1985',year)
                                                            +
                                                            cap_conv_sub_old(country,'ocgt_old_1985-2000',year)
                                                            +
                                                            cap_conv_sub_old(country,'ocgt_old_2000-2020',year)
                                                          )$( ( indicator_divestment_country(country) eq 0 ) OR ( yearnumber(year) le 2020 ))
                                                          +
                                                          EPS;

output_country_year(country,year,'oil_old divestment') = output_country_year(country,year,'oil divestment') + EPS;

*############################################################################################################################
*Divestment exogenous (technology specific)
output_country_year(country,year,'nuclear_old divestment exogen') = cap_conv_sub_old(country,'nuclear_old_1900-2020',year) + EPS;

output_country_year(country,year,'lignite_old divestment exogen') = cap_conv_sub_old(country,'lignite_old_1900-2020',year)
                                                                    +
                                                                    cap_conv_sub_old(country,'lignite_old_1900-1970',year)
                                                                    +
                                                                    cap_conv_sub_old(country,'lignite_old_1970-1985',year)
                                                                    +
                                                                    cap_conv_sub_old(country,'lignite_old_1985-2000',year)
                                                                    +
                                                                    cap_conv_sub_old(country,'lignite_old_2000-2020',year)
                                                                    +
                                                                    EPS;

output_country_year(country,year,'hardcoal_old divestment exogen') = cap_conv_sub_old(country,'hardcoal_old_1900-2020',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'hardcoal_old_1900-1970',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'hardcoal_old_1970-1985',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'hardcoal_old_1985-2000',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'hardcoal_old_2000-2020',year)
                                                                     +
                                                                     EPS;

output_country_year(country,year,'ccgt_old divestment exogen') = cap_conv_sub_old(country,'ccgt_old_1900-2020',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ccgt_old_1900-1992',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ccgt_old_1992-2005',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ccgt_old_2005-2020',year)
                                                                 +
                                                                 EPS;

output_country_year(country,year,'gassteam_old divestment exogen') = cap_conv_sub_old(country,'gassteam_old_1900-2020',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'gassteam_old_1900-1985',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'gassteam_old_1985-2000',year)
                                                                     +
                                                                     cap_conv_sub_old(country,'gassteam_old_2000-2020',year)
                                                                     +
                                                                     EPS;

output_country_year(country,year,'ocgt_old divestment exogen') = cap_conv_sub_old(country,'ocgt_old_1900-2020',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ocgt_old_1900-1985',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ocgt_old_1985-2000',year)
                                                                 +
                                                                 cap_conv_sub_old(country,'ocgt_old_2000-2020',year)
                                                                 +
                                                                 EPS;

output_country_year(country,year,'oil_old divestment exogen') = cap_conv_sub_old(country,'oilsteam_old_1900-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'oilsteam_old_1900-1990',year)
                                                                +
                                                                cap_conv_sub_old(country,'oilsteam_old_1990-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'ocot_old_1900-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'ocot_old_1900-1990 ',year)
                                                                +
                                                                cap_conv_sub_old(country,'ocot_old_1990-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'ccot_old_1900-2020',year)
                                                                +
                                                                cap_conv_sub_old(country,'ccot_old_1900-2020',year)
                                                                +
                                                                EPS;

*############################################################################################################################
*Other output
output_country_year(country,year,'RES_CAP_CONV_NUCLEAR_up.M') = RES_CAP_CONV_NUCLEAR_up.M(country,year) + EPS;
output_country_year(country,year,'carbon price') = carbonprice(country,year) + EPS;
output_country_year(country,year,'uranium price') = fuelprice_conv(country,'uranium',year) + EPS;
output_country_year(country,year,'lignite price') = fuelprice_conv(country,'lignite',year) + EPS;
output_country_year(country,year,'hardcoal price') = fuelprice_conv(country,'hardcoal',year) + EPS;
output_country_year(country,year,'gas price') = fuelprice_conv(country,'gas',year) + EPS;
output_country_year(country,year,'oil price') = fuelprice_conv(country,'oil',year) + EPS;

*##############################################################################################################################################################
*
*                        output_year(year,*)
*
*##############################################################################################################################################################

*General calculation
output_year(year,output_country_year_set) = sum(country_all, output_country_year(country_all,year,output_country_year_set)) + EPS;

*Calculation for Prices
output_year(year,'base price') = ( sum(country_all, output_country_year(country_all,year,'base price') * output_country_year(country_all,year,'load')) / sum(country_all, output_country_year(country_all,year,'load') - output_country_year(country_all,year,'load curtailment')) ) + EPS;
output_year(year,'peak price') = ( sum(country_all, output_country_year(country_all,year,'peak price') * output_country_year(country_all,year,'load')) / sum(country_all, output_country_year(country_all,year,'load') - output_country_year(country_all,year,'load curtailment')) ) + EPS;
output_year(year,'offpeak price') = ( sum(country_all, output_country_year(country_all,year,'offpeak price') * output_country_year(country_all,year,'load')) / sum(country_all, output_country_year(country_all,year,'load') - output_country_year(country_all,year,'load curtailment')) ) + EPS;

output_year(year,'carbon price') = output_country_year('DE+LU',year,'carbon price') + EPS;
output_year(year,'uranium price') = output_country_year('DE+LU',year,'uranium price') + EPS;
output_year(year,'lignite price') = output_country_year('DE+LU',year,'lignite price') + EPS;
output_year(year,'hardcoal price') = output_country_year('DE+LU',year,'hardcoal price') + EPS;
output_year(year,'gas price') = output_country_year('DE+LU',year,'gas price') + EPS;
output_year(year,'oil price') = output_country_year('DE+LU',year,'oil price') + EPS;


*############################################################################################################################

*##############################################################################################################################################################
*
*                        output_country_year_conv(country,conv,year,*)
*
*##############################################################################################################################################################

output_country_year_conv(country,conv,year,'Install') = CAP_CONV_INSTALL.L(country,conv,year) + EPS;
output_country_year_conv(country,conv,year,'Install exogen') = cap_conv_install_old(country,conv,year) + EPS;

output_country_year_conv(country,conv,year,'Add') = CAP_CONV_ADD.L(country,conv,year) + EPS;
output_country_year_conv(country,conv,year,'Add exogen') = -1*min(cap_conv_sub_old(country,conv,year),0) + EPS;

output_country_year_conv(country,conv,year,'Sub') = cap_conv_sub_old(country,conv,year) * (1 - indicator_divestment_country(country)) + CAP_CONV_SUB.L(country,conv,year)*indicator_divestment_country(country) + EPS;
output_country_year_conv(country,conv,year,'Sub exogen') = max(cap_conv_sub_old(country,conv,year),0) + EPS;

output_country_year_conv(country,conv,year,'Gen') = (( sum(hour_all$(hour(year,hour_all)), GEN_CONV.L(country,conv,year,hour_all)) * (8760/sum(hour(year,hour_all), 1)) )) + EPS;
output_country_year_conv(country,conv,year,'Fuel') = (( sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'FUEL')) * (8760/sum(hour(year,hour_all), 1)) ) ) + EPS;

output_country_year_conv(country,conv,year,'Revenue') = (( sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'Revenue')) * (8760/sum(hour(year,hour_all), 1)) ) ) + EPS;
output_country_year_conv(country,conv,year,'VarCosts') = (( sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'VarCosts')) * (8760/sum(hour(year,hour_all), 1)) ) ) + EPS;
output_country_year_conv(country,conv,year,'ProfitContribution') = (( sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'ProfitContribution')) * (8760/sum(hour(year,hour_all), 1)) ) ) + EPS;
output_country_year_conv(country,conv,year,'MarketValue') = (output_country_year_conv(country,conv,year,'Revenue') / output_country_year_conv(country,conv,year,'Gen'))$(output_country_year_conv(country,conv,year,'Gen') gt 0) + EPS;

output_country_year_conv(country,conv,year,'Investment costs') = sum(year2$( ( yearnumber(year) ge yearnumber(year2) ) AND ( yearnumber(year) le (yearnumber(year2) + inputdata_conv(conv,'lifetime_tech')) ) AND ( yearnumber(year2) ge convyear_lo(conv) ) AND ( yearnumber(year2) le convyear_up(conv) ) ),
                                                                         cinv_conv(conv,year2) * CAP_CONV_ADD.L(country,conv,year2)
                                                                 ) + EPS;

output_country_year_conv(country,conv,year,'Fix costs') = cfix_conv(conv,year) * CAP_CONV_INSTALL.L(country,conv,year)$( convyear_lo(conv) le yearnumber(year) ) + EPS;
output_country_year_conv(country,conv,year,'ProfitContribution2') = output_country_year_conv(country,conv,year,'ProfitContribution') - output_country_year_conv(country,conv,year,'Investment costs') - output_country_year_conv(country,conv,year,'Fix costs') + EPS;

output_country_year_conv(country,conv,year,'cvar_full') = cvar_conv_full(country,conv,year)*discount_factor(year) + EPS;
output_country_year_conv(country,conv,year,'cvar_min') = cvar_conv_min(country,conv,year)*discount_factor(year) + EPS;

output_country_year_conv(country,conv,year,'eff_full') = efficiency_conv_full(country,conv,year) + EPS;
output_country_year_conv(country,conv,year,'eff_min') = efficiency_conv_min(country,conv,year) + EPS;

output_country_year_conv(country,conv,year,'SHARE_FULL') = ( sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'GEN_FULL')) / sum(hour_all$(hour(year,hour_all)), output_country_hour_conv(conv,hour_all,country,year,'GEN')) )$(output_country_year_conv(country,conv,year,'Gen') gt 0) + EPS;


output_country_conv(country,conv,'ProfitContribution') = sum(year, money_weighting_factor(year) * output_country_year_conv(country,conv,year,'ProfitContribution')) + EPS;
output_country_conv(country,conv,'Investment costs') = sum(year, money_weighting_factor(year) * output_country_year_conv(country,conv,year,'Investment costs')) + EPS;
output_country_conv(country,conv,'Fix costs') = sum(year, money_weighting_factor(year) * output_country_year_conv(country,conv,year,'Fix costs')) + EPS;
output_country_conv(country,conv,'ProfitContribution2') = output_country_conv(country,conv,'ProfitContribution') - output_country_conv(country,conv,'Investment costs') - output_country_conv(country,conv,'Fix costs') + EPS;

*##############################################################################################################################################################
*
*                        Declare output for each country
*
*##############################################################################################################################################################

output_DE_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('DE+LU',year,hour_all,output_country_hour_set) + EPS;
output_DE_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('DE+LU',country2,year) gt 0)) = FLOW.L('DE+LU',country2,year,hour_all) + EPS;
output_DE_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'DE+LU',year) gt 0)) = FLOW.L(country2,'DE+LU',year,hour_all) + EPS;
output_DE_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('DE+LU',country2,year) + ntc(country2,'DE+LU',year)) gt 0)) = output_DE_export_hour(year,hour_all,'import',country2) - output_DE_export_hour(year,hour_all,'export',country2) + EPS;
output_DE_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('DE+LU',country2,year) + ntc(country2,'DE+LU',year)) gt 0)) = ntc_hour('DE+LU',country2,year,hour_all) + EPS;
output_DE_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('DE+LU',country2,year) + ntc(country2,'DE+LU',year)) gt 0)) = ntc_hour(country2,'DE+LU',year,hour_all) + EPS;

output_DE_hour_conv(conv,hour_all,year,'GEN')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'GEN') + EPS;
output_DE_hour_conv(conv,hour_all,year,'GEN_FULL')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'GEN_FULL') + EPS;
output_DE_hour_conv(conv,hour_all,year,'GEN_MIN')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'GEN_MIN') + EPS;
output_DE_hour_conv(conv,hour_all,year,'FUEL')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'FUEL') + EPS;
output_DE_hour_conv(conv,hour_all,year,'CAP_RTO')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'CAP_RTO') + EPS;
output_DE_hour_conv(conv,hour_all,year,'CAP_UP')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'CAP_UP') + EPS;
output_DE_hour_conv(conv,hour_all,year,'CAP_DOWN')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'CAP_DOWN') + EPS;
output_DE_hour_conv(conv,hour_all,year,'CAP_AVAIL')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'CAP_AVAIL') + EPS;
output_DE_hour_conv(conv,hour_all,year,'Revenue')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'Revenue') + EPS;
output_DE_hour_conv(conv,hour_all,year,'VarCosts')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'VarCosts') + EPS;
output_DE_hour_conv(conv,hour_all,year,'ProfitContribution')$(hour(year,hour_all)) = output_country_hour_conv(conv,hour_all,'DE+LU',year,'ProfitContribution') + EPS;

output_DE_year(year,output_country_year_set) = output_country_year('DE+LU',year,output_country_year_set) + EPS;
output_DE_export_year(year,'export',country2)$(ntc('DE+LU',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_DE_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_DE_export_year(year,'import',country2)$(ntc(country2,'DE+LU',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_DE_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_DE_export_year(year,'netimport',country2)$((ntc('DE+LU',country2,year) + ntc(country2,'DE+LU',year)) gt 0) = output_DE_export_year(year,'import',country2) - output_DE_export_year(year,'export',country2) + EPS;
output_DE_export_year(year,'ntc_export',country2)$(ntc('DE+LU',country2,year) gt 0) = ntc('DE+LU',country2,year) + EPS;
output_DE_export_year(year,'ntc_import',country2)$(ntc(country2,'DE+LU',year) gt 0) = ntc(country2,'DE+LU',year) + EPS;
output_DE_year_conv(year,conv,output_country_year_conv_set) = output_country_year_conv('DE+LU',conv,year,output_country_year_conv_set) + EPS;


output_AT_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('AT',year,hour_all,output_country_hour_set) + EPS;
output_AT_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('AT',country2,year) gt 0)) = FLOW.L('AT',country2,year,hour_all) + EPS;
output_AT_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'AT',year) gt 0)) = FLOW.L(country2,'AT',year,hour_all) + EPS;
output_AT_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('AT',country2,year) + ntc(country2,'AT',year)) gt 0)) = output_AT_export_hour(year,hour_all,'import',country2) - output_AT_export_hour(year,hour_all,'export',country2) + EPS;
output_AT_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('AT',country2,year) + ntc(country2,'AT',year)) gt 0)) = ntc_hour('AT',country2,year,hour_all) + EPS;
output_AT_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('AT',country2,year) + ntc(country2,'AT',year)) gt 0)) = ntc_hour(country2,'AT',year,hour_all) + EPS;

output_AT_year(year,output_country_year_set) = output_country_year('AT',year,output_country_year_set) + EPS;
output_AT_export_year(year,'export',country2)$(ntc('AT',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_AT_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_AT_export_year(year,'import',country2)$(ntc(country2,'AT',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_AT_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_AT_export_year(year,'netimport',country2)$((ntc('AT',country2,year) + ntc(country2,'AT',year)) gt 0) = output_AT_export_year(year,'import',country2) - output_AT_export_year(year,'export',country2) + EPS;
output_AT_export_year(year,'ntc_export',country2)$(ntc('AT',country2,year) gt 0) = ntc('AT',country2,year) + EPS;
output_AT_export_year(year,'ntc_import',country2)$(ntc(country2,'AT',year) gt 0) = ntc(country2,'AT',year) + EPS;

output_BALT_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('EE+LT+LV',year,hour_all,output_country_hour_set) + EPS;
output_BALT_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('EE+LT+LV',country2,year) gt 0)) = FLOW.L('EE+LT+LV',country2,year,hour_all) + EPS;
output_BALT_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'EE+LT+LV',year) gt 0)) = FLOW.L(country2,'EE+LT+LV',year,hour_all) + EPS;
output_BALT_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('EE+LT+LV',country2,year) + ntc(country2,'EE+LT+LV',year)) gt 0)) = output_BALT_export_hour(year,hour_all,'import',country2) - output_BALT_export_hour(year,hour_all,'export',country2) + EPS;
output_BALT_export_year(year,'ntc_export',country2)$(ntc('EE+LT+LV',country2,year) gt 0) = ntc('EE+LT+LV',country2,year) + EPS;
output_BALT_export_year(year,'ntc_import',country2)$(ntc(country2,'EE+LT+LV',year) gt 0) = ntc(country2,'EE+LT+LV',year) + EPS;

output_BALT_year(year,output_country_year_set) = output_country_year('EE+LT+LV',year,output_country_year_set) + EPS;
output_BALT_export_year(year,'export',country2)$(ntc('EE+LT+LV',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BALT_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BALT_export_year(year,'import',country2)$(ntc(country2,'EE+LT+LV',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BALT_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BALT_export_year(year,'netimport',country2)$((ntc('EE+LT+LV',country2,year) + ntc(country2,'EE+LT+LV',year)) gt 0) = output_BALT_export_year(year,'import',country2) - output_BALT_export_year(year,'export',country2) + EPS;
output_BALT_export_year(year,'ntc_export',country2)$(ntc('EE+LT+LV',country2,year) gt 0) = ntc('EE+LT+LV',country2,year) + EPS;
output_BALT_export_year(year,'ntc_import',country2)$(ntc(country2,'EE+LT+LV',year) gt 0) = ntc(country2,'EE+LT+LV',year) + EPS;

output_BE_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('BE',year,hour_all,output_country_hour_set) + EPS;
output_BE_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND(ntc('BE',country2,year) gt 0)) = FLOW.L('BE',country2,year,hour_all) + EPS;
output_BE_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'BE',year) gt 0)) = FLOW.L(country2,'BE',year,hour_all) + EPS;
output_BE_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('BE',country2,year) + ntc(country2,'BE',year)) gt 0)) = output_BE_export_hour(year,hour_all,'import',country2) - output_BE_export_hour(year,hour_all,'export',country2) + EPS;
output_BE_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('BE',country2,year) + ntc(country2,'BE',year)) gt 0)) = ntc_hour('BE',country2,year,hour_all) + EPS;
output_BE_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('BE',country2,year) + ntc(country2,'BE',year)) gt 0)) = ntc_hour(country2,'BE',year,hour_all) + EPS;

output_BE_year(year,output_country_year_set) = output_country_year('BE',year,output_country_year_set) + EPS;
output_BE_export_year(year,'export',country2)$(ntc('BE',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BE_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BE_export_year(year,'import',country2)$(ntc(country2,'BE',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BE_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BE_export_year(year,'netimport',country2)$((ntc('BE',country2,year) + ntc(country2,'BE',year)) gt 0) = output_BE_export_year(year,'import',country2) - output_BE_export_year(year,'export',country2) + EPS;
output_BE_export_year(year,'ntc_export',country2)$(ntc('BE',country2,year) gt 0) = ntc('BE',country2,year) + EPS;
output_BE_export_year(year,'ntc_import',country2)$(ntc(country2,'BE',year) gt 0) = ntc(country2,'BE',year) + EPS;

output_BG_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('BG',year,hour_all,output_country_hour_set) + EPS;
output_BG_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND(ntc('BG',country2,year) gt 0)) = FLOW.L('BG',country2,year,hour_all) + EPS;
output_BG_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'BG',year) gt 0)) = FLOW.L(country2,'BG',year,hour_all) + EPS;
output_BG_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('BG',country2,year) + ntc(country2,'BG',year)) gt 0)) = output_BG_export_hour(year,hour_all,'import',country2) - output_BG_export_hour(year,hour_all,'export',country2) + EPS;
output_BG_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('BG',country2,year) + ntc(country2,'BG',year)) gt 0)) = ntc_hour('BG',country2,year,hour_all) + EPS;
output_BG_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('BG',country2,year) + ntc(country2,'BG',year)) gt 0)) = ntc_hour(country2,'BG',year,hour_all) + EPS;

output_BG_year(year,output_country_year_set) = output_country_year('BG',year,output_country_year_set) + EPS;
output_BG_export_year(year,'export',country2)$(ntc('BG',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BG_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BG_export_year(year,'import',country2)$(ntc(country2,'BG',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_BG_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_BG_export_year(year,'netimport',country2)$((ntc('BG',country2,year) + ntc(country2,'BG',year)) gt 0) = output_BG_export_year(year,'import',country2) - output_BG_export_year(year,'export',country2) + EPS;
output_BG_export_year(year,'ntc_export',country2)$(ntc('BG',country2,year) gt 0) = ntc('BG',country2,year) + EPS;
output_BG_export_year(year,'ntc_import',country2)$(ntc(country2,'BG',year) gt 0) = ntc(country2,'BG',year) + EPS;

output_CH_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('CH',year,hour_all,output_country_hour_set) + EPS;
output_CH_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('CH',country2,year) gt 0)) = FLOW.L('CH',country2,year,hour_all) + EPS;
output_CH_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'CH',year) gt 0)) = FLOW.L(country2,'CH',year,hour_all) + EPS;
output_CH_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('CH',country2,year) + ntc(country2,'CH',year)) gt 0)) = output_CH_export_hour(year,hour_all,'import',country2) - output_CH_export_hour(year,hour_all,'export',country2) + EPS;
output_CH_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('CH',country2,year) + ntc(country2,'CH',year)) gt 0)) = ntc_hour('CH',country2,year,hour_all) + EPS;
output_CH_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('CH',country2,year) + ntc(country2,'CH',year)) gt 0)) = ntc_hour(country2,'CH',year,hour_all) + EPS;

output_CH_year(year,output_country_year_set) = output_country_year('CH',year,output_country_year_set) + EPS;
output_CH_export_year(year,'export',country2)$(ntc('CH',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_CH_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_CH_export_year(year,'import',country2)$(ntc(country2,'CH',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_CH_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_CH_export_year(year,'netimport',country2)$((ntc('CH',country2,year) + ntc(country2,'CH',year)) gt 0) = output_CH_export_year(year,'import',country2) - output_CH_export_year(year,'export',country2) + EPS;
output_CH_export_year(year,'ntc_export',country2)$(ntc('CH',country2,year) gt 0) = ntc('CH',country2,year) + EPS;
output_CH_export_year(year,'ntc_import',country2)$(ntc(country2,'CH',year) gt 0) = ntc(country2,'CH',year) + EPS;

output_CZ_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('CZ',year,hour_all,output_country_hour_set) + EPS;
output_CZ_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('CZ',country2,year) gt 0)) = FLOW.L('CZ',country2,year,hour_all) + EPS;
output_CZ_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'CZ',year) gt 0)) = FLOW.L(country2,'CZ',year,hour_all) + EPS;
output_CZ_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('CZ',country2,year) + ntc(country2,'CZ',year)) gt 0)) = output_CZ_export_hour(year,hour_all,'import',country2) - output_CZ_export_hour(year,hour_all,'export',country2) + EPS;
output_CZ_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('CZ',country2,year) + ntc(country2,'CZ',year)) gt 0)) = ntc_hour('CZ',country2,year,hour_all) + EPS;
output_CZ_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('CZ',country2,year) + ntc(country2,'CZ',year)) gt 0)) = ntc_hour(country2,'CZ',year,hour_all) + EPS;

output_CZ_year(year,output_country_year_set) = output_country_year('CZ',year,output_country_year_set) + EPS;
output_CZ_export_year(year,'export',country2)$(ntc('CZ',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_CZ_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_CZ_export_year(year,'import',country2)$(ntc(country2,'CZ',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_CZ_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_CZ_export_year(year,'netimport',country2)$((ntc('CZ',country2,year) + ntc(country2,'CZ',year)) gt 0) = output_CZ_export_year(year,'import',country2) - output_CZ_export_year(year,'export',country2) + EPS;
output_CZ_export_year(year,'ntc_export',country2)$(ntc('CZ',country2,year) gt 0) = ntc('CZ',country2,year) + EPS;
output_CZ_export_year(year,'ntc_import',country2)$(ntc(country2,'CZ',year) gt 0) = ntc(country2,'CZ',year) + EPS;

output_DK_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('DK',year,hour_all,output_country_hour_set) + EPS;
output_DK_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('DK',country2,year) gt 0)) = FLOW.L('DK',country2,year,hour_all) + EPS;
output_DK_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'DK',year) gt 0)) = FLOW.L(country2,'DK',year,hour_all) + EPS;
output_DK_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('DK',country2,year) + ntc(country2,'DK',year)) gt 0)) = output_DK_export_hour(year,hour_all,'import',country2) - output_DK_export_hour(year,hour_all,'export',country2) + EPS;
output_DK_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('DK',country2,year) + ntc(country2,'DK',year)) gt 0)) = ntc_hour('DK',country2,year,hour_all) + EPS;
output_DK_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('DK',country2,year) + ntc(country2,'DK',year)) gt 0)) = ntc_hour(country2,'DK',year,hour_all) + EPS;

output_DK_year(year,output_country_year_set) = output_country_year('DK',year,output_country_year_set) + EPS;
output_DK_export_year(year,'export',country2)$(ntc('DK',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_DK_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_DK_export_year(year,'import',country2)$(ntc(country2,'DK',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_DK_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_DK_export_year(year,'netimport',country2)$((ntc('DK',country2,year) + ntc(country2,'DK',year)) gt 0) = output_DK_export_year(year,'import',country2) - output_DK_export_year(year,'export',country2) + EPS;
output_DK_export_year(year,'ntc_export',country2)$(ntc('DK',country2,year) gt 0) = ntc('DK',country2,year) + EPS;
output_DK_export_year(year,'ntc_import',country2)$(ntc(country2,'DK',year) gt 0) = ntc(country2,'DK',year) + EPS;

output_FI_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('FI',year,hour_all,output_country_hour_set) + EPS;
output_FI_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('FI',country2,year) gt 0)) = FLOW.L('FI',country2,year,hour_all) + EPS;
output_FI_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'FI',year) gt 0)) = FLOW.L(country2,'FI',year,hour_all) + EPS;
output_FI_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('FI',country2,year) + ntc(country2,'FI',year)) gt 0)) = output_FI_export_hour(year,hour_all,'import',country2) - output_FI_export_hour(year,hour_all,'export',country2) + EPS;
output_FI_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('FI',country2,year) + ntc(country2,'FI',year)) gt 0)) = ntc_hour('FI',country2,year,hour_all) + EPS;
output_FI_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('FI',country2,year) + ntc(country2,'FI',year)) gt 0)) = ntc_hour(country2,'FI',year,hour_all) + EPS;

output_FI_year(year,output_country_year_set) = output_country_year('FI',year,output_country_year_set) + EPS;
output_FI_export_year(year,'export',country2)$(ntc('FI',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_FI_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_FI_export_year(year,'import',country2)$(ntc(country2,'FI',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_FI_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_FI_export_year(year,'netimport',country2)$((ntc('FI',country2,year) + ntc(country2,'FI',year)) gt 0) = output_FI_export_year(year,'import',country2) - output_FI_export_year(year,'export',country2) + EPS;
output_FI_export_year(year,'ntc_export',country2)$(ntc('FI',country2,year) gt 0) = ntc('FI',country2,year) + EPS;
output_FI_export_year(year,'ntc_import',country2)$(ntc(country2,'FI',year) gt 0) = ntc(country2,'FI',year) + EPS;

output_FR_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('FR',year,hour_all,output_country_hour_set) + EPS;
output_FR_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('FR',country2,year) gt 0)) = FLOW.L('FR',country2,year,hour_all) + EPS;
output_FR_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'FR',year) gt 0)) = FLOW.L(country2,'FR',year,hour_all) + EPS;
output_FR_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('FR',country2,year) + ntc(country2,'FR',year)) gt 0)) = output_FR_export_hour(year,hour_all,'import',country2) - output_FR_export_hour(year,hour_all,'export',country2) + EPS;
output_FR_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('FR',country2,year) + ntc(country2,'FR',year)) gt 0)) = ntc_hour('FR',country2,year,hour_all) + EPS;
output_FR_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('FR',country2,year) + ntc(country2,'FR',year)) gt 0)) = ntc_hour(country2,'FR',year,hour_all) + EPS;

output_FR_year(year,output_country_year_set) = output_country_year('FR',year,output_country_year_set) + EPS;
output_FR_export_year(year,'export',country2)$(ntc('FR',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_FR_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_FR_export_year(year,'import',country2)$(ntc(country2,'FR',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_FR_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_FR_export_year(year,'netimport',country2)$((ntc('FR',country2,year) + ntc(country2,'FR',year)) gt 0) = output_FR_export_year(year,'import',country2) - output_FR_export_year(year,'export',country2) + EPS;
output_FR_export_year(year,'ntc_export',country2)$(ntc('FR',country2,year) gt 0) = ntc('FR',country2,year) + EPS;
output_FR_export_year(year,'ntc_import',country2)$(ntc(country2,'FR',year) gt 0) = ntc(country2,'FR',year) + EPS;

output_GB_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('UK(GB)',year,hour_all,output_country_hour_set) + EPS;
output_GB_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('UK(GB)',country2,year) gt 0)) = FLOW.L('UK(GB)',country2,year,hour_all) + EPS;
output_GB_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'UK(GB)',year) gt 0)) = FLOW.L(country2,'UK(GB)',year,hour_all) + EPS;
output_GB_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('UK(GB)',country2,year) + ntc(country2,'UK(GB)',year)) gt 0)) = output_GB_export_hour(year,hour_all,'import',country2) - output_GB_export_hour(year,hour_all,'export',country2) + EPS;
output_GB_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('UK(GB)',country2,year) + ntc(country2,'UK(GB)',year)) gt 0)) = ntc_hour('UK(GB)',country2,year,hour_all) + EPS;
output_GB_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('UK(GB)',country2,year) + ntc(country2,'UK(GB)',year)) gt 0)) = ntc_hour(country2,'UK(GB)',year,hour_all) + EPS;

output_GB_year(year,output_country_year_set) = output_country_year('UK(GB)',year,output_country_year_set) + EPS;
output_GB_export_year(year,'export',country2)$(ntc('UK(GB)',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_GB_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_GB_export_year(year,'import',country2)$(ntc(country2,'UK(GB)',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_GB_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_GB_export_year(year,'netimport',country2)$((ntc('UK(GB)',country2,year) + ntc(country2,'UK(GB)',year)) gt 0) = output_GB_export_year(year,'import',country2) - output_GB_export_year(year,'export',country2) + EPS;
output_GB_export_year(year,'ntc_export',country2)$(ntc('UK(GB)',country2,year) gt 0) = ntc('UK(GB)',country2,year) + EPS;
output_GB_export_year(year,'ntc_import',country2)$(ntc(country2,'UK(GB)',year) gt 0) = ntc(country2,'UK(GB)',year) + EPS;

output_GR_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('GR',year,hour_all,output_country_hour_set) + EPS;
output_GR_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('GR',country2,year) gt 0)) = FLOW.L('GR',country2,year,hour_all) + EPS;
output_GR_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'GR',year) gt 0)) = FLOW.L(country2,'GR',year,hour_all) + EPS;
output_GR_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('GR',country2,year) + ntc(country2,'GR',year)) gt 0)) = output_GR_export_hour(year,hour_all,'import',country2) - output_GR_export_hour(year,hour_all,'export',country2) + EPS;
output_GR_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('GR',country2,year) + ntc(country2,'GR',year)) gt 0)) = ntc_hour('GR',country2,year,hour_all) + EPS;
output_GR_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('GR',country2,year) + ntc(country2,'GR',year)) gt 0)) = ntc_hour(country2,'GR',year,hour_all) + EPS;

output_GR_year(year,output_country_year_set) = output_country_year('GR',year,output_country_year_set) + EPS;
output_GR_export_year(year,'export',country2)$(ntc('GR',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_GR_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_GR_export_year(year,'import',country2)$(ntc(country2,'GR',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_GR_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_GR_export_year(year,'netimport',country2)$((ntc('GR',country2,year) + ntc(country2,'GR',year)) gt 0) = output_GR_export_year(year,'import',country2) - output_GR_export_year(year,'export',country2) + EPS;
output_GR_export_year(year,'ntc_export',country2)$(ntc('GR',country2,year) gt 0) = ntc('GR',country2,year) + EPS;
output_GR_export_year(year,'ntc_import',country2)$(ntc(country2,'GR',year) gt 0) = ntc(country2,'GR',year) + EPS;

output_HR_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('HR',year,hour_all,output_country_hour_set) + EPS;
output_HR_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('HR',country2,year) gt 0)) = FLOW.L('HR',country2,year,hour_all) + EPS;
output_HR_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'HR',year) gt 0)) = FLOW.L(country2,'HR',year,hour_all) + EPS;
output_HR_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('HR',country2,year) + ntc(country2,'HR',year)) gt 0)) = output_HR_export_hour(year,hour_all,'import',country2) - output_HR_export_hour(year,hour_all,'export',country2) + EPS;
output_HR_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('HR',country2,year) + ntc(country2,'HR',year)) gt 0)) = ntc_hour('HR',country2,year,hour_all) + EPS;
output_HR_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('HR',country2,year) + ntc(country2,'HR',year)) gt 0)) = ntc_hour(country2,'HR',year,hour_all) + EPS;

output_HR_year(year,output_country_year_set) = output_country_year('HR',year,output_country_year_set) + EPS;
output_HR_export_year(year,'export',country2)$(ntc('HR',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_HR_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_HR_export_year(year,'import',country2)$(ntc(country2,'HR',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_HR_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_HR_export_year(year,'netimport',country2)$((ntc('HR',country2,year) + ntc(country2,'HR',year)) gt 0) = output_HR_export_year(year,'import',country2) - output_HR_export_year(year,'export',country2) + EPS;
output_HR_export_year(year,'ntc_export',country2)$(ntc('HR',country2,year) gt 0) = ntc('HR',country2,year) + EPS;
output_HR_export_year(year,'ntc_import',country2)$(ntc(country2,'HR',year) gt 0) = ntc(country2,'HR',year) + EPS;

output_HU_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('HU',year,hour_all,output_country_hour_set) + EPS;
output_HU_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('HU',country2,year) gt 0)) = FLOW.L('HU',country2,year,hour_all) + EPS;
output_HU_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'HU',year) gt 0)) = FLOW.L(country2,'HU',year,hour_all) + EPS;
output_HU_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('HU',country2,year) + ntc(country2,'HU',year)) gt 0)) = output_HU_export_hour(year,hour_all,'import',country2) - output_HU_export_hour(year,hour_all,'export',country2) + EPS;
output_HU_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('HU',country2,year) + ntc(country2,'HU',year)) gt 0)) = ntc_hour('HU',country2,year,hour_all) + EPS;
output_HU_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('HU',country2,year) + ntc(country2,'HU',year)) gt 0)) = ntc_hour(country2,'HU',year,hour_all) + EPS;

output_HU_year(year,output_country_year_set) = output_country_year('HU',year,output_country_year_set) + EPS;
output_HU_export_year(year,'export',country2)$(ntc('HU',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_HU_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_HU_export_year(year,'import',country2)$(ntc(country2,'HU',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_HU_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_HU_export_year(year,'netimport',country2)$((ntc('HU',country2,year) + ntc(country2,'HU',year)) gt 0) = output_HU_export_year(year,'import',country2) - output_HU_export_year(year,'export',country2) + EPS;
output_HU_export_year(year,'ntc_export',country2)$(ntc('HU',country2,year) gt 0) = ntc('HU',country2,year) + EPS;
output_HU_export_year(year,'ntc_import',country2)$(ntc(country2,'HU',year) gt 0) = ntc(country2,'HU',year) + EPS;

output_IBER_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('ES+PT',year,hour_all,output_country_hour_set) + EPS;
output_IBER_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('ES+PT',country2,year) gt 0)) = FLOW.L('ES+PT',country2,year,hour_all) + EPS;
output_IBER_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'ES+PT',year) gt 0)) = FLOW.L(country2,'ES+PT',year,hour_all) + EPS;
output_IBER_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('ES+PT',country2,year) + ntc(country2,'ES+PT',year)) gt 0)) = output_IBER_export_hour(year,hour_all,'import',country2) - output_IBER_export_hour(year,hour_all,'export',country2) + EPS;
output_IBER_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('ES+PT',country2,year) + ntc(country2,'ES+PT',year)) gt 0)) = ntc_hour('ES+PT',country2,year,hour_all) + EPS;
output_IBER_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('ES+PT',country2,year) + ntc(country2,'ES+PT',year)) gt 0)) = ntc_hour(country2,'ES+PT',year,hour_all) + EPS;

output_IBER_year(year,output_country_year_set) = output_country_year('ES+PT',year,output_country_year_set) + EPS;
output_IBER_export_year(year,'export',country2)$(ntc('ES+PT',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IBER_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IBER_export_year(year,'import',country2)$(ntc(country2,'ES+PT',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IBER_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IBER_export_year(year,'netimport',country2)$((ntc('ES+PT',country2,year) + ntc(country2,'ES+PT',year)) gt 0) = output_IBER_export_year(year,'import',country2) - output_IBER_export_year(year,'export',country2) + EPS;
output_IBER_export_year(year,'ntc_export',country2)$(ntc('ES+PT',country2,year) gt 0) = ntc('ES+PT',country2,year) + EPS;
output_IBER_export_year(year,'ntc_import',country2)$(ntc(country2,'ES+PT',year) gt 0) = ntc(country2,'ES+PT',year) + EPS;

output_IRIS_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('IE+UK(NIE)',year,hour_all,output_country_hour_set) + EPS;
output_IRIS_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('IE+UK(NIE)',country2,year) gt 0)) = FLOW.L('IE+UK(NIE)',country2,year,hour_all) + EPS;
output_IRIS_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'IE+UK(NIE)',year) gt 0)) = FLOW.L(country2,'IE+UK(NIE)',year,hour_all) + EPS;
output_IRIS_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('IE+UK(NIE)',country2,year) + ntc(country2,'IE+UK(NIE)',year)) gt 0)) = output_IRIS_export_hour(year,hour_all,'import',country2) - output_IRIS_export_hour(year,hour_all,'export',country2) + EPS;
output_IRIS_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('IE+UK(NIE)',country2,year) + ntc(country2,'IE+UK(NIE)',year)) gt 0)) = ntc_hour('IE+UK(NIE)',country2,year,hour_all) + EPS;
output_IRIS_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('IE+UK(NIE)',country2,year) + ntc(country2,'IE+UK(NIE)',year)) gt 0)) = ntc_hour(country2,'IE+UK(NIE)',year,hour_all) + EPS;

output_IRIS_year(year,output_country_year_set) = output_country_year('IE+UK(NIE)',year,output_country_year_set) + EPS;
output_IRIS_export_year(year,'export',country2)$(ntc('IE+UK(NIE)',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IRIS_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IRIS_export_year(year,'import',country2)$(ntc(country2,'IE+UK(NIE)',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IRIS_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IRIS_export_year(year,'netimport',country2)$((ntc('IE+UK(NIE)',country2,year) + ntc(country2,'IE+UK(NIE)',year)) gt 0) = output_IRIS_export_year(year,'import',country2) - output_IRIS_export_year(year,'export',country2) + EPS;
output_IRIS_export_year(year,'ntc_export',country2)$(ntc('IE+UK(NIE)',country2,year) gt 0) = ntc('IE+UK(NIE)',country2,year) + EPS;
output_IRIS_export_year(year,'ntc_import',country2)$(ntc(country2,'IE+UK(NIE)',year) gt 0) = ntc(country2,'IE+UK(NIE)',year) + EPS;

output_IT_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('IT',year,hour_all,output_country_hour_set) + EPS;
output_IT_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('IT',country2,year) gt 0)) = FLOW.L('IT',country2,year,hour_all) + EPS;
output_IT_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'IT',year) gt 0)) = FLOW.L(country2,'IT',year,hour_all) + EPS;
output_IT_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('IT',country2,year) + ntc(country2,'IT',year)) gt 0)) = output_IT_export_hour(year,hour_all,'import',country2) - output_IT_export_hour(year,hour_all,'export',country2) + EPS;
output_IT_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('IT',country2,year) + ntc(country2,'IT',year)) gt 0)) = ntc_hour('IT',country2,year,hour_all) + EPS;
output_IT_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('IT',country2,year) + ntc(country2,'IT',year)) gt 0)) = ntc_hour(country2,'IT',year,hour_all) + EPS;

output_IT_year(year,output_country_year_set) = output_country_year('IT',year,output_country_year_set) + EPS;
output_IT_export_year(year,'export',country2)$(ntc('IT',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IT_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IT_export_year(year,'import',country2)$(ntc(country2,'IT',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_IT_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_IT_export_year(year,'netimport',country2)$((ntc('IT',country2,year) + ntc(country2,'IT',year)) gt 0) = output_IT_export_year(year,'import',country2) - output_IT_export_year(year,'export',country2) + EPS;
output_IT_export_year(year,'ntc_export',country2)$(ntc('IT',country2,year) gt 0) = ntc('IT',country2,year) + EPS;
output_IT_export_year(year,'ntc_import',country2)$(ntc(country2,'IT',year) gt 0) = ntc(country2,'IT',year) + EPS;

output_MT_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('MT',year,hour_all,output_country_hour_set) + EPS;
output_MT_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('MT',country2,year) gt 0)) = FLOW.L('MT',country2,year,hour_all) + EPS;
output_MT_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'MT',year) gt 0)) = FLOW.L(country2,'MT',year,hour_all) + EPS;
output_MT_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('MT',country2,year) + ntc(country2,'MT',year)) gt 0)) = output_MT_export_hour(year,hour_all,'import',country2) - output_MT_export_hour(year,hour_all,'export',country2) + EPS;
output_MT_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('MT',country2,year) + ntc(country2,'MT',year)) gt 0)) = ntc_hour('MT',country2,year,hour_all) + EPS;
output_MT_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('MT',country2,year) + ntc(country2,'MT',year)) gt 0)) = ntc_hour(country2,'MT',year,hour_all) + EPS;

output_MT_year(year,output_country_year_set) = output_country_year('MT',year,output_country_year_set) + EPS;
output_MT_export_year(year,'export',country2)$(ntc('MT',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_MT_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_MT_export_year(year,'import',country2)$(ntc(country2,'MT',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_MT_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_MT_export_year(year,'netimport',country2)$((ntc('MT',country2,year) + ntc(country2,'MT',year)) gt 0) = output_MT_export_year(year,'import',country2) - output_MT_export_year(year,'export',country2) + EPS;
output_MT_export_year(year,'ntc_export',country2)$(ntc('MT',country2,year) gt 0) = ntc('MT',country2,year) + EPS;
output_MT_export_year(year,'ntc_import',country2)$(ntc(country2,'MT',year) gt 0) = ntc(country2,'MT',year) + EPS;

output_NL_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('NL',year,hour_all,output_country_hour_set) + EPS;
output_NL_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('NL',country2,year) gt 0)) = FLOW.L('NL',country2,year,hour_all) + EPS;
output_NL_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'NL',year) gt 0)) = FLOW.L(country2,'NL',year,hour_all) + EPS;
output_NL_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('NL',country2,year) + ntc(country2,'NL',year)) gt 0)) = output_NL_export_hour(year,hour_all,'import',country2) - output_NL_export_hour(year,hour_all,'export',country2) + EPS;
output_NL_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('NL',country2,year) + ntc(country2,'NL',year)) gt 0)) = ntc_hour('NL',country2,year,hour_all) + EPS;
output_NL_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('NL',country2,year) + ntc(country2,'NL',year)) gt 0)) = ntc_hour(country2,'NL',year,hour_all) + EPS;

output_NL_year(year,output_country_year_set) = output_country_year('NL',year,output_country_year_set) + EPS;
output_NL_export_year(year,'export',country2)$(ntc('NL',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_NL_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_NL_export_year(year,'import',country2)$(ntc(country2,'NL',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_NL_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_NL_export_year(year,'netimport',country2)$((ntc('NL',country2,year) + ntc(country2,'NL',year)) gt 0) = output_NL_export_year(year,'import',country2) - output_NL_export_year(year,'export',country2) + EPS;
output_NL_export_year(year,'ntc_export',country2)$(ntc('NL',country2,year) gt 0) = ntc('NL',country2,year) + EPS;
output_NL_export_year(year,'ntc_import',country2)$(ntc(country2,'NL',year) gt 0) = ntc(country2,'NL',year) + EPS;

output_NO_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('NO',year,hour_all,output_country_hour_set) + EPS;
output_NO_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('NO',country2,year) gt 0)) = FLOW.L('NO',country2,year,hour_all) + EPS;
output_NO_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'NO',year) gt 0)) = FLOW.L(country2,'NO',year,hour_all) + EPS;
output_NO_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('NO',country2,year) + ntc(country2,'NO',year)) gt 0)) = output_NO_export_hour(year,hour_all,'import',country2) - output_NO_export_hour(year,hour_all,'export',country2) + EPS;
output_NO_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('NO',country2,year) + ntc(country2,'NO',year)) gt 0)) = ntc_hour('NO',country2,year,hour_all) + EPS;
output_NO_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('NO',country2,year) + ntc(country2,'NO',year)) gt 0)) = ntc_hour(country2,'NO',year,hour_all) + EPS;

output_NO_year(year,output_country_year_set) = output_country_year('NO',year,output_country_year_set) + EPS;
output_NO_export_year(year,'export',country2)$(ntc('NO',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_NO_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_NO_export_year(year,'import',country2)$(ntc(country2,'NO',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_NO_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_NO_export_year(year,'netimport',country2)$((ntc('NO',country2,year) + ntc(country2,'NO',year)) gt 0) = output_NO_export_year(year,'import',country2) - output_NO_export_year(year,'export',country2) + EPS;
output_NO_export_year(year,'ntc_export',country2)$(ntc('NO',country2,year) gt 0) = ntc('NO',country2,year) + EPS;
output_NO_export_year(year,'ntc_import',country2)$(ntc(country2,'NO',year) gt 0) = ntc(country2,'NO',year) + EPS;

output_PL_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('PL',year,hour_all,output_country_hour_set) + EPS;
output_PL_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('PL',country2,year) gt 0)) = FLOW.L('PL',country2,year,hour_all) + EPS;
output_PL_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'PL',year) gt 0)) = FLOW.L(country2,'PL',year,hour_all) + EPS;
output_PL_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('PL',country2,year) + ntc(country2,'PL',year)) gt 0)) = output_PL_export_hour(year,hour_all,'import',country2) - output_PL_export_hour(year,hour_all,'export',country2) + EPS;
output_PL_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('PL',country2,year) + ntc(country2,'PL',year)) gt 0)) = ntc_hour('PL',country2,year,hour_all) + EPS;
output_PL_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('PL',country2,year) + ntc(country2,'PL',year)) gt 0)) = ntc_hour(country2,'PL',year,hour_all) + EPS;

output_PL_year(year,output_country_year_set) = output_country_year('PL',year,output_country_year_set) + EPS;
output_PL_export_year(year,'export',country2)$(ntc('PL',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_PL_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_PL_export_year(year,'import',country2)$(ntc(country2,'PL',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_PL_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_PL_export_year(year,'netimport',country2)$((ntc('PL',country2,year) + ntc(country2,'PL',year)) gt 0) = output_PL_export_year(year,'import',country2) - output_PL_export_year(year,'export',country2) + EPS;
output_PL_export_year(year,'ntc_export',country2)$(ntc('PL',country2,year) gt 0) = ntc('PL',country2,year) + EPS;
output_PL_export_year(year,'ntc_import',country2)$(ntc(country2,'PL',year) gt 0) = ntc(country2,'PL',year) + EPS;

output_RO_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('RO',year,hour_all,output_country_hour_set) + EPS;
output_RO_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('RO',country2,year) gt 0)) = FLOW.L('RO',country2,year,hour_all) + EPS;
output_RO_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'RO',year) gt 0)) = FLOW.L(country2,'RO',year,hour_all) + EPS;
output_RO_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('RO',country2,year) + ntc(country2,'RO',year)) gt 0)) = output_RO_export_hour(year,hour_all,'import',country2) - output_RO_export_hour(year,hour_all,'export',country2) + EPS;
output_RO_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('RO',country2,year) + ntc(country2,'RO',year)) gt 0)) = ntc_hour('RO',country2,year,hour_all) + EPS;
output_RO_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('RO',country2,year) + ntc(country2,'RO',year)) gt 0)) = ntc_hour(country2,'RO',year,hour_all) + EPS;

output_RO_year(year,output_country_year_set) = output_country_year('RO',year,output_country_year_set) + EPS;
output_RO_export_year(year,'export',country2)$(ntc('RO',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_RO_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_RO_export_year(year,'import',country2)$(ntc(country2,'RO',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_RO_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_RO_export_year(year,'netimport',country2)$((ntc('RO',country2,year) + ntc(country2,'RO',year)) gt 0) = output_RO_export_year(year,'import',country2) - output_RO_export_year(year,'export',country2) + EPS;
output_RO_export_year(year,'ntc_export',country2)$(ntc('RO',country2,year) gt 0) = ntc('RO',country2,year) + EPS;
output_RO_export_year(year,'ntc_import',country2)$(ntc(country2,'RO',year) gt 0) = ntc(country2,'RO',year) + EPS;

output_SE_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('SE',year,hour_all,output_country_hour_set) + EPS;
output_SE_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('SE',country2,year) gt 0)) = FLOW.L('SE',country2,year,hour_all) + EPS;
output_SE_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'SE',year) gt 0)) = FLOW.L(country2,'SE',year,hour_all) + EPS;
output_SE_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('SE',country2,year) + ntc(country2,'SE',year)) gt 0)) = output_SE_export_hour(year,hour_all,'import',country2) - output_SE_export_hour(year,hour_all,'export',country2) + EPS;
output_SE_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('SE',country2,year) + ntc(country2,'SE',year)) gt 0)) = ntc_hour('SE',country2,year,hour_all) + EPS;
output_SE_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('SE',country2,year) + ntc(country2,'SE',year)) gt 0)) = ntc_hour(country2,'SE',year,hour_all) + EPS;

output_SE_year(year,output_country_year_set) = output_country_year('SE',year,output_country_year_set) + EPS;
output_SE_export_year(year,'export',country2)$(ntc('SE',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SE_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SE_export_year(year,'import',country2)$(ntc(country2,'SE',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SE_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SE_export_year(year,'netimport',country2)$((ntc('SE',country2,year) + ntc(country2,'SE',year)) gt 0) = output_SE_export_year(year,'import',country2) - output_SE_export_year(year,'export',country2) + EPS;
output_SE_export_year(year,'ntc_export',country2)$(ntc('SE',country2,year) gt 0) = ntc('SE',country2,year) + EPS;
output_SE_export_year(year,'ntc_import',country2)$(ntc(country2,'SE',year) gt 0) = ntc(country2,'SE',year) + EPS;

output_SI_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('SI',year,hour_all,output_country_hour_set) + EPS;
output_SI_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('SI',country2,year) gt 0)) = FLOW.L('SI',country2,year,hour_all) + EPS;
output_SI_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'SI',year) gt 0)) = FLOW.L(country2,'SI',year,hour_all) + EPS;
output_SI_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('SI',country2,year) + ntc(country2,'SI',year)) gt 0)) = output_SI_export_hour(year,hour_all,'import',country2) - output_SI_export_hour(year,hour_all,'export',country2) + EPS;
output_SI_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('SI',country2,year) + ntc(country2,'SI',year)) gt 0)) = ntc_hour('SI',country2,year,hour_all) + EPS;
output_SI_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('SI',country2,year) + ntc(country2,'SI',year)) gt 0)) = ntc_hour(country2,'SI',year,hour_all) + EPS;

output_SI_year(year,output_country_year_set) = output_country_year('SI',year,output_country_year_set) + EPS;
output_SI_export_year(year,'export',country2)$(ntc('SI',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SI_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SI_export_year(year,'import',country2)$(ntc(country2,'SI',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SI_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SI_export_year(year,'netimport',country2)$((ntc('SI',country2,year) + ntc(country2,'SI',year)) gt 0) = output_SI_export_year(year,'import',country2) - output_SI_export_year(year,'export',country2) + EPS;
output_SI_export_year(year,'ntc_export',country2)$(ntc('SI',country2,year) gt 0) = ntc('SI',country2,year) + EPS;
output_SI_export_year(year,'ntc_import',country2)$(ntc(country2,'SI',year) gt 0) = ntc(country2,'SI',year) + EPS;

output_SK_hour(year,hour_all,output_country_hour_set)$(hour(year,hour_all)) = output_country_hour('SK',year,hour_all,output_country_hour_set) + EPS;
output_SK_export_hour(year,hour_all,'export',country2)$(hour(year,hour_all) AND (ntc('SK',country2,year) gt 0)) = FLOW.L('SK',country2,year,hour_all) + EPS;
output_SK_export_hour(year,hour_all,'import',country2)$(hour(year,hour_all) AND (ntc(country2,'SK',year) gt 0)) = FLOW.L(country2,'SK',year,hour_all) + EPS;
output_SK_export_hour(year,hour_all,'netimport',country2)$(hour(year,hour_all) AND ((ntc('SK',country2,year) + ntc(country2,'SK',year)) gt 0)) = output_SK_export_hour(year,hour_all,'import',country2) - output_SK_export_hour(year,hour_all,'export',country2) + EPS;
output_SK_export_hour(year,hour_all,'ntc_export',country2)$(hour(year,hour_all) AND ((ntc('SK',country2,year) + ntc(country2,'SK',year)) gt 0)) = ntc_hour('SK',country2,year,hour_all) + EPS;
output_SK_export_hour(year,hour_all,'ntc_import',country2)$(hour(year,hour_all) AND ((ntc('SK',country2,year) + ntc(country2,'SK',year)) gt 0)) = ntc_hour(country2,'SK',year,hour_all) + EPS;

output_SK_year(year,output_country_year_set) = output_country_year('SK',year,output_country_year_set) + EPS;
output_SK_export_year(year,'export',country2)$(ntc('SK',country2,year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SK_export_hour(year,hour_all,'export',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SK_export_year(year,'import',country2)$(ntc(country2,'SK',year) gt 0) = (( sum(hour_all$(hour(year,hour_all)), output_SK_export_hour(year,hour_all,'import',country2)) * (8760/sum(hour(year,hour_all), 1)) ) / 1000) + EPS;
output_SK_export_year(year,'netimport',country2)$((ntc('SK',country2,year) + ntc(country2,'SK',year)) gt 0) = output_SK_export_year(year,'import',country2) - output_SK_export_year(year,'export',country2) + EPS;
output_SK_export_year(year,'ntc_export',country2)$(ntc('SK',country2,year) gt 0) = ntc('SK',country2,year) + EPS;
output_SK_export_year(year,'ntc_import',country2)$(ntc(country2,'SK',year) gt 0) = ntc(country2,'SK',year) + EPS;

output_nuclear_hour(year,hour_all,country,'Generation')$(hour(year,hour_all)) = GEN_CONV.L(country,'nuclear_new',year,hour_all) + EPS;
output_nuclear_hour(year,hour_all,country,'Price')$(hour(year,hour_all)) = output_country_hour(country,year,hour_all,'electricity price') + EPS;
output_nuclear_hour(year,hour_all,country,'Revenue')$(hour(year,hour_all)) = output_nuclear_hour(year,hour_all,country,'price') * output_nuclear_hour(year,hour_all,country,'generation') + EPS;
output_nuclear_hour(year,hour_all,country,'Cost')$(hour(year,hour_all)) = cvar_conv_avg(country,'nuclear_new',year) * GEN_CONV.L(country,'nuclear_new',year,hour_all) * (1 - indicator_partload_country(country))
                                           +
                                           cvar_conv_full(country,'nuclear_new',year) * GEN_CONV_FULL.L(country,'nuclear_new',year,hour_all) * indicator_partload_country(country)
                                           +
                                           cvar_conv_min(country,'nuclear_new',year) * GEN_CONV_MIN.L(country,'nuclear_new',year,hour_all) * indicator_partload_country(country)
                                           +
                                           cramp_conv(country,'nuclear_new',year) * ( CAP_CONV_UP.L(country,'nuclear_new',year,hour_all) + CAP_CONV_DOWN.L(country,'nuclear_new',year,hour_all) ) * indicator_ramping_country(country) + EPS;
output_nuclear_hour(year,hour_all,country,'ProfitContribution')$(hour(year,hour_all)) = output_nuclear_hour(year,hour_all,country,'Revenue') - output_nuclear_hour(year,hour_all,country,'Cost') + EPS;
