# BlackCat Ransomware

## Cyber Threat Intelligence
BlackCat is a double-extortion Ransomware-as-a-Service provider first observed in November 2021 targeting companies in multiple countries including Australia, Belgium, Germany, India, Philippines and the USA. Incident reports suggest adversary behaviors similar to [DarkSide](https://github.com/scythe-io/community-threats/tree/master/DarkSide), [Egregor](https://github.com/scythe-io/community-threats/tree/master/Egregor), [Hive](https://github.com/scythe-io/community-threats/tree/master/Hive) and [REvil](https://github.com/scythe-io/community-threats/tree/master/REvil). Victims include organizations in the following sectors: construction and engineering, retail, transportation, commercial services, insurance, machinery, professional services, telecommunication, auto components and pharmaceuticals.[^3]

### Net New Observables
The malware itself is coded in the Rust programming language. Though this is not the first piece of malware to use Rust, it is one of the first, if not the first, piece of ransomware to use it. By leveraging this programming language, the malware authors are able to easily compile it against various operating system architectures. Given its numerous native options, Rust is highly customizable, which facilitates the ability to pivot and individualize attacks.[^3]

## Automated Emulation with SCYTHE


## References
- [^1]: [Palo Alto Networks Unit42](https://unit42.paloaltonetworks.com/blackcat-ransomware/)
- [^2]: [SentinelOne Labs Threat Intelligence](https://www.sentinelone.com/labs/blackcat-ransomware-highly-configurable-rust-driven-raas-on-the-prowl-for-victims/)
- [^3]: [Symantec Enterprise Threat Intelligence](https://symantec-enterprise-blogs.security.com/blogs/threat-intelligence/noberus-blackcat-alphv-rust-ransomware)