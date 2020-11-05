Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F42A881E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKEUbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:31:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:54217 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKEUbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:31:24 -0500
IronPort-SDR: 3DRaB82JlPVbQJhwyFv48wXKCBngmk0CtHLyNiZK1aEtGvVUtQ5a29lAHl5jYd1NR3T7LAxmkC
 7vqM7yUbhJNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="149308193"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="149308193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 12:31:22 -0800
IronPort-SDR: DvfQDpQLlf9z5w/pHVEp+J9h8UfyjqzRqL0SZYk8pAM7R1rSUhaCr0ykuhKVc3GxzWygqgr/Sy
 aGfevlBd0agQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="306982859"
Received: from lkp-server01.sh.intel.com (HELO a340e641b702) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2020 12:31:21 -0800
Received: from kbuild by a340e641b702 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kalui-00005s-Jr; Thu, 05 Nov 2020 20:31:20 +0000
Date:   Fri, 6 Nov 2020 04:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: drivers/idle/intel_idle.c:160:43: warning: Uninitialized variable:
 tick
Message-ID: <202011060418.zPSeUJ3h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4ef8451b332662d004df269d4cdeb7d9f31419b5
commit: 3f649ab728cda8038259d8f14492fe400fbab911 treewide: Remove uninitialized_var() usage
date:   4 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/idle/intel_idle.c:160:43: warning: Uninitialized variable: tick [uninitvar]
    if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
                                             ^

vim +160 drivers/idle/intel_idle.c

b1beab48f6148d5 Len Brown         2013-01-31  111  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  112  /**
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  113   * intel_idle - Ask the processor to enter the given idle state.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  114   * @dev: cpuidle device of the target CPU.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  115   * @drv: cpuidle driver (assumed to point to intel_idle_driver).
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  116   * @index: Target idle state index.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  117   *
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  118   * Use the MWAIT instruction to notify the processor that the CPU represented by
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  119   * @dev is idle and it can try to enter the idle state corresponding to @index.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  120   *
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  121   * If the local APIC timer is not known to be reliable in the target idle state,
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  122   * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  123   *
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  124   * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  125   * flushing user TLBs.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  126   *
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  127   * Must be called under local_irq_disable().
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  128   */
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  129  static __cpuidle int intel_idle(struct cpuidle_device *dev,
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  130  				struct cpuidle_driver *drv, int index)
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  131  {
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  132  	struct cpuidle_state *state = &drv->states[index];
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  133  	unsigned long eax = flg2MWAIT(state->flags);
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  134  	unsigned long ecx = 1; /* break on interrupt flag */
3f649ab728cda80 Kees Cook         2020-06-03  135  	bool tick;
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  136  	int cpu = smp_processor_id();
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  137  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  138  	/*
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  139  	 * leave_mm() to avoid costly and often unnecessary wakeups
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  140  	 * for flushing the user TLB's associated with the active mm.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  141  	 */
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  142  	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  143  		leave_mm(cpu);
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  144  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  145  	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  146  		/*
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  147  		 * Switch over to one-shot tick broadcast if the target C-state
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  148  		 * is deeper than C1.
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  149  		 */
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  150  		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  151  			tick = true;
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  152  			tick_broadcast_enter();
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  153  		} else {
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  154  			tick = false;
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  155  		}
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  156  	}
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  157  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  158  	mwait_idle_with_hints(eax, ecx);
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  159  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06 @160  	if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  161  		tick_broadcast_exit();
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  162  
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  163  	return index;
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  164  }
30a996fbb359ed5 Rafael J. Wysocki 2020-02-06  165  

:::::: The code at line 160 was first introduced by commit
:::::: 30a996fbb359ed53536a055af84a54223beabf91 intel_idle: Relocate definitions of cpuidle callbacks

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
