# Hive Ransomware Adversary Emulation Plan

This threat is based on the FBI Flash Alert on August 25,2021: https://www.ic3.gov/Media/News/2021/210825.pdf

## Summary from Cyber Threat Intelligence
Hive ransomware, which was first observed in June 2021 and likely operates as an affiliate-based ransomware, employs a wide variety oftactics, techniques, and procedures (TTPs), creating significant challenges for defense and mitigation. Hive ransomware uses multiple mechanisms to compromise business networks, including phishing emails with malicious attachments to gain access and Remote Desktop Protocol (RDP) to move laterally once on the network.

After compromising a victim network, Hive ransomware actors exfiltrate data and encrypt files on the network. The actors leave a ransom note in each affected directory within a victim’s system, which provides instructions on how to purchase the decryption software. The ransom note also threatens to leak exfiltrated victim data on the Tor site, “HiveLeaks.”

## Emulate with SCYTHE
**Note this threat, if executed with administrative privieleges, will disable services, delete Volume Shadow Copies, delete Windows Event Logs, and modify bootup. For testing purposes, you may want to test in non-production, make an offline backup, and/or or take a snapshot.

1. Download and import the threat in JSON format to your SCYTHE instance 
2. Download the Virtual File System (VFS) files under the VFS folder
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/Hive
4. Create a new campaign, selecting HTTPS, and conffigure your HTTPS communication options.
5. Import from Existing Threat: Hive
6. Launch Campaign
7. Download the EXE and rename it to Winlo_dump_64_SCY.exe