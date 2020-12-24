Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33622E2578
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgLXIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:35:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:64719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgLXIfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:35:01 -0500
IronPort-SDR: Z8CTWrphG6rfmEsN1KYKLNZOZld4awcnC+50FS02gTuBCWEVfyoVloDbtmxL6GxEGvmC3Ye2Jm
 u2wQSOM8w2oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="155916235"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="155916235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 00:34:13 -0800
IronPort-SDR: ItzDTMbRO3yZLIiF1PFSu5lpjUhUhFyZMEtVACdHEbXWeH97/ABsAxy49TD3AR6IaAHGPdru71
 A2K4TTVOGTOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="357335881"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga002.jf.intel.com with ESMTP; 24 Dec 2020 00:34:10 -0800
Date:   Thu, 24 Dec 2020 16:30:36 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Anup Patel <anup.patel@wdc.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [kbuild-all] drivers/clocksource/timer-clint.c:72:24: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <20201224083036.GA29938@intel.com>
References: <202012241612.ckjAZc2H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012241612.ckjAZc2H-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 04:11:17PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9
> commit: 2ac6795fcc085e8d03649f1bbd0d70aaff612cad clocksource/drivers: Add CLINT timer driver
> date:   4 months ago
> config: riscv-randconfig-s031-20201221 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-184-g1b896707-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2ac6795fcc085e8d03649f1bbd0d70aaff612cad
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2ac6795fcc085e8d03649f1bbd0d70aaff612cad
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
Hi Anup and all, kindly ignore extra reports against this commit, we will
check why it sends out ~10 duplicated reports. Sorry for the inconvenience.

Thanks

> 
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/clocksource/timer-clint.c:72:24: sparse: sparse: cast removes address space '__iomem' of expression
> >> drivers/clocksource/timer-clint.c:72:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
>    drivers/clocksource/timer-clint.c:72:24: sparse:     expected void const volatile [noderef] __iomem *addr
>    drivers/clocksource/timer-clint.c:72:24: sparse:     got unsigned int [usertype] *
>    drivers/clocksource/timer-clint.c:70:22: sparse: sparse: cast removes address space '__iomem' of expression
>    drivers/clocksource/timer-clint.c:70:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
>    drivers/clocksource/timer-clint.c:70:22: sparse:     expected void const volatile [noderef] __iomem *addr
>    drivers/clocksource/timer-clint.c:70:22: sparse:     got unsigned int [usertype] *
>    drivers/clocksource/timer-clint.c:219:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct clock_event_device [noderef] __percpu * @@
>    drivers/clocksource/timer-clint.c:219:36: sparse:     expected void *
>    drivers/clocksource/timer-clint.c:219:36: sparse:     got struct clock_event_device [noderef] __percpu *
> 
> vim +/__iomem +72 drivers/clocksource/timer-clint.c
> 
>     58	
>     59	#ifdef CONFIG_64BIT
>     60	static u64 notrace clint_get_cycles64(void)
>     61	{
>     62		return clint_get_cycles();
>     63	}
>     64	#else /* CONFIG_64BIT */
>     65	static u64 notrace clint_get_cycles64(void)
>     66	{
>     67		u32 hi, lo;
>     68	
>     69		do {
>     70			hi = clint_get_cycles_hi();
>     71			lo = clint_get_cycles();
>   > 72		} while (hi != clint_get_cycles_hi());
>     73	
>     74		return ((u64)hi << 32) | lo;
>     75	}
>     76	#endif /* CONFIG_64BIT */
>     77	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

