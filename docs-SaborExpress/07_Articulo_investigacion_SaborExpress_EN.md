# Architecture and Traceability of a Web and Mobile Platform for Restaurant Operations: A Documentary Case Study of SaborExpress

**Proyecto:** SaborExpress  |  **Fecha de corte:** 14 de octubre de 2026  |  **Versión:** 2.0  |  **Tipo:** Scientific manuscript in English

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

**Authors:** [Confirm actual authors] | **Affiliation:** [Institution and academic programme] | **Corresponding author:** [To be confirmed]

## Abstract

**Objective:** To characterize the source-evidenced architecture and validation gaps of SaborExpress, a restaurant-oriented information system combining web, mobile and backend components. **Method:** Descriptive and non-experimental documentary case study, grounded in static inspection of three public repositories and a targeted academic literature review on online food delivery, software architecture, security, digital identity and quality. **Results:** The backend targets ASP.NET Core 8 and includes Entity Framework Core, JWT, SignalR, business controllers and Wompi payment interfaces; the web project specifies Next.js 16 and React 19, while the mobile project uses Expo 57 and React Native 0.86. The inspected subset contains 52 declared HTTP methods across six controllers. **Conclusion:** Source inspection provides a traceability baseline, not evidence of system performance, user adoption, security compliance or successful real-world transactions.

**Keywords:** online food delivery; software engineering; restaurant management; web and mobile integration; traceability; digital payments.

## 1. Introduction

Online food delivery connects customers, kitchen operations, payment systems and delivery agents. Shroff et al. (2022) report a structured review of 43 studies and identify several research themes in food delivery. A complementary synthesis in the International Journal of Hospitality Management (2022) discusses theories and methods used in this field. Such evidence motivates analysing both technology and operational processes; however, the prior results are not direct evidence of SaborExpress outcomes. The system offers a concrete software artefact for investigating code structure and the limits of repository-based evidence.

## 2. Research problem and questions

Restaurant processes require coordination across products, locations, orders, payments and delivery. Potential inconsistencies can emerge when external payment notifications and internal order states are processed asynchronously, or when a user accesses resources assigned to another branch. Without an operational baseline, the study cannot quantify the prevalence or economic consequences of these risks. The central question is: **What integration capabilities and verification gaps are visible from the SaborExpress codebase?** Subquestions address technology structure, domain relationships, security-sensitive interfaces and future quality evaluation.

## 3. Related work

Food delivery research includes service reliability, convenience, perceived trust and logistics. The literature on delivery application service attributes (2021; DOI 10.1016/j.ijgfs.2021.100392), service quality and loyalty (British Food Journal, 2022) and customer satisfaction in a pandemic context (Prasetyo et al., 2021) indicates constructs that may be evaluated. The 2026 Colombian study by García-Umaña et al. relates continuance intention to an extended UTAUT2 model, delivery trust and perceived food quality, which provides locally relevant background without replacing project-specific field data. Davis (1989) and Venkatesh et al. (2003) underpin acceptance measures; Nielsen’s heuristics can inform interface audits. Kruchten (1995) guides multiple views of architecture, while Taibi et al. (2018) provide a contrast with microservice patterns. ISO/IEC/IEEE 29148:2018, ISO/IEC 25010:2023, OWASP API Security Top 10 (2023) and NIST SP 800-63B-4 (2025) frame requirements, quality and security. None of these references certifies the analysed system.

## 4. Methodology

The research employs a documentary, descriptive, cross-sectional case study inspired by Yin (2018). Units of analysis are `yersonct/SaborExpressBack`, `yersonct/SaborExpressWeb` and `yersonct/SaborExpressMovil`, together with the documentation repository, observed in October 2026. Inspection prioritised `Program.cs`, project manifests, data configuration, key controllers and entity models. Each claim was classified as directly evidenced, interpretative or pending operational validation. The literature review was targeted, not a formally registered systematic review; no PRISMA selection statistics are claimed. No participants, database production records, live payments or performance benchmarks were collected. Replication requires pinning exact commit SHAs.

## 5. Results

### 5.1. Source architecture

The backend `SaborExpress.csproj` specifies `net8.0`; `Program.cs` registers dependency injection, controllers, authentication/authorization, Swagger, SignalR, background services, migrations and seeders. `DatabaseConfiguration.cs` selects MySQL, SQL Server or PostgreSQL based on a string configuration value. The web manifest declares Next.js 16.2.6 and React 19.2.4. The mobile manifest lists Expo ~57.0.27 and React Native 0.86.3. These are declared dependencies, not proven production runtime versions.

