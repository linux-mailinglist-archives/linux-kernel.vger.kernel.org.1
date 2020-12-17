Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F762DCB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 04:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgLQDQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 22:16:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:7158 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgLQDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:16:33 -0500
IronPort-SDR: gc6kRPNxr4Fc2FNLjzPGoe2KZ7/Nxr3n7UMgjGZswqdn+1zmniNXHOTBN0fsakncKAvmbXFte8
 ip6vxbQ8nCcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="193570418"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="193570418"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 19:15:52 -0800
IronPort-SDR: 4oHzYlo+1kQU+PSyO5+LggXlT0S/1CD25RZtptuFigj/c+mSQAACrmHnftvQeGrLkXvkB6x6ZP
 SZMxQgXcHhwQ==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="338939806"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 19:15:50 -0800
Subject: Re: [kbuild-all] Re: ERROR: "snd_soc_new_ac97_component" undefined!
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202012070230.Vq6VRv8j-lkp@intel.com>
 <ce6a995d-abb2-5599-cd42-bbf8143d3b35@infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <0c496357-7846-1200-39d5-b53fc650e0ac@intel.com>
Date:   Thu, 17 Dec 2020 11:15:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ce6a995d-abb2-5599-cd42-bbf8143d3b35@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/20 8:16 AM, Randy Dunlap wrote:
> On 12/6/20 10:11 AM, kernel test robot wrote:
>> Hi Geert,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7059c2c00a2196865c2139083cbef47cd18109b6
>> commit: ea00d95200d02ece71f5814d41b14f2eb16d598b ASoC: Use imply for SND_SOC_ALL_CODECS
>> date:   10 months ago
>> config: powerpc-randconfig-r012-20201207 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea00d95200d02ece71f5814d41b14f2eb16d598b
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout ea00d95200d02ece71f5814d41b14f2eb16d598b
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ERROR: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>>     ERROR: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>>>> ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>>>> ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>>     ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
>>     ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
>
> I also see these:
>
> ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>
> and the (usual) missing Kconfig warnings:    :(
>
> WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
>    Selected by [m]:
>    - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
>
> WARNING: unmet direct dependencies detected for SND_SOC_STAC9766
>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AC97_BUS [=n]
>    Selected by [m]:
>    - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
>
> WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>    Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>    Selected by [y]:
>    - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>
>
>
> Please begin including Kconfig warnings. I have asked previously but...
>
> thanks.

Hi Randy,

We have added Kconfig warnings in reports now. please see another 
report: 
https://lore.kernel.org/linux-block/202012170150.Y7ycOeI9-lkp@intel.com/

Best Regards,
Rong Chen
