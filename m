Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9BB2D85F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407357AbgLLKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 05:43:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:2254 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407229AbgLLKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:42:53 -0500
IronPort-SDR: cwoXqHATOUA7/zzKjmM+f3Erj0I2flzuuLytG4EOIHfsJX5tjFdyZ1XO75gNlF9Qa941TSOJxy
 BezQJXJY4/VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="236127409"
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="236127409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 00:34:33 -0800
IronPort-SDR: fN3GIAMivlHD0E2aVUKZ+lANNw/T3+Q3mj4dc+BjfNzc2VyNv6m5/vb/UpGhFYEx1ro/hB7V7m
 d5J9KVWSxuuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="409722485"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2020 00:34:31 -0800
Date:   Sat, 12 Dec 2020 16:30:35 +0800
From:   Philip Li <philip.li@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [kbuild-all] Re: ERROR: "snd_soc_new_ac97_component" undefined!
Message-ID: <20201212083035.GA31146@intel.com>
References: <202012070230.Vq6VRv8j-lkp@intel.com>
 <ce6a995d-abb2-5599-cd42-bbf8143d3b35@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce6a995d-abb2-5599-cd42-bbf8143d3b35@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 04:16:17PM -0800, Randy Dunlap wrote:
> On 12/6/20 10:11 AM, kernel test robot wrote:
> > Hi Geert,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7059c2c00a2196865c2139083cbef47cd18109b6
> > commit: ea00d95200d02ece71f5814d41b14f2eb16d598b ASoC: Use imply for SND_SOC_ALL_CODECS
> > date:   10 months ago
> > config: powerpc-randconfig-r012-20201207 (attached as .config)
> > compiler: powerpc-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea00d95200d02ece71f5814d41b14f2eb16d598b
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ea00d95200d02ece71f5814d41b14f2eb16d598b
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ERROR: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
> >    ERROR: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
> >>> ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> >>> ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> >    ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
> >    ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
> 
> 
> I also see these:
> 
> ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> 
> and the (usual) missing Kconfig warnings:    :(
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
>   Selected by [m]:
>   - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
> 
> WARNING: unmet direct dependencies detected for SND_SOC_STAC9766
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AC97_BUS [=n]
>   Selected by [m]:
>   - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
> 
> WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>   Selected by [y]:
>   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
> 
> 
> 
> Please begin including Kconfig warnings. I have asked previously but...
Got it Randy, sorry for not enabling this earlier. We had initial code
ready early this month, but it was still pending for internal review. We will
share the progress next week, after back from 4 days holiday.

> 
> thanks.
> -- 
> ~Randy
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