### 5.2. Domain and interfaces

The analysed six controllers cover authentication, orders, products, payments, deliveries and branches. Their 52 annotated HTTP operations include session management, CRUD actions, status changes, Wompi payment initialisation and webhook handling, and delivery rating. Other controller modules are present but not all their routes were enumerated for this study. `Order` relates to a branch, optional customer/employee/table/address, details and payments. `Payment` carries Wompi reference fields; `Product.BranchId` is nullable for global items; `Delivery` includes assigned personnel, status and optional rating. These observations do not establish underlying SQL DDL correctness.

### 5.3. Security-sensitive design surfaces

Potential audit areas include development-oriented CORS handling, automatic database migration during startup, logging of webhook payloads, and authorisation semantics for branch-related paths. The webhook allows anonymous HTTP access as expected for an external provider but requires service-side validation of signature, reference and replay resistance. No penetration testing was performed, and the observations are not reported as exploited vulnerabilities.

![Logical architecture derived from inspected code](ARQUITECTURA-COMPONENTES.png)

*Figure 1. Logical component model derived from source code, not verified deployment topology.*

## 6. Discussion

The code reveals separation of interface and backend responsibilities and a central domain model for operational processes. A modular monolithic application must not be called a deployed microservices architecture merely because it contains independent modules. Prior food-delivery studies highlight trust, delivery experience and quality; these motivate evaluation criteria rather than providing evidence of local satisfaction. An API with JWT requires resource-scoped authorization testing, especially for cross-branch resources. The existence of three selectable database providers is a portability design affordance that remains to be verified with provider-specific migrations and integration tests. Similarly, the Wompi controller demonstrates an integration boundary but not confirmed real-world payment correctness.

## 7. Proposed evaluation plan

| Area | Suggested test | Observable outcome | State |
| --- | --- | --- | --- |
| Functional | Order creation/editing and state transition | Integrity and role-permitted changes | Not run |
| Payments | Wompi sandbox approved/rejected/duplicate webhooks | No duplicated posting | Not run |
| Security | Cross-user and cross-branch attempts | Denials without data leaks | Not run |
| Realtime | Concurrent SignalR sessions and reconnect | Measured delivery/consistency | Not run |
| Performance | Controlled HTTP load with instrumented sampling | p50/p95 with workload | Not run |
| Usability | Consent-based task sessions and questionnaires | Task success, errors, perceived ease | Not run |
| Recovery | Backup/restore and migration rollback rehearsal | Documented recovery | Not run |

Research should pre-register acceptable thresholds, environments, credentials policy, data anonymisation and analysis procedures. Proposed metrics are not presented as achieved performance.

## 8. Threats to validity

Construct validity is limited because source presence does not prove correct runtime behaviour. Internal validity is limited by unknown deployment settings and external integrations. External validity is limited by absence of real users or restaurant operational data. Reproducibility requires fixed commit identifiers and a known database engine. A targeted literature sample does not support exhaustiveness claims.

## 9. Conclusion

SaborExpress can be characterised as a multi-client restaurant platform with a modular ASP.NET Core API, EF Core persistence, JWT, SignalR and declared web and mobile clients. The most defensible outcome of the current study is architecture traceability and a testable validation agenda. Future work must observe actual payment integrity, cross-branch access controls, interface usability, recovery and performance before drawing causal conclusions about service improvements.

## 10. Ethical statement and declarations

No personal user records or financial credentials were used. The authors must provide their actual affiliation, funding, contribution and conflict-of-interest declarations before submission. The use of AI assistance, if applicable, must be disclosed according to the receiving institution’s rules.

## References

[1] Shroff, A., Shah, B. J., & Gajjar, H. (2022). Online food delivery research: A systematic literature review. International Journal of Contemporary Hospitality Management, 34(8), 2852–2883. https://doi.org/10.1108/IJCHM-10-2021-1273

[2] Online food delivery: A systematic synthesis of literature and a framework development. (2022). International Journal of Hospitality Management, 104, 103240. https://doi.org/10.1016/j.ijhm.2022.103240

[3] Influence of service attributes of food delivery application on customers’ satisfaction and their behavioural responses: The IPMA approach. (2021). International Journal of Gastronomy and Food Science, 25, 100392. https://doi.org/10.1016/j.ijgfs.2021.100392

