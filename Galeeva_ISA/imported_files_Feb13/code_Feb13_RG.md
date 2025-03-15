## Code from Feb 13th, 2025 RG ##
#### importing files onto server and demultiplexing to .qza file ####
#### also visualized into .qzv file ####

Screen: galeeva_import

```
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Users\ranam> ssh root@10.19.139.167
root@10.19.139.167's password:
Linux 73982dadc0e8 5.14.0-427.33.1.el9_4.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 16 10:56:24 EDT 2024 x86_64
 * * * * * * * * * * W A R N I N G * * * * * * * * * *
This computer system is the property of the University of British Columbia. It is for authorized use only. By using this system, all users acknowledge notice of, and agree to comply with Acceptable Use and Security of UBC Electronic Information and Systems (“Policy SC14”).   Unauthorized or improper use of this system may result in administrative disciplinary action, civil charges/criminal penalties, and/or other sanctions as set forth in the University’s Security Policies. By continuing to use this system you indicate your awareness of and consent to these terms and conditions of use.

LOG OFF IMMEDIATELY if you do not agree to the conditions stated in this warning.

Last login: Thu Feb 13 22:13:15 2025 from 128.189.116.78
(qiime2-2023.7) root@73982dadc0e8:~# cd /
(qiime2-2023.7) root@73982dadc0e8:/# ls
bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
(qiime2-2023.7) root@73982dadc0e8:/# cd mnt
(qiime2-2023.7) root@73982dadc0e8:/mnt# cd datasets/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets# ls
R_datasets  classifiers  project_1  project_2  silva_ref_files  test
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets# cd project_2
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2# cd COVID/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID# cd Russia/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# ls
covid_russia_manifest.tsv  covid_russia_metadata.tsv  seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# cd seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia/seqs# ls
SRR15326642_1.fastq.gz  SRR15326699_1.fastq.gz  SRR15326766_1.fastq.gz  SRR15326829_1.fastq.gz  SRR15326885_1.fastq.gz  SRR15326941_1.fastq.gz
SRR15326642_2.fastq.gz  SRR15326699_2.fastq.gz  SRR15326766_2.fastq.gz  SRR15326829_2.fastq.gz  SRR15326885_2.fastq.gz  SRR15326941_2.fastq.gz
SRR15326643_1.fastq.gz  SRR15326701_1.fastq.gz  SRR15326767_1.fastq.gz  SRR15326830_1.fastq.gz  SRR15326886_1.fastq.gz  SRR15326942_1.fastq.gz
SRR15326643_2.fastq.gz  SRR15326701_2.fastq.gz  SRR15326767_2.fastq.gz  SRR15326830_2.fastq.gz  SRR15326886_2.fastq.gz  SRR15326942_2.fastq.gz
SRR15326644_1.fastq.gz  SRR15326703_1.fastq.gz  SRR15326768_1.fastq.gz  SRR15326831_1.fastq.gz  SRR15326887_1.fastq.gz  SRR15326943_1.fastq.gz
SRR15326644_2.fastq.gz  SRR15326703_2.fastq.gz  SRR15326768_2.fastq.gz  SRR15326831_2.fastq.gz  SRR15326887_2.fastq.gz  SRR15326943_2.fastq.gz
SRR15326645_1.fastq.gz  SRR15326705_1.fastq.gz  SRR15326769_1.fastq.gz  SRR15326832_1.fastq.gz  SRR15326888_1.fastq.gz  SRR15326944_1.fastq.gz
SRR15326645_2.fastq.gz  SRR15326705_2.fastq.gz  SRR15326769_2.fastq.gz  SRR15326832_2.fastq.gz  SRR15326888_2.fastq.gz  SRR15326944_2.fastq.gz
SRR15326646_1.fastq.gz  SRR15326707_1.fastq.gz  SRR15326770_1.fastq.gz  SRR15326833_1.fastq.gz  SRR15326889_1.fastq.gz  SRR15326945_1.fastq.gz
SRR15326646_2.fastq.gz  SRR15326707_2.fastq.gz  SRR15326770_2.fastq.gz  SRR15326833_2.fastq.gz  SRR15326889_2.fastq.gz  SRR15326945_2.fastq.gz
SRR15326647_1.fastq.gz  SRR15326709_1.fastq.gz  SRR15326771_1.fastq.gz  SRR15326834_1.fastq.gz  SRR15326890_1.fastq.gz  SRR15326946_1.fastq.gz
SRR15326647_2.fastq.gz  SRR15326709_2.fastq.gz  SRR15326771_2.fastq.gz  SRR15326834_2.fastq.gz  SRR15326890_2.fastq.gz  SRR15326946_2.fastq.gz
SRR15326648_1.fastq.gz  SRR15326711_1.fastq.gz  SRR15326772_1.fastq.gz  SRR15326835_1.fastq.gz  SRR15326891_1.fastq.gz  SRR15326947_1.fastq.gz
SRR15326648_2.fastq.gz  SRR15326711_2.fastq.gz  SRR15326772_2.fastq.gz  SRR15326835_2.fastq.gz  SRR15326891_2.fastq.gz  SRR15326947_2.fastq.gz
SRR15326649_1.fastq.gz  SRR15326713_1.fastq.gz  SRR15326773_1.fastq.gz  SRR15326836_1.fastq.gz  SRR15326892_1.fastq.gz  SRR15326948_1.fastq.gz
SRR15326649_2.fastq.gz  SRR15326713_2.fastq.gz  SRR15326773_2.fastq.gz  SRR15326836_2.fastq.gz  SRR15326892_2.fastq.gz  SRR15326948_2.fastq.gz
SRR15326650_1.fastq.gz  SRR15326715_1.fastq.gz  SRR15326774_1.fastq.gz  SRR15326837_1.fastq.gz  SRR15326893_1.fastq.gz  SRR15326949_1.fastq.gz
SRR15326650_2.fastq.gz  SRR15326715_2.fastq.gz  SRR15326774_2.fastq.gz  SRR15326837_2.fastq.gz  SRR15326893_2.fastq.gz  SRR15326949_2.fastq.gz
SRR15326651_1.fastq.gz  SRR15326717_1.fastq.gz  SRR15326775_1.fastq.gz  SRR15326838_1.fastq.gz  SRR15326894_1.fastq.gz  SRR15326950_1.fastq.gz
SRR15326651_2.fastq.gz  SRR15326717_2.fastq.gz  SRR15326775_2.fastq.gz  SRR15326838_2.fastq.gz  SRR15326894_2.fastq.gz  SRR15326950_2.fastq.gz
SRR15326652_1.fastq.gz  SRR15326719_1.fastq.gz  SRR15326776_1.fastq.gz  SRR15326839_1.fastq.gz  SRR15326895_1.fastq.gz  SRR15326951_1.fastq.gz
SRR15326652_2.fastq.gz  SRR15326719_2.fastq.gz  SRR15326776_2.fastq.gz  SRR15326839_2.fastq.gz  SRR15326895_2.fastq.gz  SRR15326951_2.fastq.gz
SRR15326653_1.fastq.gz  SRR15326721_1.fastq.gz  SRR15326777_1.fastq.gz  SRR15326840_1.fastq.gz  SRR15326896_1.fastq.gz  SRR15326952_1.fastq.gz
SRR15326653_2.fastq.gz  SRR15326721_2.fastq.gz  SRR15326777_2.fastq.gz  SRR15326840_2.fastq.gz  SRR15326896_2.fastq.gz  SRR15326952_2.fastq.gz
SRR15326654_1.fastq.gz  SRR15326722_1.fastq.gz  SRR15326778_1.fastq.gz  SRR15326841_1.fastq.gz  SRR15326897_1.fastq.gz  SRR15326953_1.fastq.gz
SRR15326654_2.fastq.gz  SRR15326722_2.fastq.gz  SRR15326778_2.fastq.gz  SRR15326841_2.fastq.gz  SRR15326897_2.fastq.gz  SRR15326953_2.fastq.gz
SRR15326655_1.fastq.gz  SRR15326723_1.fastq.gz  SRR15326779_1.fastq.gz  SRR15326842_1.fastq.gz  SRR15326898_1.fastq.gz  SRR15326954_1.fastq.gz
SRR15326655_2.fastq.gz  SRR15326723_2.fastq.gz  SRR15326779_2.fastq.gz  SRR15326842_2.fastq.gz  SRR15326898_2.fastq.gz  SRR15326954_2.fastq.gz
SRR15326656_1.fastq.gz  SRR15326724_1.fastq.gz  SRR15326780_1.fastq.gz  SRR15326843_1.fastq.gz  SRR15326899_1.fastq.gz  SRR15326955_1.fastq.gz
SRR15326656_2.fastq.gz  SRR15326724_2.fastq.gz  SRR15326780_2.fastq.gz  SRR15326843_2.fastq.gz  SRR15326899_2.fastq.gz  SRR15326955_2.fastq.gz
SRR15326657_1.fastq.gz  SRR15326725_1.fastq.gz  SRR15326781_1.fastq.gz  SRR15326844_1.fastq.gz  SRR15326900_1.fastq.gz  SRR15326956_1.fastq.gz
SRR15326657_2.fastq.gz  SRR15326725_2.fastq.gz  SRR15326781_2.fastq.gz  SRR15326844_2.fastq.gz  SRR15326900_2.fastq.gz  SRR15326956_2.fastq.gz
SRR15326658_1.fastq.gz  SRR15326726_1.fastq.gz  SRR15326782_1.fastq.gz  SRR15326845_1.fastq.gz  SRR15326901_1.fastq.gz  SRR15326957_1.fastq.gz
SRR15326658_2.fastq.gz  SRR15326726_2.fastq.gz  SRR15326782_2.fastq.gz  SRR15326845_2.fastq.gz  SRR15326901_2.fastq.gz  SRR15326957_2.fastq.gz
SRR15326659_1.fastq.gz  SRR15326727_1.fastq.gz  SRR15326783_1.fastq.gz  SRR15326846_1.fastq.gz  SRR15326902_1.fastq.gz  SRR15326958_1.fastq.gz
SRR15326659_2.fastq.gz  SRR15326727_2.fastq.gz  SRR15326783_2.fastq.gz  SRR15326846_2.fastq.gz  SRR15326902_2.fastq.gz  SRR15326958_2.fastq.gz
SRR15326660_1.fastq.gz  SRR15326728_1.fastq.gz  SRR15326784_1.fastq.gz  SRR15326847_1.fastq.gz  SRR15326903_1.fastq.gz  SRR15326959_1.fastq.gz
SRR15326660_2.fastq.gz  SRR15326728_2.fastq.gz  SRR15326784_2.fastq.gz  SRR15326847_2.fastq.gz  SRR15326903_2.fastq.gz  SRR15326959_2.fastq.gz
SRR15326661_1.fastq.gz  SRR15326729_1.fastq.gz  SRR15326785_1.fastq.gz  SRR15326848_1.fastq.gz  SRR15326904_1.fastq.gz  SRR15326960_1.fastq.gz
SRR15326661_2.fastq.gz  SRR15326729_2.fastq.gz  SRR15326785_2.fastq.gz  SRR15326848_2.fastq.gz  SRR15326904_2.fastq.gz  SRR15326960_2.fastq.gz
SRR15326662_1.fastq.gz  SRR15326730_1.fastq.gz  SRR15326786_1.fastq.gz  SRR15326849_1.fastq.gz  SRR15326905_1.fastq.gz  SRR15326961_1.fastq.gz
SRR15326662_2.fastq.gz  SRR15326730_2.fastq.gz  SRR15326786_2.fastq.gz  SRR15326849_2.fastq.gz  SRR15326905_2.fastq.gz  SRR15326961_2.fastq.gz
SRR15326663_1.fastq.gz  SRR15326731_1.fastq.gz  SRR15326787_1.fastq.gz  SRR15326850_1.fastq.gz  SRR15326906_1.fastq.gz  SRR15326962_1.fastq.gz
SRR15326663_2.fastq.gz  SRR15326731_2.fastq.gz  SRR15326787_2.fastq.gz  SRR15326850_2.fastq.gz  SRR15326906_2.fastq.gz  SRR15326962_2.fastq.gz
SRR15326664_1.fastq.gz  SRR15326732_1.fastq.gz  SRR15326788_1.fastq.gz  SRR15326851_1.fastq.gz  SRR15326907_1.fastq.gz  SRR15326963_1.fastq.gz
SRR15326664_2.fastq.gz  SRR15326732_2.fastq.gz  SRR15326788_2.fastq.gz  SRR15326851_2.fastq.gz  SRR15326907_2.fastq.gz  SRR15326963_2.fastq.gz
SRR15326665_1.fastq.gz  SRR15326733_1.fastq.gz  SRR15326789_1.fastq.gz  SRR15326852_1.fastq.gz  SRR15326908_1.fastq.gz  SRR15326964_1.fastq.gz
SRR15326665_2.fastq.gz  SRR15326733_2.fastq.gz  SRR15326789_2.fastq.gz  SRR15326852_2.fastq.gz  SRR15326908_2.fastq.gz  SRR15326964_2.fastq.gz
SRR15326666_1.fastq.gz  SRR15326734_1.fastq.gz  SRR15326790_1.fastq.gz  SRR15326853_1.fastq.gz  SRR15326909_1.fastq.gz  SRR15326965_1.fastq.gz
SRR15326666_2.fastq.gz  SRR15326734_2.fastq.gz  SRR15326790_2.fastq.gz  SRR15326853_2.fastq.gz  SRR15326909_2.fastq.gz  SRR15326965_2.fastq.gz
SRR15326667_1.fastq.gz  SRR15326735_1.fastq.gz  SRR15326791_1.fastq.gz  SRR15326854_1.fastq.gz  SRR15326910_1.fastq.gz  SRR15326966_1.fastq.gz
SRR15326667_2.fastq.gz  SRR15326735_2.fastq.gz  SRR15326791_2.fastq.gz  SRR15326854_2.fastq.gz  SRR15326910_2.fastq.gz  SRR15326966_2.fastq.gz
SRR15326668_1.fastq.gz  SRR15326736_1.fastq.gz  SRR15326792_1.fastq.gz  SRR15326855_1.fastq.gz  SRR15326911_1.fastq.gz  SRR15326967_1.fastq.gz
SRR15326668_2.fastq.gz  SRR15326736_2.fastq.gz  SRR15326792_2.fastq.gz  SRR15326855_2.fastq.gz  SRR15326911_2.fastq.gz  SRR15326967_2.fastq.gz
SRR15326669_1.fastq.gz  SRR15326737_1.fastq.gz  SRR15326793_1.fastq.gz  SRR15326856_1.fastq.gz  SRR15326912_1.fastq.gz  SRR15326968_1.fastq.gz
SRR15326669_2.fastq.gz  SRR15326737_2.fastq.gz  SRR15326793_2.fastq.gz  SRR15326856_2.fastq.gz  SRR15326912_2.fastq.gz  SRR15326968_2.fastq.gz
SRR15326670_1.fastq.gz  SRR15326738_1.fastq.gz  SRR15326794_1.fastq.gz  SRR15326857_1.fastq.gz  SRR15326913_1.fastq.gz  SRR15326969_1.fastq.gz
SRR15326670_2.fastq.gz  SRR15326738_2.fastq.gz  SRR15326794_2.fastq.gz  SRR15326857_2.fastq.gz  SRR15326913_2.fastq.gz  SRR15326969_2.fastq.gz
SRR15326671_1.fastq.gz  SRR15326739_1.fastq.gz  SRR15326796_1.fastq.gz  SRR15326858_1.fastq.gz  SRR15326914_1.fastq.gz  SRR15326970_1.fastq.gz
SRR15326671_2.fastq.gz  SRR15326739_2.fastq.gz  SRR15326796_2.fastq.gz  SRR15326858_2.fastq.gz  SRR15326914_2.fastq.gz  SRR15326970_2.fastq.gz
SRR15326672_1.fastq.gz  SRR15326740_1.fastq.gz  SRR15326798_1.fastq.gz  SRR15326859_1.fastq.gz  SRR15326915_1.fastq.gz  SRR15326971_1.fastq.gz
SRR15326672_2.fastq.gz  SRR15326740_2.fastq.gz  SRR15326798_2.fastq.gz  SRR15326859_2.fastq.gz  SRR15326915_2.fastq.gz  SRR15326971_2.fastq.gz
SRR15326673_1.fastq.gz  SRR15326741_1.fastq.gz  SRR15326800_1.fastq.gz  SRR15326860_1.fastq.gz  SRR15326916_1.fastq.gz  SRR15326972_1.fastq.gz
SRR15326673_2.fastq.gz  SRR15326741_2.fastq.gz  SRR15326800_2.fastq.gz  SRR15326860_2.fastq.gz  SRR15326916_2.fastq.gz  SRR15326972_2.fastq.gz
SRR15326674_1.fastq.gz  SRR15326742_1.fastq.gz  SRR15326802_1.fastq.gz  SRR15326861_1.fastq.gz  SRR15326917_1.fastq.gz  SRR15326973_1.fastq.gz
SRR15326674_2.fastq.gz  SRR15326742_2.fastq.gz  SRR15326802_2.fastq.gz  SRR15326861_2.fastq.gz  SRR15326917_2.fastq.gz  SRR15326973_2.fastq.gz
SRR15326675_1.fastq.gz  SRR15326743_1.fastq.gz  SRR15326804_1.fastq.gz  SRR15326862_1.fastq.gz  SRR15326918_1.fastq.gz  SRR15326974_1.fastq.gz
SRR15326675_2.fastq.gz  SRR15326743_2.fastq.gz  SRR15326804_2.fastq.gz  SRR15326862_2.fastq.gz  SRR15326918_2.fastq.gz  SRR15326974_2.fastq.gz
SRR15326676_1.fastq.gz  SRR15326744_1.fastq.gz  SRR15326806_1.fastq.gz  SRR15326863_1.fastq.gz  SRR15326919_1.fastq.gz  SRR15326975_1.fastq.gz
SRR15326676_2.fastq.gz  SRR15326744_2.fastq.gz  SRR15326806_2.fastq.gz  SRR15326863_2.fastq.gz  SRR15326919_2.fastq.gz  SRR15326975_2.fastq.gz
SRR15326677_1.fastq.gz  SRR15326745_1.fastq.gz  SRR15326808_1.fastq.gz  SRR15326864_1.fastq.gz  SRR15326920_1.fastq.gz  SRR15326976_1.fastq.gz
SRR15326677_2.fastq.gz  SRR15326745_2.fastq.gz  SRR15326808_2.fastq.gz  SRR15326864_2.fastq.gz  SRR15326920_2.fastq.gz  SRR15326976_2.fastq.gz
SRR15326678_1.fastq.gz  SRR15326746_1.fastq.gz  SRR15326809_1.fastq.gz  SRR15326865_1.fastq.gz  SRR15326921_1.fastq.gz  SRR15326977_1.fastq.gz
SRR15326678_2.fastq.gz  SRR15326746_2.fastq.gz  SRR15326809_2.fastq.gz  SRR15326865_2.fastq.gz  SRR15326921_2.fastq.gz  SRR15326977_2.fastq.gz
SRR15326679_1.fastq.gz  SRR15326747_1.fastq.gz  SRR15326810_1.fastq.gz  SRR15326866_1.fastq.gz  SRR15326922_1.fastq.gz  SRR15326978_1.fastq.gz
SRR15326679_2.fastq.gz  SRR15326747_2.fastq.gz  SRR15326810_2.fastq.gz  SRR15326866_2.fastq.gz  SRR15326922_2.fastq.gz  SRR15326978_2.fastq.gz
SRR15326680_1.fastq.gz  SRR15326748_1.fastq.gz  SRR15326811_1.fastq.gz  SRR15326867_1.fastq.gz  SRR15326923_1.fastq.gz  SRR15326979_1.fastq.gz
SRR15326680_2.fastq.gz  SRR15326748_2.fastq.gz  SRR15326811_2.fastq.gz  SRR15326867_2.fastq.gz  SRR15326923_2.fastq.gz  SRR15326979_2.fastq.gz
SRR15326681_1.fastq.gz  SRR15326749_1.fastq.gz  SRR15326812_1.fastq.gz  SRR15326868_1.fastq.gz  SRR15326924_1.fastq.gz  SRR15326980_1.fastq.gz
SRR15326681_2.fastq.gz  SRR15326749_2.fastq.gz  SRR15326812_2.fastq.gz  SRR15326868_2.fastq.gz  SRR15326924_2.fastq.gz  SRR15326980_2.fastq.gz
SRR15326682_1.fastq.gz  SRR15326750_1.fastq.gz  SRR15326813_1.fastq.gz  SRR15326869_1.fastq.gz  SRR15326925_1.fastq.gz  SRR15326981_1.fastq.gz
SRR15326682_2.fastq.gz  SRR15326750_2.fastq.gz  SRR15326813_2.fastq.gz  SRR15326869_2.fastq.gz  SRR15326925_2.fastq.gz  SRR15326981_2.fastq.gz
SRR15326683_1.fastq.gz  SRR15326751_1.fastq.gz  SRR15326814_1.fastq.gz  SRR15326870_1.fastq.gz  SRR15326926_1.fastq.gz  SRR15326982_1.fastq.gz
SRR15326683_2.fastq.gz  SRR15326751_2.fastq.gz  SRR15326814_2.fastq.gz  SRR15326870_2.fastq.gz  SRR15326926_2.fastq.gz  SRR15326982_2.fastq.gz
SRR15326684_1.fastq.gz  SRR15326752_1.fastq.gz  SRR15326815_1.fastq.gz  SRR15326871_1.fastq.gz  SRR15326927_1.fastq.gz  SRR15326983_1.fastq.gz
SRR15326684_2.fastq.gz  SRR15326752_2.fastq.gz  SRR15326815_2.fastq.gz  SRR15326871_2.fastq.gz  SRR15326927_2.fastq.gz  SRR15326983_2.fastq.gz
SRR15326685_1.fastq.gz  SRR15326753_1.fastq.gz  SRR15326816_1.fastq.gz  SRR15326872_1.fastq.gz  SRR15326928_1.fastq.gz  SRR15326984_1.fastq.gz
SRR15326685_2.fastq.gz  SRR15326753_2.fastq.gz  SRR15326816_2.fastq.gz  SRR15326872_2.fastq.gz  SRR15326928_2.fastq.gz  SRR15326984_2.fastq.gz
SRR15326686_1.fastq.gz  SRR15326754_1.fastq.gz  SRR15326817_1.fastq.gz  SRR15326873_1.fastq.gz  SRR15326929_1.fastq.gz  SRR15326985_1.fastq.gz
SRR15326686_2.fastq.gz  SRR15326754_2.fastq.gz  SRR15326817_2.fastq.gz  SRR15326873_2.fastq.gz  SRR15326929_2.fastq.gz  SRR15326985_2.fastq.gz
SRR15326687_1.fastq.gz  SRR15326755_1.fastq.gz  SRR15326818_1.fastq.gz  SRR15326874_1.fastq.gz  SRR15326930_1.fastq.gz  SRR15326986_1.fastq.gz
SRR15326687_2.fastq.gz  SRR15326755_2.fastq.gz  SRR15326818_2.fastq.gz  SRR15326874_2.fastq.gz  SRR15326930_2.fastq.gz  SRR15326986_2.fastq.gz
SRR15326688_1.fastq.gz  SRR15326756_1.fastq.gz  SRR15326819_1.fastq.gz  SRR15326875_1.fastq.gz  SRR15326931_1.fastq.gz  SRR15326987_1.fastq.gz
SRR15326688_2.fastq.gz  SRR15326756_2.fastq.gz  SRR15326819_2.fastq.gz  SRR15326875_2.fastq.gz  SRR15326931_2.fastq.gz  SRR15326987_2.fastq.gz
SRR15326689_1.fastq.gz  SRR15326757_1.fastq.gz  SRR15326820_1.fastq.gz  SRR15326876_1.fastq.gz  SRR15326932_1.fastq.gz  SRR15326988_1.fastq.gz
SRR15326689_2.fastq.gz  SRR15326757_2.fastq.gz  SRR15326820_2.fastq.gz  SRR15326876_2.fastq.gz  SRR15326932_2.fastq.gz  SRR15326988_2.fastq.gz
SRR15326690_1.fastq.gz  SRR15326758_1.fastq.gz  SRR15326821_1.fastq.gz  SRR15326877_1.fastq.gz  SRR15326933_1.fastq.gz  SRR15326989_1.fastq.gz
SRR15326690_2.fastq.gz  SRR15326758_2.fastq.gz  SRR15326821_2.fastq.gz  SRR15326877_2.fastq.gz  SRR15326933_2.fastq.gz  SRR15326989_2.fastq.gz
SRR15326691_1.fastq.gz  SRR15326759_1.fastq.gz  SRR15326822_1.fastq.gz  SRR15326878_1.fastq.gz  SRR15326934_1.fastq.gz  SRR15326990_1.fastq.gz
SRR15326691_2.fastq.gz  SRR15326759_2.fastq.gz  SRR15326822_2.fastq.gz  SRR15326878_2.fastq.gz  SRR15326934_2.fastq.gz  SRR15326990_2.fastq.gz
SRR15326692_1.fastq.gz  SRR15326760_1.fastq.gz  SRR15326823_1.fastq.gz  SRR15326879_1.fastq.gz  SRR15326935_1.fastq.gz  SRR15326991_1.fastq.gz
SRR15326692_2.fastq.gz  SRR15326760_2.fastq.gz  SRR15326823_2.fastq.gz  SRR15326879_2.fastq.gz  SRR15326935_2.fastq.gz  SRR15326991_2.fastq.gz
SRR15326693_1.fastq.gz  SRR15326761_1.fastq.gz  SRR15326824_1.fastq.gz  SRR15326880_1.fastq.gz  SRR15326936_1.fastq.gz  SRR15326992_1.fastq.gz
SRR15326693_2.fastq.gz  SRR15326761_2.fastq.gz  SRR15326824_2.fastq.gz  SRR15326880_2.fastq.gz  SRR15326936_2.fastq.gz  SRR15326992_2.fastq.gz
SRR15326694_1.fastq.gz  SRR15326762_1.fastq.gz  SRR15326825_1.fastq.gz  SRR15326881_1.fastq.gz  SRR15326937_1.fastq.gz  SRR15326993_1.fastq.gz
SRR15326694_2.fastq.gz  SRR15326762_2.fastq.gz  SRR15326825_2.fastq.gz  SRR15326881_2.fastq.gz  SRR15326937_2.fastq.gz  SRR15326993_2.fastq.gz
SRR15326695_1.fastq.gz  SRR15326763_1.fastq.gz  SRR15326826_1.fastq.gz  SRR15326882_1.fastq.gz  SRR15326938_1.fastq.gz  SRR15326994_1.fastq.gz
SRR15326695_2.fastq.gz  SRR15326763_2.fastq.gz  SRR15326826_2.fastq.gz  SRR15326882_2.fastq.gz  SRR15326938_2.fastq.gz  SRR15326994_2.fastq.gz
SRR15326696_1.fastq.gz  SRR15326764_1.fastq.gz  SRR15326827_1.fastq.gz  SRR15326883_1.fastq.gz  SRR15326939_1.fastq.gz  SRR15326995_1.fastq.gz
SRR15326696_2.fastq.gz  SRR15326764_2.fastq.gz  SRR15326827_2.fastq.gz  SRR15326883_2.fastq.gz  SRR15326939_2.fastq.gz  SRR15326995_2.fastq.gz
SRR15326697_1.fastq.gz  SRR15326765_1.fastq.gz  SRR15326828_1.fastq.gz  SRR15326884_1.fastq.gz  SRR15326940_1.fastq.gz  russia_files.sh
SRR15326697_2.fastq.gz  SRR15326765_2.fastq.gz  SRR15326828_2.fastq.gz  SRR15326884_2.fastq.gz  SRR15326940_2.fastq.gz  wget-log
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia/seqs# cd -
/mnt/datasets/project_2/COVID/Russia
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# ls
covid_russia_manifest.tsv  covid_russia_metadata.tsv  seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# cd `
> cd ~
>
>
> cd ~
> cd `
(qiime2-2023.7) root@73982dadc0e8:~# cd ~
(qiime2-2023.7) root@73982dadc0e8:~# cd data/
(qiime2-2023.7) root@73982dadc0e8:~/data# ls
almomani_covid  galeeva_covid
(qiime2-2023.7) root@73982dadc0e8:~/data# cd galeeva_covid/
(qiime2-2023.7) root@73982dadc0e8:~/data/galeeva_covid# ls
(qiime2-2023.7) root@73982dadc0e8:~/data/galeeva_covid# cd /
(qiime2-2023.7) root@73982dadc0e8:/# cd mnt
(qiime2-2023.7) root@73982dadc0e8:/mnt# cd datasets/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets# cd project_2
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2# cd COVID/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID# ls
Jordan  Russia
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID# cd Jordan
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Jordan# ls -
ls: cannot access '-': No such file or directory
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Jordan# ls
covid_jordan_manifest.tsv  covid_jordan_metadata.tsv  seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Jordan# cd ~
(qiime2-2023.7) root@73982dadc0e8:~# cd data/
(qiime2-2023.7) root@73982dadc0e8:~/data# ls
almomani_covid  galeeva_covid
(qiime2-2023.7) root@73982dadc0e8:~/data# cd almomani_covid/
(qiime2-2023.7) root@73982dadc0e8:~/data/almomani_covid# ls
(qiime2-2023.7) root@73982dadc0e8:~/data/almomani_covid# cd /
(qiime2-2023.7) root@73982dadc0e8:/# cd mnt/
(qiime2-2023.7) root@73982dadc0e8:/mnt# cd datasets/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets# cd project_2
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2# cd COVID/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID# cd Russia/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# ls
covid_russia_manifest.tsv  covid_russia_metadata.tsv  seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Russia# cd -
/mnt/datasets/project_2/COVID
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID# cd Jordan/
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Jordan# ls
covid_jordan_manifest.tsv  covid_jordan_metadata.tsv  seqs
(qiime2-2023.7) root@73982dadc0e8:/mnt/datasets/project_2/COVID/Jordan#

```

