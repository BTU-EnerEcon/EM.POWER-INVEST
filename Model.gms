*###############################################################################
*
*                                        Model
*
*###############################################################################

Variables
COST                                             Total costs = objective value
COST_GEN(year_all)                               Yearly generation costs
COST_INV(year_all)                               Yearly investment costs
COST_FIX(year_all)                               Yearly fix costs
CAP_CONV_RAMP(country_all,conv,year_all,hour_all)    Ramped capacity of conventional technologies
;

Positive Variables
GEN_CONV(country_all,conv,year_all,hour_all)         Generation of conventional technologies
GEN_CONV_FULL(country_all,conv,year_all,hour_all)    Generation of conventional technologies at full capacity
GEN_CONV_MIN(country_all,conv,year_all,hour_all)     Generation of conventional technologies at full minimum capacity

CAP_CONV_RTO(country_all,conv,year_all,hour_all)     Capacity ready-to-operate of conventional technologies
CAP_CONV_UP(country_all,conv,year_all,hour_all)      Startup capacity of conventional technologies
CAP_CONV_DOWN(country_all,conv,year_all,hour_all)    Shutdown capacity of conventional technologies

CAP_CONV_ADD(country_all,conv,year_all)                 Capacity investment in conventional technologies
CAP_CONV_SUB(country_all,conv,year_all)                 Capacity divestment in conventional technologies
CAP_CONV_INSTALL(country_all,conv,year_all)             Installed capacity in year of conventional technology

GEN_RENEW(country_all,renew,year_all,hour_all)   Generation of renewable technologies

CURT_RENEW(country_all,renew,year_all,hour_all)  Renewable curtailment
CURT_LOAD(country_all,year_all,hour_all)             Load curtailment

LEVEL(country_all,stor,year_all,hour_all)            Energy level of the storage
CHARGE(country_all,stor,year_all,hour_all)           Charge the storage
DISCHARGE(country_all,stor,year_all,hour_all)        Discharge the storage

FLOW(country_all,country_all,year_all,hour_all)      Export flow from A to B

;

Equations
DEF_COST                                 Definition of COST
DEF_COST_GEN                             Definition of COST_GEN
DEF_COST_INV                             Definition of COST_INV
DEF_COST_FIX                             Definition of COST_FIX
MCC                                      Market clearing condition (Energy balance)
DEF_CAP_CONV_RTO                         Definition of CAP_CONV_RTO
RES_CAP_CONV_RTO_up                      Upper bound for CAP_CONV_RTO
DEF_GEN_CONV                             Definition of GEN_CONV
RES_GEN_CONV_up                          Upper bound for GEN_CONV
RES_GEN_CONV_MIN_lo                      Lower bound for GEN_CONV_MIN
RES_GEN_CONV_lo                          Lower bound for GEN_CONV (due to chp production)
DEF_CAP_CONV_INSTALL                     Definition of CAP_CONV_INSTALL
DEF_CAP_CONV_INSTALL_start               Definition of the start condition for CAP_CONV_INSTALL
RES_CAP_CONV_SUB_lo                      Lower bound for CAP_CONV_SUB
RES_GEN_RENEW_up                         Upper bound for GEN_RENEW
RES_GEN_RENEW_lo                         Lower bound for GEN_RENEW (due to chp production)
RES_GEN_RENEW_yearly_potential           Restriction of renewable generation due to yearly fuel potential
RES_GEN_RENEW_monthly_potential          Restriction of renewable generation due to monthly fuel potential
RES_GEN_RENEW_reservoir_up               Upper bound for reservoir generation
RES_GEN_RENEW_reservoir_lo               Lower bound for reservoir generation
DEF_GEN_RENEW_curt                       Definition of GEN_RENEW for curtailable technologies
DEF_GEN_RENEW_ncurt                      Definition of GEN_RENEW for non-curtailable technologies
DEF_LEVEL                                Definition of LEVEL
DEF_LEVEL_start                          Definition of the start condition for LEVEL
DEF_LEVEL_end                            Definition of the end condition for LEVEL
RES_LEVEL_up                             Upper bound for LEVEL
RES_LEVEL_lo                             Lower bound for LEVEL
RES_CHARGE_up                            Upper bound for CHARGE
RES_DISCHARGE_up                         Upper bound for DISCHARGE
RES_EMISSION_up                          Upper bound for total yearly co2 emissions
RES_FLOW_up                              Upper bound for FLOW (export congestion)
RES_CAP_CONV_ADD_up
RES_CAP_CONV_NUCLEAR_up
RES_CAP_HARDCOAL_DE_up
;