[4] A model of online food delivery service quality, customer satisfaction and customer loyalty: A combination of PLS-SEM and NCA approaches. (2022). British Food Journal, 124(12), 4516–4532. https://doi.org/10.1108/BFJ-10-2021-1169

[5] Prasetyo, Y. T., et al. (2021). Factors affecting customer satisfaction and loyalty in online food delivery service during the COVID-19 pandemic: Its relation with open innovation. Journal of Open Innovation: Technology, Market, and Complexity, 7(1), 76. https://doi.org/10.3390/joitmc7010076

[6] García-Umaña, A., et al. (2026). Continuance intention in online food delivery platforms in Colombia: Extending UTAUT2 with delivery trust and food quality perception. Foods, 15(14), 2430. https://doi.org/10.3390/foods15142430

[7] Davis, F. D. (1989). Perceived usefulness, perceived ease of use, and user acceptance of information technology. MIS Quarterly, 13(3), 319–340. https://doi.org/10.2307/249008

[8] Venkatesh, V., Morris, M. G., Davis, G. B., & Davis, F. D. (2003). User acceptance of information technology: Toward a unified view. MIS Quarterly, 27(3), 425–478. https://doi.org/10.2307/30036540

[9] Kruchten, P. (1995). The 4+1 view model of architecture. IEEE Software, 12(6), 42–50. https://doi.org/10.1109/52.469759

[10] Taibi, D., Lenarduzzi, V., & Pahl, C. (2018). Architectural patterns for microservices: A systematic mapping study. Proceedings of CLOSER, 221–232. https://doi.org/10.5220/0006798302210232

[11] Yin, R. K. (2018). Case Study Research and Applications: Design and Methods (6th ed.). SAGE. https://study.sagepub.com/yin6e

[12] Kitchenham, B., & Charters, S. (2007). Guidelines for performing systematic literature reviews in software engineering. EBSE-2007-01. https://homepages.dcc.ufmg.br/~figueiredo/disciplinas/papers/guidelines-kitchenham.pdf

[13] ISO/IEC/IEEE. (2018). ISO/IEC/IEEE 29148:2018. Systems and software engineering: Requirements engineering. https://www.iso.org/standard/72089.html

[14] ISO/IEC. (2023). ISO/IEC 25010:2023. Systems and software engineering: Product quality model. https://www.iso.org/standard/78176.html

[15] OWASP Foundation. (2023). API Security Top 10. https://api-security.owasp.org/editions/2023/en/0x00-header/

[16] Temoshok, D., et al. (2025). Digital Identity Guidelines: Authentication and Authenticator Management (NIST SP 800-63B-4). https://doi.org/10.6028/NIST.SP.800-63b-4

[17] Jones, M., Bradley, J., & Sakimura, N. (2015). JSON Web Token (JWT) (RFC 7519). IETF. https://www.rfc-editor.org/rfc/rfc7519

[18] Fielding, R., Nottingham, M., & Reschke, J. (2022). HTTP Semantics (RFC 9110). IETF. https://www.rfc-editor.org/rfc/rfc9110

[19] Nielsen, J. (1994; revisión 2024). 10 usability heuristics for user interface design. Nielsen Norman Group. https://www.nngroup.com/articles/ten-usability-heuristics/

[20] Microsoft. (s. f.). ASP.NET Core documentation. https://learn.microsoft.com/en-us/aspnet/core/

[21] Microsoft. (s. f.). Entity Framework Core documentation. https://learn.microsoft.com/en-us/ef/core/

[22] Microsoft. (s. f.). ASP.NET Core SignalR documentation. https://learn.microsoft.com/en-us/aspnet/core/signalr/introduction

[23] Next.js. (s. f.). Next.js documentation. https://nextjs.org/docs

[24] Expo. (s. f.). Expo documentation. https://docs.expo.dev/

[25] Postman. (s. f.). Postman collection format. https://learning.postman.com/docs/collections/collections-overview/

[26] Wompi. (s. f.). Documentación para desarrolladores. https://docs.wompi.co/

[27] GitHub. (s. f.). GitHub Actions documentation. https://docs.github.com/en/actions

[28] Project Management Institute. (2021). A Guide to the Project Management Body of Knowledge (PMBOK Guide), 7th edition. https://www.pmi.org/pmbok-guide-standards/foundational/pmbok

