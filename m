Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FDC29FE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgJ3H15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:27:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:28028 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3H14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:27:56 -0400
IronPort-SDR: I1n160I84Sa+mYQWxFs846jqgafqj/s5zuk9mCSaawi09YIBrp8VisXAQlEqFKPf8xkaUSoezI
 8jOwVeuGzYlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253279356"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="253279356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 00:27:55 -0700
IronPort-SDR: pI5j+anJbHbX5tSuB+HWmUKVyY+Vg2pu4M0vxMSvvHSBgGOl/h0yBzkllmIegU5jtWqgrSmKyB
 ZR9OmC4LPeRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="319237011"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2020 00:27:51 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
References: <20201028023411.15045-1-ying.huang@intel.com>
        <20201028023411.15045-2-ying.huang@intel.com>
        <20201029090421.GC17500@dhcp22.suse.cz>
Date:   Fri, 30 Oct 2020 15:27:51 +0800
In-Reply-To: <20201029090421.GC17500@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 29 Oct 2020 10:04:21 +0100")
Message-ID: <87h7qcxjew.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 28-10-20 10:34:10, Huang Ying wrote:
>> To follow code-of-conduct better.
>
> This is changing a user visible interface and any userspace which refers
> to the existing name will fail to compile unless I am missing something.

Although these flags are put in uapi, I found these flags are actually
internal flags used in "flags" field of struct mempolicy, they are never
used as flags for any user space API.  I guess they are placed in uapi
header file to guarantee they aren't conflict with MPOL_MODE_FLAGS.

> Have you checked how many applications would be affected?

Based on above analysis, I think there is no application that will be
affected.

> Btw I find "follow CoC better" a very weak argument without further
> explanation.

That is the only reason for the patch.  If nobody thinks the change is
necessary, I can just drop the patch.

Best Regards,
Huang, Ying

>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Acked-by: Rafael Aquini <aquini@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Rafael Aquini <aquini@redhat.com>
>> ---
>>  include/uapi/linux/mempolicy.h | 2 +-
>>  kernel/sched/debug.c           | 2 +-
>>  mm/mempolicy.c                 | 6 +++---
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> index 3354774af61e..3c3666d017e6 100644
>> --- a/include/uapi/linux/mempolicy.h
>> +++ b/include/uapi/linux/mempolicy.h
>> @@ -60,7 +60,7 @@ enum {
>>  #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
>>  #define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
>>  #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
>> -#define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>> +#define MPOL_F_MOPRON	(1 << 4) /* Migrate On Protnone Reference On Node */
>>  
>>  
>>  #endif /* _UAPI_LINUX_MEMPOLICY_H */
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 0655524700d2..8bfb6adb3f31 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -898,7 +898,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>>  
>>  	task_lock(p);
>>  	pol = p->mempolicy;
>> -	if (pol && !(pol->flags & MPOL_F_MORON))
>> +	if (pol && !(pol->flags & MPOL_F_MOPRON))
>>  		pol = NULL;
>>  	mpol_get(pol);
>>  	task_unlock(p);
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 3fde772ef5ef..f6948b659643 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2511,7 +2511,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>>  	}
>>  
>>  	/* Migrate the page towards the node whose CPU is referencing it */
>> -	if (pol->flags & MPOL_F_MORON) {
>> +	if (pol->flags & MPOL_F_MOPRON) {
>>  		polnid = thisnid;
>>  
>>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
>> @@ -2802,7 +2802,7 @@ void __init numa_policy_init(void)
>>  		preferred_node_policy[nid] = (struct mempolicy) {
>>  			.refcnt = ATOMIC_INIT(1),
>>  			.mode = MPOL_PREFERRED,
>> -			.flags = MPOL_F_MOF | MPOL_F_MORON,
>> +			.flags = MPOL_F_MOF | MPOL_F_MOPRON,
>>  			.v = { .preferred_node = nid, },
>>  		};
>>  	}
>> @@ -3010,7 +3010,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>  	unsigned short mode = MPOL_DEFAULT;
>>  	unsigned short flags = 0;
>>  
>> -	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
>> +	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MOPRON)) {
>>  		mode = pol->mode;
>>  		flags = pol->flags;
>>  	}
>> -- 
>> 2.28.0
>> 