DEF_COST..
         COST =E= sum(year, money_weighting_factor(year) * (COST_GEN(year) + COST_INV(year) + COST_FIX(year)))
;

DEF_COST_GEN(year)..

         COST_GEN(year) =E=

                 sum(country,

                         sum(conv$( ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) ),
                                 sum(hour_all$(hour(year,hour_all)),

                                         cvar_conv_avg(country,conv,year) * GEN_CONV(country,conv,year,hour_all) * (1 - indicator_partload_country(country))

                                         +

                                         cvar_conv_full(country,conv,year) * GEN_CONV_FULL(country,conv,year,hour_all) * indicator_partload_country(country)

                                         +

                                         cvar_conv_min(country,conv,year) * GEN_CONV_MIN(country,conv,year,hour_all) * indicator_partload_country(country)

                                         +

                                         cramp_conv(country,conv,year) * ( CAP_CONV_UP(country,conv,year,hour_all) + CAP_CONV_DOWN(country,conv,year,hour_all) ) * indicator_ramping_country(country)

                                 )
                         ) * (8760 / sum(hour(year,hour_all), 1))

                         +

                         sum(renew$(cvar_renew(country,renew,year) gt 0),
                                 sum(hour_all$(hour(year,hour_all)),

                                         cvar_renew(country,renew,year) * GEN_RENEW(country,renew,year,hour_all)

                                 )
                         ) * (8760 / sum(hour(year,hour_all), 1))

                         +

                         sum(renew_curt$(cap_renew_install_exogen(country,renew_curt,year) gt 0),
                                 sum(hour_all$(hour(year,hour_all)),

                                         ccurt_renew_year(year) * CURT_RENEW(country,renew_curt,year,hour_all)

                                 )
                         ) * (8760 / sum(hour(year,hour_all), 1))

                         +

                         sum(hour_all$(hour(year,hour_all)),

                                 ccurt_load_year(year) * CURT_LOAD(country,year,hour_all)

                         )  * (8760 / sum(hour(year,hour_all), 1))$(indicator_loadcurt(country) eq 1)

                 )
;

DEF_COST_INV(year)..

         COST_INV(year) =E=

                 sum(country,

*                        investment nur in technologien möglich die ab 2020 verfügbar sind
                         sum(conv$(convyear_lo(conv) ge 2020 ),

*                                   Investitionen fallen zwischen dem Jahr der Installation (year2) und dem Ende der Lebenszeit an (year2 + lifetime)                        Technolofien können nur in einem bestimmten Zeitraum installiert werden
                                 sum(year2$( ( yearnumber(year) ge yearnumber(year2) ) AND ( yearnumber(year) le (yearnumber(year2) + inputdata_conv(conv,'lifetime_tech')) ) AND ( yearnumber(year2) ge convyear_lo(conv) ) AND ( yearnumber(year2) le convyear_up(conv) ) ),

                                         cinv_conv(conv,year2) * CAP_CONV_ADD(country,conv,year2)

                                 )

                         )

                 )
;

DEF_COST_FIX(year)..

         COST_FIX(year) =E=

*                                   fix cost arise after year of investment
                 sum((country,conv)$( convyear_lo(conv) le yearnumber(year) ),

                         cfix_conv(conv,year) * CAP_CONV_INSTALL(country,conv,year)

                 )
;

MCC(country,year,hour_all)$(hour(year,hour_all))..

         sum(conv$( ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) ),

                 GEN_CONV(country,conv,year,hour_all)
         )

         +

         sum(renew$(cap_renew_install_exogen(country,renew,year) gt 0),
                 GEN_RENEW(country,renew,year,hour_all)
         )

         +

         sum(stor$(cap_stor_install_exogen(country,stor,year) gt 0),
                 DISCHARGE(country,stor,year,hour_all) - CHARGE(country,stor,year,hour_all)
         )

         +

         sum(country2$(ntc(country2,country,year) gt 0),
                 (1 - (grid_loss/2)) * FLOW(country2,country,year,hour_all)
         )

         =E=

         load(country,year,hour_all)

         -

         CURT_LOAD(country,year,hour_all)$(indicator_loadcurt(country) eq 1)

         +

         sum(country2$(ntc(country,country2,year) gt 0),
                 (1 + (grid_loss/2)) * FLOW(country,country2,year,hour_all)
         )

         +

         netexport_border(country,year,hour_all)
