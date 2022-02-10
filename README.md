# Community Threats Library
This repository is a place to share attack chains for testing people, process, and technology with the entire community. It is the largest, public library of adversary emulation and adversary simulation plans! We support sharing threats in [markdown](https://github.com/scythe-io/purple-team-exercise-framework/blob/master/Templates/Template_README.md), [SCYTHE JSON](https://github.com/scythe-io/purple-team-exercise-framework/tree/master/Templates/SCYTHE) and [MITRE ATT&CK Navigator JSON](https://github.com/mitre-attack/attack-navigator/blob/master/layers/LAYERFORMATv4_3.md).

## How-to use the library
1. Select the adversary folder you are interested in.
2. Review the README and/or the respective [#ThreatThursday blog post](https://www.scythe.io/threatthursday)
3. Download the respective JSON file for importing into SCYTHE or MITRE ATT&CK Navigator

## Import into SCYTHE
1. Login to the SCYTHE instance where you want to migrate the threat to
2. Click Threat Manager - Migrate Threats
3. Under "Import Threat" click "Choose File" and select the JSON file 
4. Click Import
5. The threat will now appear in your Threat Catalog 

## Import into MITRE ATT&CK Navigator
1. Launch [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)
2. Select Open Existing Layer
3. Upload from local - upload the JSON downloaded from the library, syntax used in this repo is `$ThreatName_ATT&CK_Navigator.json`
4. You may also load it straight from GitHub by using raw JSON URL link and replacing the `#layer_url` For example: https://mitre-attack.github.io/attack-navigator/#layerURL=https://raw.githubusercontent.com/scythe-io/community-threats/master/APT41/APT41_ATT%26CK_Navigator.json

## Community Effort
The SCYTHE herd is all about sharing with the community. This is the reason for making our Community Threats Github repository public. Our goal is to grow this repository by having our partners and customers contribute their knowledge through custom threats. We support sharing threats in [markdown](https://github.com/scythe-io/purple-team-exercise-framework/blob/master/Templates/Template_README.md), [SCYTHE JSON](https://github.com/scythe-io/purple-team-exercise-framework/tree/master/Templates/SCYTHE) and [MITRE ATT&CK Navigator JSON](https://github.com/mitre-attack/attack-navigator/blob/master/layers/LAYERFORMATv4_3.md).

### Contribute Threats
1. Login to the SCYTHE instance where you want to export the threat from
2. Select Migrate Threats from the left sidebar.
3. Locate the custom threat and click the threat name. This will automatically download a JSON file. The naming convention for the threat JSON files is `$ThreatName_scythe_threat.json`
4. Edit the JSON file with a text editor to remove your communication parameters (opsec). The communication parameters will contain the IP address or domain that was used during the campaign. Change the information in the JSON file, with any text editor, if it should not be public. Use 127.0.0.1 as the IP address. Example --cp 127.0.0.1:443
5. If there are associated VFS files use the threat name as the folder name and upload into the GitHub folder as `VFS` Example: https://github.com/scythe-io/community-threats/tree/master/Conti/VFS
6. Create a README.md and include instructions required to run the threat. If there is an associated VFS folder/files, include instructions for this. Here is a template for [markdown](https://github.com/scythe-io/purple-team-exercise-framework/blob/master/Templates/Template_README.md).
