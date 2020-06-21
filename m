Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD5202960
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFUHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 03:36:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:16490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgFUHgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:36:46 -0400
IronPort-SDR: wF5EK7ZOAEv6rtVCIUZfPn+9f18vYDreaxBjvRv3BUVnmCVfiql1OCYec6OZHNcylJIY5vmQ7t
 DmyAsvFkrUvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="204986705"
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="204986705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 00:36:45 -0700
IronPort-SDR: 2ZkjyPoeCU9wUIj4c9zkEnAOGKB/KZbBwhhJ45d23HKoc/wUjqnyRWC1lWrbR5sYW5XywW/oFQ
 F9IUtRHztcQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="478102505"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2020 00:36:41 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5 0/3] make vm_committed_as_batch aware of vm overcommit policy
Date:   Sun, 21 Jun 2020 15:36:37 +0800
Message-Id: <1592725000-73486-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a performance change for will-it-scale scalability
mmap test [1], we found very high lock contention for spinlock of
percpu counter 'vm_committed_as':

    94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
    48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
    45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;

Actually this heavy lock contention is not always necessary. The
'vm_committed_as' needs to be very precise when the strict
OVERCOMMIT_NEVER policy is set, which requires a rather small batch
number for the percpu counter.

So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy,
and enlarge it for not-so-strict  OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS
policies.

Benchmark with the same testcase in [1] shows 53% improvement on a
8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And for that
case, whether it shows improvements depends on if the test mmap size
is bigger than the batch number computed.

We tested 10+ platforms in 0day (server, desktop and laptop). If we
lift it to 64X, 80%+ platforms show improvements, and for 16X lift,
1/3 of the platforms will show improvements.

And generally it should help the mmap/unmap usage,as Michal Hocko
mentioned:

: I believe that there are non-synthetic worklaods which would benefit
: from a larger batch. E.g. large in memory databases which do large
: mmaps during startups from multiple threads.

Note: There are some style complain from checkpatch for patch 3,
as sysctl handler declaration follows the similar format of sibling
functions

[1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/

patch1: a cleanup for /proc/meminfo
patch2: a preparation patch which also improve the accuracy of
        vm_memory_committed
patch3: main change

This is against today's linux-mm git tree on github.

Please help to review, thanks!

- Feng

----------------------------------------------------------------
Changelog:

  v5:
    * rebase after 5.8-rc1
    * remove the 3/4 patch in v4  which is merged in v5.7
    * add code comments for vm_memory_committed() 

  v4:
    * Remove the VM_WARN_ONCE check for vm_committed_as underflow,
      thanks to Qian Cai for finding and testing the warning

  v3:
    * refine commit log and cleanup code, according to comments
      from Michal Hocko and Matthew Wilcox
    * change the lift from 16X and 64X after test 
  
  v2:
    * add the sysctl handler to cover runtime overcommit policy
      change, as suggested by Andres Morton 
    * address the accuracy concern of vm_memory_committed()
      from Andi Kleen 

Feng Tang (3):
  proc/meminfo: avoid open coded reading of vm_committed_as
  mm/util.c: make vm_memory_committed() more accurate
  mm: adjust vm_committed_as_batch according to vm overcommit policy

 fs/proc/meminfo.c    |  2 +-
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 18 ++++++++++++++----
 mm/util.c            | 19 ++++++++++++++++++-
 6 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.7.4