;

*###############################################################################
*        Constraints for conventional (non-renewable) generation technologies

DEF_CAP_CONV_RTO(country,conv,year,hour_all)$(hour(year,hour_all) AND ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         CAP_CONV_RTO(country,conv,year,hour_all) =E= CAP_CONV_RTO(country,conv,year,hour_all - step_hour(year,hour_all)) + ( CAP_CONV_UP(country,conv,year,hour_all) - CAP_CONV_DOWN(country,conv,year,hour_all) ) * indicator_ramping_country(country) + CAP_CONV_RAMP(country,conv,year,hour_all) * ( 1 - indicator_ramping_country(country) )
;


RES_CAP_CONV_RTO_up(country,conv,year,hour_all)$(hour(year,hour_all) AND ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         CAP_CONV_RTO(country,conv,year,hour_all) =L= availability_conv(country,conv,year,hour_all) * CAP_CONV_INSTALL(country,conv,year)
;

DEF_GEN_CONV(country,conv,year,hour_all)$(hour(year,hour_all) AND ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         GEN_CONV(country,conv,year,hour_all) =E= GEN_CONV_FULL(country,conv,year,hour_all) * indicator_partload_country(country) + GEN_CONV_MIN(country,conv,year,hour_all)
;

RES_GEN_CONV_up(country,conv,year,hour_all)$(hour(year,hour_all) AND ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         GEN_CONV(country,conv,year,hour_all) =L= CAP_CONV_RTO(country,conv,year,hour_all)
;

RES_GEN_CONV_MIN_lo(country,conv,year,hour_all)$(hour(year,hour_all) AND ( cap_conv_install_up(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         GEN_CONV_MIN(country,conv,year,hour_all) =G= gmin_conv(conv) * ( CAP_CONV_RTO(country,conv,year,hour_all) * indicator_ramping_country(country) - GEN_CONV_FULL(country,conv,year,hour_all) * indicator_partload_country(country) )
;

RES_GEN_CONV_lo(country,conv,year,hour_all)$(hour(year,hour_all) AND ( flh_chp_conv(country,conv) gt 0 ) AND ( convyear_lo(conv) le yearnumber(year) ) )..
         GEN_CONV(country,conv,year,hour_all) =G= flh_chp_conv(country,conv) * chp_structure_hour(country,year,hour_all) * CAP_CONV_INSTALL(country,conv,year) * indicator_chp
;

DEF_CAP_CONV_INSTALL(country,conv,year)$(yearnumber(year) gt 2020)..
         CAP_CONV_INSTALL(country,conv,year)

         =E=

         CAP_CONV_INSTALL(country,conv,year - 1)$( yearnumber(year - 1) ge convyear_lo(conv) )

         +

*                                        Investment erst ab 2022               Investment in eine Technologie nur in einem bestimmten Zeitraum möglich                   Investment nur in zulässige Technologien möglich
         CAP_CONV_ADD(country,conv,year)$( ( convyear_lo(conv) ge 2022 ) AND ( yearnumber(year) ge convyear_lo(conv) ) AND ( yearnumber(year) le convyear_up(conv) ) AND (cap_conv_add_forbidden(country,conv) eq 0)  )

         -

*        Divestment
         cap_conv_sub_old(country,conv,year) * (1 - indicator_divestment_country(country))

         -

*        Divestment einer Alterklasse erst ab der Folgeperiode des Investment möglich    UND     Divestment erst ab 2022 möglich
         CAP_CONV_SUB(country,conv,year)$((convyear_lo(conv) lt yearnumber(year)) AND ( yearnumber(year) ge 2022 )) * indicator_divestment_country(country)


;

DEF_CAP_CONV_INSTALL_start(country,conv,year)$(yearnumber(year) le 2020)..
         CAP_CONV_INSTALL(country,conv,year) =E=

         cap_conv_install_old(country,conv,year)

;

RES_CAP_CONV_SUB_lo(country,conv,year)$((indicator_divestment_country(country) eq 1) AND ( yearnumber(year) ge 2022))..

         sum(year2$(( yearnumber(year2) ge 2022 ) AND ( yearnumber(year2) le yearnumber(year) )),
                 CAP_CONV_SUB(country,conv,year2)$( yearnumber(year2) gt convyear_lo(conv) )
         )

         =G=

         sum(year2$(( yearnumber(year2) ge 2022 ) AND ( yearnumber(year2) le yearnumber(year) )),
                 cap_conv_sub_old(country,conv,year2)$( yearnumber(year2) gt convyear_lo(conv) )
         )

;

*###############################################################################
*        Constraints for renewable generation technologies

*Constraints for dispatchable renewables
RES_GEN_RENEW_up(country,renew_disp,year,hour_all)$(hour(year,hour_all) AND (inputdata_renew(renew_disp,'avail') lt 1))..
         GEN_RENEW(country,renew_disp,year,hour_all) =L= availability_renew(country,renew_disp,year,hour_all) * cap_renew_install_exogen(country,renew_disp,year)
;

RES_GEN_RENEW_lo(country,renew_disp,year,hour_all)$(hour(year,hour_all) AND (flh_chp_renew(country,renew_disp) gt 0))..
         GEN_RENEW(country,renew_disp,year,hour_all) =G= flh_chp_renew(country,renew_disp) * chp_structure_hour(country,year,hour_all) * cap_renew_install_exogen(country,renew_disp,year) * indicator_chp
;

RES_GEN_RENEW_yearly_potential(country,renew,year)$((fuelpotential_renew(country,renew,year) gt 0) AND (sum(month2, gen_renew_structure_monthly(country,renew,year,month2)) eq 0))..
         sum(hour_all$(hour(year,hour_all)),

                 ( GEN_RENEW(country,renew,year,hour_all) / efficiency_renew(renew) )

         ) * (8760 / sum(hour(year,hour_all), 1))

         =L=

         fuelpotential_renew(country,renew,year)
;

RES_GEN_RENEW_monthly_potential(country,renew,year,month)$(sum(month2, gen_renew_structure_monthly(country,renew,year,month2)) gt 0)..

         sum(hour_all$( hour(year,hour_all) AND map_hourmonth(year,hour_all,month) ),

                 ( GEN_RENEW(country,renew,year,hour_all) / efficiency_renew(renew) )

         ) * ( sum(hour_all$(map_hourmonth(year,hour_all,month)), 1) / sum(hour_all$( hour(year,hour_all) AND map_hourmonth(year,hour_all,month) ), 1) )

         =L=

         fuelpotential_renew(country,renew,year) * gen_renew_structure_monthly(country,renew,year,month)
;

RES_GEN_RENEW_reservoir_up(country,year,hour_all)$(hour(year,hour_all))..
         GEN_RENEW(country,'reservoir',year,hour_all) =L= capfactor_renew_max(country,'reservoir',year,hour_all) * cap_renew_install_exogen(country,'reservoir',year)
;

RES_GEN_RENEW_reservoir_lo(country,year,hour_all)$(hour(year,hour_all))..
         GEN_RENEW(country,'reservoir',year,hour_all) =G= capfactor_renew_min(country,'reservoir',year,hour_all) * cap_renew_install_exogen(country,'reservoir',year)
;

*Constraints for non-dispatchable renewables

DEF_GEN_RENEW_curt(country,renew_curt,year,hour_all)$(hour(year,hour_all))..
         GEN_RENEW(country,renew_curt,year,hour_all) + CURT_RENEW(country,renew_curt,year,hour_all) =E= capfactor_renew_max(country,renew_curt,year,hour_all) * cap_renew_install_exogen(country,renew_curt,year)
;

DEF_GEN_RENEW_ncurt(country,renew_ncurt,year,hour_all)$(hour(year,hour_all))..
         GEN_RENEW(country,renew_ncurt,year,hour_all) =E= capfactor_renew_max(country,renew_ncurt,year,hour_all) * cap_renew_install_exogen(country,renew_ncurt,year)
;

*###############################################################################
*        Constraints for storage technologies

DEF_LEVEL(country,stor,year,hour_all)$( hour(year,hour_all) AND ( ord(hour_all) gt first_hour(year) ) AND ( cap_stor_install_exogen(country,stor,year) gt 0 ) )..

         LEVEL(country,stor,year,hour_all)

         =E=

         LEVEL(country,stor,year,hour_all - step_hour(year,hour_all))

         +

         CHARGE(country,stor,year,hour_all) * efficiency_stor(stor)

         -

         DISCHARGE(country,stor,year,hour_all) * ( 1 / efficiency_stor(stor) )

;


DEF_LEVEL_start(country,stor,year,hour_all)$( hour(year,hour_all) AND ( ord(hour_all) eq first_hour(year) ) AND ( cap_stor_install_exogen(country,stor,year) gt 0 ) )..

         LEVEL(country,stor,year,hour_all)

         =E=

         cap_stor_install_exogen(country,stor,year) * storageduration(stor) * 0.5

         +

         CHARGE(country,stor,year,hour_all) * efficiency_stor(stor)

         -

         DISCHARGE(country,stor,year,hour_all) * ( 1 / efficiency_stor(stor) )

;

DEF_LEVEL_end(country,stor,year,hour_all)$( hour(year,hour_all) AND ( ord(hour_all) eq last_hour(year)  ) AND ( cap_stor_install_exogen(country,stor,year) gt 0 ) )..

         LEVEL(country,stor,year,hour_all)

         =E=

         cap_stor_install_exogen(country,stor,year) * storageduration(stor) * 0.5

;

RES_LEVEL_up(country,stor,year,hour_all)$( hour(year,hour_all) AND (cap_stor_install_exogen(country,stor,year) gt 0))..

         LEVEL(country,stor,year,hour_all)

         =L=

         ( 1 - 0.5 * ( 1 - avail_stor(stor) ) ) * cap_stor_install_exogen(country,stor,year) * storageduration(stor)

;

RES_LEVEL_lo(country,stor,year,hour_all)$( hour(year,hour_all) AND (cap_stor_install_exogen(country,stor,year) gt 0))..

         LEVEL(country,stor,year,hour_all)

         =G=

         0.5 * ( 1 - avail_stor(stor) ) * cap_stor_install_exogen(country,stor,year) * storageduration(stor)

;

RES_CHARGE_up(country,stor,year,hour_all)$(hour(year,hour_all) AND (cap_stor_install_exogen(country,stor,year) gt 0))..

         CHARGE(country,stor,year,hour_all)

         =L=

         avail_stor(stor) * cap_stor_install_exogen(country,stor,year)

;

RES_DISCHARGE_up(country,stor,year,hour_all)$(hour(year,hour_all) AND (cap_stor_install_exogen(country,stor,year) gt 0))..

         DISCHARGE(country,stor,year,hour_all)

         =L=

         avail_stor(stor) * cap_stor_install_exogen(country,stor,year)

;

RES_FLOW_up(country,country2,year,hour_all)$(hour(year,hour_all) AND (ntc(country,country2,year) gt 0))..
         FLOW(country,country2,year,hour_all) =L= ntc_hour(country,country2,year,hour_all)
;

RES_CAP_CONV_ADD_up(country,conv,year)$(convyear_lo(conv) ge 2020)..
         CAP_CONV_ADD(country,conv,year) =L= cap_conv_add_up(country,conv,year)
;

RES_CAP_CONV_NUCLEAR_up(country,year)..
         sum(conv$(map_convfuel(conv,'uranium')), CAP_CONV_INSTALL(country,conv,year))

         =L=

         sum(conv$(map_convfuel(conv,'uranium')), cap_conv_install_old(country,conv,'2017')) * 1.1
;

RES_CAP_HARDCOAL_DE_up(year)$(indicator_coalphaseout eq 1)..

         sum(conv$(map_convfuel(conv,'hardcoal')), CAP_CONV_INSTALL('DE+LU',conv,year))

         =L=

         sum(conv$(map_convfuel(conv,'hardcoal')), cap_conv_install_old_phaseout('DE+LU',conv,year))
;

MODEL Investment
/
DEF_COST
DEF_COST_GEN
DEF_COST_INV
DEF_COST_FIX
MCC
DEF_CAP_CONV_RTO
RES_CAP_CONV_RTO_up
DEF_GEN_CONV
RES_GEN_CONV_up
RES_GEN_CONV_MIN_lo
RES_GEN_CONV_lo
DEF_CAP_CONV_INSTALL
DEF_CAP_CONV_INSTALL_start
RES_CAP_CONV_SUB_lo
RES_GEN_RENEW_up
RES_GEN_RENEW_lo
RES_GEN_RENEW_yearly_potential
RES_GEN_RENEW_monthly_potential
RES_GEN_RENEW_reservoir_up
RES_GEN_RENEW_reservoir_lo
DEF_GEN_RENEW_curt
DEF_GEN_RENEW_ncurt
DEF_LEVEL
DEF_LEVEL_start
DEF_LEVEL_end
RES_LEVEL_up
RES_LEVEL_lo
RES_CHARGE_up
RES_DISCHARGE_up
RES_FLOW_up
RES_CAP_CONV_ADD_up
RES_CAP_CONV_NUCLEAR_up
RES_CAP_HARDCOAL_DE_up
/;