Screen: almomani_import
```
(qiime2-2023.7) root@73982dadc0e8:~# cd data/
(qiime2-2023.7) root@73982dadc0e8:~/data# ls
almomani_covid  galeeva_covid
(qiime2-2023.7) root@73982dadc0e8:~/data# cd almomani_covid/
(qiime2-2023.7) root@73982dadc0e8:~/data/almomani_covid# qiime tools import \
        --type "SampleData[PairedEndSequencesWithQuality]" \
         --input-format PairedEndFastqManifestPhred33V2 \
        --input-path /mnt/datasets/project_2/COVID/Jordan/covid_jordan_manifest.tsv \
         --output-path ./almomani_demux_seqs.qza
Imported /mnt/datasets/project_2/COVID/Jordan/covid_jordan_manifest.tsv as PairedEndFastqManifestPhred33V2 to ./almomani_demux_seqs.qza
(qiime2-2023.7) root@73982dadc0e8:~/data/almomani_covid# qiime demux summarize \
  --i-data almomani_demux_seqs.qza \
  --o-visualization almomani_demux_seqs.qzv
Saved Visualization to: almomani_demux_seqs.qzv
(qiime2-2023.7) root@73982dadc0e8:~/data/almomani_covid# ls
almomani_demux_seqs.qza  almomani_demux_seqs.qzv  almomani_metadata.tsv
```

saved all metadata & .qzv files on to local computer and uploaded onto GitHub repository
attempted to move .qza files on to GitHub repository but encountered many errors, ensure .qza files are saved in the event that the server crashes
