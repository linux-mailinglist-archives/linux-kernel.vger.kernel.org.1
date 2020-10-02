Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF5280D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgJBFh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:37:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:56894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBFh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:37:26 -0400
IronPort-SDR: 7wd5TxPFiKHQ98Es746ryDy5O5MZ3p0ZhT0uBCCwIQDsibOPPJR1jGJMynIkv2NSr7YsLhXuHU
 IxciZDUySVDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162999591"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="162999591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 22:37:25 -0700
IronPort-SDR: TeGlIgRcbd36KZxDDBbGZIa6OIj27F7dVF6ik2yNjnCdggOedu95B2Y+gHiUdecNXd57nT4dtw
 v4hGZU1/J3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="515047175"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2020 22:37:23 -0700
Date:   Fri, 2 Oct 2020 13:34:06 +0800
From:   Philip Li <philip.li@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [kbuild-all] Re: [PATCH] mm: memcg/slab: fix slab statistics in
 !SMP configuration
Message-ID: <20201002053405.GA30771@intel.com>
References: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <202010020814.M5nb692Y-lkp@intel.com>
 <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 05:55:59PM -0700, Roman Gushchin wrote:
> On Fri, Oct 02, 2020 at 08:08:40AM +0800, kbuild test robot wrote:
> > Hi Roman,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on mmotm/master]
> 
> It's a bogus error, the patch was applied onto mmotm/master, which doesn't
> contain necessary slab controller patches.
sorry for the wrong report, and thanks for the input, we will check
this to see whether we can find an appropriate base for this case.
Meanwhile, you can give a try to use --base option when git format patch, which
helps us to have more clue when looking for base info.

> 
> Thanks!
> 
> > 
> > url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/mm-memcg-slab-fix-slab-statistics-in-SMP-configuration/20201002-044114
> > base:   git://git.cmpxchg.org/linux-mmotm.git master
> > config: i386-randconfig-s002-20200930 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-201-g24bdaac6-dirty
> >         # https://github.com/0day-ci/linux/commit/3e4248734433fea1624e4971258042af2f231e02
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Roman-Gushchin/mm-memcg-slab-fix-slab-statistics-in-SMP-configuration/20201002-044114
> >         git checkout 3e4248734433fea1624e4971258042af2f231e02
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/linux/mm.h:1317,
> >                     from include/linux/memcontrol.h:20,
> >                     from include/linux/swap.h:9,
> >                     from include/linux/suspend.h:5,
> >                     from arch/x86/kernel/asm-offsets.c:13:
> >    include/linux/vmstat.h: In function '__mod_node_page_state':
> > >> include/linux/vmstat.h:295:6: error: implicit declaration of function 'vmstat_item_in_bytes' [-Werror=implicit-function-declaration]
> >      295 |  if (vmstat_item_in_bytes(item)) {
> >          |      ^~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> >    make[2]: *** [scripts/Makefile.build:99: arch/x86/kernel/asm-offsets.s] Error 1
> >    make[2]: Target '__build' not remade because of errors.
> >    make[1]: *** [Makefile:1139: prepare0] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:179: sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> > 
> > vim +/vmstat_item_in_bytes +295 include/linux/vmstat.h
> > 
> >    291	
> >    292	static inline void __mod_node_page_state(struct pglist_data *pgdat,
> >    293				enum node_stat_item item, int delta)
> >    294	{
> >  > 295		if (vmstat_item_in_bytes(item)) {
> >    296			VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> >    297			delta >>= PAGE_SHIFT;
> >    298		}
> >    299	
> >    300		node_page_state_add(delta, pgdat, item);
> >    301	}
> >    302	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.01.org_hyperkitty_list_kbuild-2Dall-40lists.01.org&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=a91mqnAqjcA0iLpnhkpBXCmVqE_BuOIny-YmkB8jp2U&s=4EiiISKLS8YORtIb2rqP7oxVeqhBmKzMHqJzWhDAuMw&e= 
> 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
