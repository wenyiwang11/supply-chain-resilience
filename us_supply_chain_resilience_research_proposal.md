# Research Proposal for IEEE BigData 2026

## Working Title

**From Port Closures to Commodity Rerouting: Cross-Scale Mining of AIS and U.S. Import Data under Tropical Cyclones**

Short alternative:

**Mining Port Disruption, Recovery, and Commodity Rerouting from Public AIS and Trade Data**

## Target Venue and Paper Scope

This project targets the **12th Special Session on Intelligent Data Mining at IEEE BigData 2026**. The special-session call explicitly welcomes data-mining applications, industrial challenges, sustainability, sensors, knowledge integration, graph mining, clustering, and visualization. It requires the standard two-column IEEE format and lists **September 27, 2026** as the submission deadline. The general IEEE BigData call permits full papers of up to ten pages, including references. Unless the special-session organizer announces a different limit, this project will target a focused **6–8 page paper** and remain below ten pages.

Venue information:

- [Special Session on Intelligent Data Mining](https://bigdataieee.org/BigData2026/calls/special-data-mining/)
- [IEEE BigData 2026 Call for Papers](https://bigdataieee.org/BigData2026/calls/papers/)

The conference version will not attempt a complete economic model of U.S. supply-chain resilience. Its central contribution will be a reproducible data-mining framework that links high-frequency vessel disruption to lower-frequency commodity outcomes and distinguishes delay, recovery, and cross-port rerouting.

---

## Proposed Abstract

Extreme weather can interrupt port operations within hours, while its commodity-level consequences are observed only at monthly frequency. We propose a coverage-aware, cross-scale framework that integrates public Automatic Identification System trajectories, NOAA tropical-cyclone records, and U.S. Census imports at the port–HS4–country level. Finite entrance-gate crossings provide daily inbound and outbound vessel activity without treating missing AIS files as zero traffic. Stable commodity flows are identified entirely from pre-event months, and a pre-event bipartite network of ports and HS4-country flows defines plausible alternatives without post-treatment leakage. The framework then distinguishes four responses: operational interruption without monthly loss, delayed clearance and same-port recapture, cross-port rerouting, and persistent national loss. A pilot around Tropical Storm Bill finds a 50% reduction in Galveston Bay gate crossings during June 15–17, 2015, alongside a 12% event-month decline in seaborne import value. The conference study will evaluate the framework across multiple objectively selected U.S. tropical-cyclone–port events using coverage diagnostics, placebo dates, value-weight agreement, and leave-one-event-out sensitivity. The result is an interpretable approach for mining disruption and adaptation across heterogeneous spatial and temporal data.

---

## 1. Motivation and Research Gap

Tropical cyclones can close a port for hours or days, but the economic response is observed at several incompatible frequencies. AIS messages reveal operational interruption almost immediately, while public Census trade data report monthly commodity flows. A short closure may therefore be obvious in vessel movements but partially hidden in monthly totals through delayed clearance, inventory adjustment, or diversion to another port.

The existing literature covers important parts of this problem but leaves a useful cross-scale gap:

- Verschuur, Koks, and Hall (2020) use vessel tracking to study 141 port disruptions across 27 natural disasters. They find a median disruption of six days and limited short-run port substitution. The study establishes AIS as an operational resilience measure but does not trace HS4-by-country trade flows ([DOI](https://doi.org/10.1016/j.trd.2020.102393)).
- Kuai et al. (2026) introduce the CyPort dataset for 145 U.S. ports and 90 tropical cyclones from 2015–2023 and model operational impact, recovery duration, and freight-network effects. This makes it inappropriate to claim novelty merely from studying U.S. tropical-cyclone port disruption. The remaining opportunity is to identify which commodity-origin flows decline, recover, or move to empirically plausible alternative ports ([DOI](https://doi.org/10.1016/j.trd.2026.105420); [preprint](https://arxiv.org/abs/2509.22656)).
- Hamano and Vermeulen (2020) use monthly port-product-destination data after the 2011 Great East Japan Earthquake and estimate that at least 40% of exports were substituted to other ports. This demonstrates the importance of commodity-level port substitution, but it studies one Japanese earthquake without daily operational validation ([DOI](https://doi.org/10.1093/jeg/lbz020)).
- Jiao et al. (2026) link AIS shipping times, granular U.S. port-level trade, and prices, showing the value of combining operational and economic data. Their outcome is inflation rather than storm-induced port substitution ([article](https://doi.org/10.1257/pandp.20261119)).
- Recent AIS studies examine cyclone-induced shipping-network change and vessel delays, but generally do not connect daily port operations to U.S. HS4-country import rerouting ([Typhoon Ma-on study](https://doi.org/10.1016/j.trd.2024.104449); [Cyclone Veronica study](https://doi.org/10.1016/j.oceaneng.2024.118385)).

### Research gap

No novelty claim will be based on AIS disruption detection alone. The proposed gap is:

> **A coverage-aware, cross-frequency framework that links storm-exposed port operations to commodity-country import anomalies and mines rerouting through an alternative-port network defined entirely from pre-event data.**

The framework is designed to classify observed responses rather than assume that every operational shutdown causes rerouting.

---

## 2. Research Questions

### RQ1 — Operational disruption

Can daily AIS gate crossings reliably detect the depth and duration of tropical-cyclone disruption while distinguishing true zero traffic from missing or degraded AIS coverage?

### RQ2 — Commodity response

Which normally stable HS4 import flows exhibit abnormal declines in value and physical shipping weight during the event month, and which recover in the following month?

### RQ3 — Cross-port rerouting

When a stable commodity flow declines at an affected port, is the missing flow absorbed by alternative U.S. ports that handled the same HS4-country flow before the storm, or does national trade decline instead?

These questions produce four empirically distinguishable response classes:

1. **Operational interruption only:** AIS falls sharply, but monthly trade remains near baseline.
2. **Delay and recapture:** affected-port trade falls in the event month and rebounds at the same port soon afterward.
3. **Cross-port rerouting:** affected-port trade falls, pre-qualified alternative ports rise, and national imports remain comparatively stable.
4. **Persistent loss:** affected-port and national imports both remain below baseline.

---

## 3. Proposed Contributions

### Contribution 1 — Coverage-aware AIS disruption mining

Construct daily inbound and outbound vessel counts from finite entrance-gate crossings rather than counting all points inside a large bounding box. The pipeline explicitly records file availability and receiver/track diagnostics so that missing AIS observations are never treated as zero vessel activity.

### Contribution 2 — Cross-scale event representation

Link two native-frequency views through a common `port_group_id` and `event_id`:

\[
Day \times PortGroup \times VesselType
\]

and

\[
Month \times CensusPort \times HS4 \times Country.
\]

The method does not interpolate monthly trade to artificial daily values. Instead, it mines operational and economic anomalies at their observed frequencies.

### Contribution 3 — Pre-event alternative-port graph

Build a weighted port-substitutability network from pre-event HS4-country import profiles. Candidate alternatives must already handle the commodity-origin flow before treatment and must not be exposed to the same storm. This avoids selecting alternatives because they happened to increase after the event.

### Contribution 4 — Interpretable disruption-response taxonomy

Combine operational depth, recovery time, treated-port trade residuals, alternative-port absorption, and national residuals to classify each port-event-HS4 response as interruption, recapture, rerouting, or persistent loss.

The paper will emphasize interpretable mining and rigorous leakage prevention. A large model comparison or deep-learning component is not necessary for the first submission.

---

## 4. Current Data and Feasibility

### 4.1 Census import panel

The current panel is:

`data/interim/panel_port_hs4_month_2013_2025.parquet`

Verified coverage as of August 17, 2026:

- 32,021,578 rows;
- 2013–2025;
- 53 Schedule D ports;
- 1,237 observed HS4 codes;
- 235 country-code values, including the `-` port-total marker;
- monthly import value and shipping weight by vessel and other transport modes;
- NOAA storm fields already attached for exploratory screening.

The primary economic outcomes will use:

- `VES_VAL_MO`: vessel import value;
- `VES_WGT_MO`: vessel shipping weight;
- `CTY_CODE == '-'` for port-HS4 totals; and
- country-detail rows only when constructing source-specific flows and country concentration.

The `CTY_CODE == '-'` total rows and country-detail rows must never be summed together.

### 4.2 AIS data

The 2015 daily AIS archive currently contains all 365 daily files and 19 clipped study areas. Each file includes vessel identifier, timestamp, position, speed, vessel group, and study area. Twenty entrance-gate GeoJSON files are available, with some Census ports grouped behind a common waterway entrance.

AIS provides operational activity, not HS commodity identity. Its self-reported `Cargo` code must not be interpreted as an HS4 code.

### 4.3 Storm data

NOAA Storm Events records provide episode and event identifiers, state, event type, begin/end timestamps, damage fields, and narratives. NHC HURDAT2 tracks and wind radii should be used for named tropical cyclones where possible.

The current state-to-port `storm_month` field is useful for candidate discovery and plotting, but it is too coarse to serve as the final treatment definition: a storm recorded somewhere in Texas does not necessarily disrupt every Texas port.

### 4.4 Pilot result: Tropical Storm Bill

The completed pilot links the Galveston Bay entrance to Houston (5301), Texas City (5306), and Galveston (5310) around Tropical Storm Bill, June 15–17, 2015.

- AIS window: 43 of 43 daily files available;
- 2,729,441 AIS points in the study area;
- 2,234 accepted finite-gate crossings;
- pre-event mean: 53.95 crossings/day;
- event-window mean: 27.0 crossings/day, a 50.0% decline;
- June 16: 0 inbound and 4 outbound crossings;
- June vessel import value: $5.672 billion, 12.0% below the preceding six-month mean.

A strict exploratory screen also found nine normally stable HS4 categories whose June import value and weight both fell by at least 20%. The largest included HS7304 seamless iron/steel tubes and pipes, HS8429 construction machinery, and HS6402 rubber/plastic footwear. These are event-month associations, not proof that imports fell specifically during June 15–17 or because of the storm.

This pilot demonstrates feasibility and supplies a transparent case study, but it will not be presented as the paper's final causal result.

---

## 5. Conference-Paper Scope

### Core empirical sample

The minimum paper will use **four to six objectively selected tropical-cyclone–port events from 2015–2024** among the existing gated AIS study areas. Tropical Storm Bill remains a fixed pilot rather than the only event.

Candidate events may include Matthew (2016), Harvey (2017), Florence (2018), Dorian (2019), Ida (2021), and Ian (2022), subject to the pre-specified exposure and data-quality rules below. The final sample must be determined without inspecting post-event trade changes.

It is not necessary to download AIS for all 53 Census ports. Daily AIS is required only for treated port groups, credible operational comparison ports, and event windows used in the paper. Census data can still identify trade rerouting across all 53 ports.

### AIS download strategy

For years not yet complete, download only the selected event windows, normally:

\[
[-28,+56]\text{ days around operational exposure.}
\]

The complete 2015 archive can be used for seasonality and placebo diagnostics. Full-year AIS for every port and year is an extension, not a submission requirement.

---

## 6. Event and Port Definition

A port-event pair is eligible when all of the following are satisfied:

1. The event is a named tropical cyclone, tropical storm, hurricane, or associated storm surge/coastal flood.
2. The port entrance or port group intersects an NHC wind field, a pre-specified storm-track buffer, or a documented coastal hazard zone.
3. The port has a valid entrance gate and adequate AIS coverage in the analysis window.
4. The event has an externally recorded operational exposure, such as a USCG port condition, closure/reopening notice, or port-authority statement, when such documentation is available.

AIS decline and trade decline are outcomes and therefore cannot be used to decide whether an event enters the main sample.

Multiple Census ports behind one entrance—such as Houston, Texas City, and Galveston—will share one operational `port_group_id` while retaining separate Census port codes in the monthly panel.

---

## 7. Methodology

### 7.1 Daily AIS gate-crossing extraction

For each MMSI, sort observations by time and detect crossings of a finite entrance line. A crossing is retained when:

- consecutive observations are no more than 60 minutes apart;
- the current speed over ground is at least 0.5 knots;
- the vessel track intersects the finite gate segment; and
- the vessel has not produced another accepted crossing within the six-hour debounce period.

Direction is assigned relative to a landward reference point. Primary outcomes are daily inbound, outbound, and total cargo/tanker crossings.

Coverage diagnostics include file availability, messages per active MMSI, temporal gaps, spatial coverage, and the number of active vessels. Dates with missing files remain missing. Open-AIS studies emphasize that uneven receiver coverage can otherwise create false activity changes ([Hütten, 2026](https://arxiv.org/abs/2601.20211)).

### 7.2 Operational anomaly and recovery score

For port group \(p\) and day \(d\), compare observed crossings \(A_{pd}\) with a same-port, day-of-week-adjusted pre-event baseline. The primary robust score is:

\[
z^{AIS}_{pd}
=
\frac{A_{pd}-\operatorname{median}(A_{p,baseline(dow)})}
{1.4826\operatorname{MAD}(A_{p,baseline(dow)})+\epsilon}.
\]

Report:

- disruption depth: minimum valid daily score;
- cumulative disruption: sum of negative scores during the event window;
- recovery time: first three consecutive coverage-valid days within the pre-event tolerance band; and
- inbound/outbound asymmetry.

A negative-binomial count model with port, weekday, seasonal, and calendar controls will be a robustness check when enough full-year data are available. Change-point detection on coverage-valid residuals may be included as a secondary mining method, not as a separate headline contribution.

### 7.3 Stable HS4 flow selection

Commodity selection must use only pre-event data. The primary definition of a stable port-HS4 flow is:

- positive vessel imports in all six pre-event months;
- pre-event value coefficient of variation no greater than 0.25; and
- pre-event mean vessel import value of at least $10 million.

Thresholds of 0.20/0.30 and $5/$20 million will be sensitivity checks. A commodity-month decline is considered material when value and weight both fall, reducing the risk that price movements alone drive the result.

The monthly anomaly will be estimated from log vessel value and log vessel weight using the commodity's pre-event history, month-of-year seasonality, and national HS4-month conditions. The national component is important because a nationwide commodity decline must not be attributed to one port.

### 7.4 Pre-event alternative-port network

Construct a bipartite graph whose nodes are:

- U.S. Census ports; and
- HS4-country import flows.

Edge weights are pre-event vessel import value or weight. Project this graph to a port-to-port substitutability network using weighted cosine or Jaccard similarity of pre-event commodity-country profiles.

For treated port \(p\), commodity \(h\), country \(j\), an alternative port must:

1. handle \((h,j)\) before the event;
2. be active in at least four of the six pre-event months;
3. not be exposed to the same storm; and
4. rank among the top pre-event alternatives by flow share or profile similarity.

Geographic distance and coast/region will be reported as explanatory features, not assumed to determine substitutability. A Texas and Florida port, or an East and West Coast port, counts as a plausible substitute only when the pre-event commodity-country network supports it.

### 7.5 Rerouting and response classification

Let \(r^{T}_{ehm}\) be the treated-port residual for event \(e\), HS4 \(h\), and month \(m\), and let \(r^{A}_{ehm}\) be the sum of positive residuals at pre-qualified alternatives. Define a descriptive absorption ratio:

\[
Absorption_{ehm}
=
\frac{\sum_{a\in Alternatives}\max(r_{ahm},0)}
{|\min(r^{T}_{ehm},0)|+\epsilon}.
\]

This ratio will be interpreted jointly with national HS4 imports:

| Treated port | Pre-qualified alternatives | National imports | Response label |
|---|---|---|---|
| AIS down; trade stable | Stable | Stable | Operational interruption only |
| Down, then same-port rebound | No sustained increase | Stable | Delay and recapture |
| Down | Up | Approximately stable | Cross-port rerouting |
| Down | Stable or down | Down | Persistent loss |

The classification is descriptive unless supported by the event-study and placebo tests below.

### 7.6 Event-study validation

For pooled monthly inference, estimate a stacked event study with event-specific controls and pre-event-defined alternative ports:

\[
Y_{phet}
=
\alpha_{phe}
+
\gamma_{ht}
+
\sum_{k\neq-1}\beta_k D^k_{pet}
+
\varepsilon_{phet},
\]

where \(\alpha_{phe}\) is a port-HS4-event fixed effect and \(\gamma_{ht}\) is an HS4-calendar-month fixed effect. Primary outcomes are log vessel value, log vessel weight, and port share. The design is used to check pre-trends and pooled persistence; the cross-scale mining framework remains the paper's main contribution.

---

## 8. Evaluation and Robustness

### Required evaluation

1. **Event validity:** NOAA/NHC exposure and available USCG/port closure evidence.
2. **Coverage validity:** missing-file and AIS reception diagnostics; missing days are not zeros.
3. **Placebo dates:** repeat AIS and trade anomaly detection on matched non-event dates/months.
4. **Pre-trends:** show event-time coefficients before treatment.
5. **Value versus weight:** require consistent direction for headline commodity findings.
6. **Alternative-port leakage test:** alternatives are frozen before the event.
7. **National accounting:** distinguish local port loss from nationwide commodity loss.
8. **Leave-one-event-out sensitivity:** verify that pooled findings are not entirely due to Harvey or another single hurricane.

### Useful ablations

- finite-gate crossings versus raw bounding-box vessel counts;
- state-level storm tags versus spatial port exposure;
- alternative-port ranking by trade share versus profile similarity;
- stable-flow thresholds;
- event windows of \([-14,+28]\) and \([-28,+56]\) days;
- exclusion of 2020–2021 from pooled monthly estimates.

### Minimum success criteria

The paper remains viable if:

- at least three events show externally valid operational exposure and adequate AIS coverage;
- the AIS method detects materially stronger negative anomalies on event days than placebo days;
- monthly commodity responses can be classified without selecting alternatives after treatment; and
- results clearly distinguish short operational closure from monthly trade outcomes, even if rerouting is uncommon.

A finding of limited rerouting is scientifically meaningful and consistent with prior evidence for short disruptions. The paper must not force a positive rerouting result.

---

## 9. Expected Results and Claims

### Claims that the current data may support

1. A coverage-aware entrance-gate method detects short operational shutdowns that monthly trade totals obscure.
2. Stable commodities respond heterogeneously: some show no monthly effect, some are delayed and recaptured, and some experience persistent declines.
3. Pre-event commodity-country overlap identifies more defensible alternative ports than proximity or state labels alone.
4. Commodity rerouting, when observed, can be separated from aggregate import loss using treated, alternative, and national residuals.

### Claims that must not be made without additional evidence

- that a monthly HS4 decline occurred specifically during a three-day closure;
- that AIS `Cargo` codes identify imported HS commodities;
- that every same-state port was treated;
- that every increase at another port is causal rerouting;
- that a single storm demonstrates national supply-chain resilience; or
- that this is the first study of U.S. port disruption using AIS.

---

## 10. Planned Paper Structure and Outputs

### Manuscript structure: 6–8 pages

| Section | Target length |
|---|---:|
| Abstract and introduction | 0.8 page |
| Related work and gap | 0.6 page |
| Data and cross-scale linkage | 1.0 page |
| Mining methodology | 1.5 pages |
| Results | 2.0–2.5 pages |
| Limitations and conclusion | 0.5 page |
| References | 1.0–1.5 pages |

### Four core figures

1. **Cross-scale framework:** storm exposure → AIS disruption → HS4 response → alternative-port absorption.
2. **Tropical Storm Bill case:** daily inbound/outbound crossings plus monthly total and stable-HS4 imports.
3. **Pooled event-time result:** operational anomaly and monthly trade residual around selected events.
4. **Rerouting result:** pre-event port network and response-class/absorption summary.

### Two core tables

1. Dataset, event, port-group, and AIS coverage summary.
2. Event-level disruption, recovery, stable-commodity, and rerouting metrics.

An optional third table may report placebo, ablation, and leave-one-event-out results.

---

## 11. Six-Week Execution Plan

### August 17–23: freeze scope and event eligibility

- create the port-group/Census-port crosswalk;
- replace state-only treatment with spatial cyclone exposure;
- identify four to six candidate port-events without using outcomes;
- collect available USCG/port closure evidence;
- create an AIS file-availability manifest for every event window.

**Decision gate:** retain only events with defensible exposure, a valid gate, and sufficient AIS coverage.

### August 24–30: build operational metrics

- run gate-crossing extraction for selected windows;
- calculate coverage diagnostics;
- construct daily anomalies and recovery times;
- run matched-date placebo tests;
- finalize the Tropical Storm Bill validation figure.

### August 31–September 6: mine commodity responses

- implement stable-HS4 selection using pre-event data only;
- estimate value and weight residuals;
- construct event-month and recovery-month response labels;
- verify national HS4 accounting.

### September 7–13: build and test the alternative-port graph

- construct the pre-event port–HS4-country network;
- freeze alternative-port candidates;
- calculate absorption ratios;
- compare share-based and similarity-based alternatives;
- run event-study and leave-one-event-out checks.

### September 14–20: write the complete paper

- freeze methods and results;
- produce four final figures and two tables;
- draft the IEEE manuscript;
- write limitations explicitly, especially frequency mismatch and treatment uncertainty.

### September 21–26: reproducibility and submission QA

- rerun the pipeline from processed Parquet inputs;
- verify every reported number;
- check IEEE formatting and page count;
- edit for a single contribution narrative;
- submit before September 27, 2026, 11:59 p.m. PST.

---

## 12. Minimum Publishable Version and Pivot Rules

### Minimum publishable version

The paper needs:

1. three or more objectively selected port-events;
2. a reproducible, coverage-aware AIS gate-crossing method;
3. a linked monthly HS4-country panel;
4. stable-commodity anomaly detection;
5. pre-event alternative-port selection;
6. at least one pooled or multi-event evaluation plus placebo tests; and
7. an honest response taxonomy, whether or not substantial rerouting is found.

### Pivot A — rerouting is rare

Retitle the paper:

**When Port Closures Do Not Become Trade Rerouting: Cross-Scale Evidence from AIS and U.S. Imports**

Emphasize the mismatch between sharp daily shutdowns and muted monthly outcomes, consistent with delay and production/cargo recapture.

### Pivot B — only a few AIS events pass coverage checks

Present the work as an interpretable multi-source mining method with two or three deeply validated cases and extensive placebo/coverage analysis. Do not claim nationwide causal effects.

### Pivot C — monthly causal estimates are weak

Keep the commodity-response and alternative-port components descriptive, and center the contribution on coverage-aware cross-scale event characterization.

---

## Core Research Statement

> **This study develops a coverage-aware, cross-scale data-mining framework that connects daily AIS evidence of tropical-cyclone port disruption with monthly U.S. HS4-country import flows, then uses a pre-event port-substitutability network to distinguish operational interruption, delayed recovery, cross-port rerouting, and persistent trade loss.**

This statement is narrower and more defensible than claiming to explain all dimensions of U.S. supply-chain resilience. It also aligns directly with the Intelligent Data Mining session's interests in heterogeneous data integration, graph mining, sustainability, sensors, and real-world industrial applications.

---

## References

1. Hamano, M., & Vermeulen, W. N. (2020). Natural disasters and trade: the mitigating impact of port substitution. *Journal of Economic Geography, 20*(3), 809–856. <https://doi.org/10.1093/jeg/lbz020>
2. Hütten, M. (2026). High-Resolution Mapping of Port Dynamics from Open-Access AIS Data in Tokyo Bay. arXiv:2601.20211. <https://arxiv.org/abs/2601.20211>
3. Jiao, Y., Lan, T., Liu, Y., & Zhou, X. (2026). From Ports to Prices: The Inflationary Effects of Global Supply Chain Disruptions. *AEA Papers and Proceedings, 116*, 646–651. <https://doi.org/10.1257/pandp.20261119>
4. Kuai, C., Li, Z., Zhang, Y., Wang, X. B., Lord, D., & Zhou, Y. (2026). U.S. port disruptions under tropical cyclones: Resilience analysis by harnessing multiple-source dataset. *Transportation Research Part D, 157*, 105420. <https://doi.org/10.1016/j.trd.2026.105420>
5. Verschuur, J., Koks, E. E., & Hall, J. W. (2020). Port disruptions due to natural disasters: Insights into port and logistics resilience. *Transportation Research Part D, 85*, 102393. <https://doi.org/10.1016/j.trd.2020.102393>
6. Huang, Z., He, Z., Zhao, P., Zhang, C., Niu, Y., Guo, W., Cui, Y., & Shao, W. (2024). The effects of tropical cyclone on the container shipping network: A case study of Typhoon Ma-on (2022). *Transportation Research Part D, 136*, 104449. <https://doi.org/10.1016/j.trd.2024.104449>
7. Zhang, C., Zhao, P., Huang, Z., He, Z., Niu, Y., Huang, G., & Chen, Y. (2024). Assessing vessel transportation delays affected by tropical cyclones using AIS data and a Bayesian network: A case study of Veronica in northwestern Australia. *Ocean Engineering, 308*, 118385. <https://doi.org/10.1016/j.oceaneng.2024.118385>

## Data Documentation

- NOAA Marine Cadastre historical vessel traffic data: <https://www.coast.noaa.gov/digitalcoast/data/vesseltraffic.html>
- NOAA Storm Events Database: <https://www.ncei.noaa.gov/stormevents/>
- National Hurricane Center data archive and HURDAT2: <https://www.nhc.noaa.gov/data/>
- U.S. Census Schedule D port codes: <https://www.census.gov/foreign-trade/schedules/d/dist.txt>
