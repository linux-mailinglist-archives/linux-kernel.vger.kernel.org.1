Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF22FA0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391897AbhARNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:07:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:49493 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbhARNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:07:07 -0500
IronPort-SDR: NdAuvIMijyUZkN+ke7q69xjOuhDrmwrIAch+a0ZWDzN/iK5v6nyl3jSFupGhfSn82BFogil0qI
 hDTIiQa2gKRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="176227810"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="176227810"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 05:05:14 -0800
IronPort-SDR: Z4a7e9twg5ORZ3x9btiBnSsh5HzEFV6p2J/lJlFX/iclkhR1YWxwGNzRUUO9BE21p9QjkQRs+j
 C4NA5X2qPwDw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="383566818"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.255.29.150]) ([10.255.29.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 05:05:09 -0800
Subject: Re: [PATCH] x86/perf: Use static_call for x86_pmu.guest_get_msrs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>
References: <20210118072151.44481-1-like.xu@linux.intel.com>
 <202101182008.jQybUDa0-lkp@intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <a82754e7-9a2d-7ab4-466d-fc0d51a3b7f2@linux.intel.com>
Date:   Mon, 18 Jan 2021 21:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202101182008.jQybUDa0-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess this fix will silence the compiler error,
and v2 will be sent after the local 0day test passes.

diff --git a/arch/x86/include/asm/perf_event.h 
b/arch/x86/include/asm/perf_event.h
index b9a7fd0a27e2..517f546b6b45 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -479,15 +479,11 @@ static inline void perf_events_lapic_init(void)   { }
  static inline void perf_check_microcode(void) { }
  #endif

-#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
  extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+
+#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
  extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
  #else
-static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-       *nr = 0;
-       return NULL;
-}
  static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
  {
         return -1;

On 2021/1/18 20:12, kernel test robot wrote:
> Hi Like,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v5.11-rc4 next-20210118]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Like-Xu/x86-perf-Use-static_call-for-x86_pmu-guest_get_msrs/20210118-153219
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 9a7832ce3d920426a36cdd78eda4b3568d4d09e3
> config: x86_64-randconfig-a002-20210118 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 95d146182fdf2315e74943b93fb3bb0cbafc5d89)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          # https://github.com/0day-ci/linux/commit/0cd2262fad043a5edef91fca07d16759703658b8
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Like-Xu/x86-perf-Use-static_call-for-x86_pmu-guest_get_msrs/20210118-153219
>          git checkout 0cd2262fad043a5edef91fca07d16759703658b8
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/x86/events/core.c:670:31: error: redefinition of 'perf_guest_get_msrs'
>     struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
>                                   ^
>     arch/x86/include/asm/perf_event.h:486:45: note: previous definition is here
>     static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
>                                                 ^
>     1 error generated.
> 
> 
> vim +/perf_guest_get_msrs +670 arch/x86/events/core.c
> 
>     669	
>   > 670	struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
>     671	{
>     672		struct perf_guest_switch_msr *ret = NULL;
>     673	
>     674		ret = static_call(x86_pmu_guest_get_msrs)(nr);
>     675		if (!ret)
>     676			*nr = 0;
>     677	
>     678		return ret;
>     679	}
>     680	EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
>     681	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

