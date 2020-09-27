Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02118279E72
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgI0Fd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:33:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:4823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgI0Fd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:33:27 -0400
IronPort-SDR: r/6ggePXmMXt/tkZDIRuUjUGr6CvCHMWJ6QZZBOREUR8Cyb7NBF9mhG6O/yrSQG0E0iZlgOZwH
 GVWdgJ1EYdxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149503058"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="149503058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:33:24 -0700
IronPort-SDR: KZ5U8p5UglqFP5AJsGeZrD3idzYlR1g4EWZKnHx9q1UnfgQiK7KtvaWpQ1klgZbBiUBXz+QNPR
 YmpMu5TvaVnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="488122447"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2020 22:33:22 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200923043459.GL795820@optiplex-lnx>
        <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
        <87blhwng5f.fsf@yhuang-dev.intel.com>
        <20200924020928.GC1023012@optiplex-lnx>
        <877dsjessq.fsf@yhuang-dev.intel.com>
        <20200924063038.GD1023012@optiplex-lnx>
        <87tuvnd3db.fsf@yhuang-dev.intel.com>
        <20200924150833.GE1023012@optiplex-lnx>
        <87r1qqbkx5.fsf@yhuang-dev.intel.com>
        <20200926151643.GA1325930@optiplex-lnx>
Date:   Sun, 27 Sep 2020 13:33:21 +0800
In-Reply-To: <20200926151643.GA1325930@optiplex-lnx> (Rafael Aquini's message
        of "Sat, 26 Sep 2020 11:16:43 -0400")
Message-ID: <874knjbx7i.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

> On Fri, Sep 25, 2020 at 11:21:58AM +0800, Huang, Ying wrote:
>> Rafael Aquini <aquini@redhat.com> writes:
>> >> Or, can you help to run the test with a debug kernel based on upstream
>> >> kernel.  I can provide some debug patch.
>> >> 
>> >
>> > Sure, I can set your patches to run with the test cases we have that tend to 
>> > reproduce the issue with some degree of success.
>> 
>> Thanks!
>> 
>> I found a race condition.  During THP splitting, "head" may be unlocked
>> before calling split_swap_cluster(), because head != page during
>> deferred splitting.  So we should call split_swap_cluster() before
>> unlocking.  The debug patch to do that is as below.  Can you help to
>> test it?
>>
>
>
> I finally could grab a good crashdump and confirm that head is really
> not locked.

Thanks!  That's really helpful for us to root cause the bug.

> I still need to dig into it to figure out more about the
> crash. I guess that your patch will guarantee that lock on head, but
> it still doesn't help on explaining how did we get the THP marked as 
> PG_swapcache, given that it should fail add_to_swap()->get_swap_page()
> right? 

Because ClearPageCompound(head) is called in __split_huge_page(), then
all subpages except "page" are unlocked.  So previously, when
split_swap_cluster() is called in split_huge_page_to_list(), the THP has
been split already and "head" may be unlocked.  Then the normal page
"head" can be added to swap cache.

CPU1                                                             CPU2
----                                                             ----
deferred_split_scan()
  split_huge_page(page) /* page isn't compound head */
    split_huge_page_to_list(page, NULL)
      __split_huge_page(page, )
        ClearPageCompound(head)
        /* unlock all subpages except page (not head) */
                                                                 add_to_swap(head)  /* not THP */
                                                                   get_swap_page(head)
                                                                   add_to_swap_cache(head, )
                                                                     SetPageSwapCache(head)
     if PageSwapCache(head)
       split_swap_cluster(/* swap entry of head */)
         /* Deref sis->cluster_info: NULL accessing! */

> I'll give your patch a run over the weekend, hopefully we'll have more
> info on this next week.

Thanks!

Best Regards,
Huang, Ying

>> Best Regards,
>> Huang, Ying
>> 
>> ------------------------8<----------------------------
>> From 24ce0736a9f587d2dba12f12491c88d3e296a491 Mon Sep 17 00:00:00 2001
>> From: Huang Ying <ying.huang@intel.com>
>> Date: Fri, 25 Sep 2020 11:10:56 +0800
>> Subject: [PATCH] dbg: Call split_swap_clsuter() before unlock page during
>>  split THP
>> 
>> ---
>>  mm/huge_memory.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index faadc449cca5..8d79e5e6b46e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2444,6 +2444,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>  
>>  	remap_page(head);
>>  
>> +	if (PageSwapCache(head)) {
>> +		swp_entry_t entry = { .val = page_private(head) };
>> +
>> +		split_swap_cluster(entry);
>> +	}
>> +
>>  	for (i = 0; i < HPAGE_PMD_NR; i++) {
>>  		struct page *subpage = head + i;
>>  		if (subpage == page)
>> @@ -2678,12 +2684,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>  		}
>>  
>>  		__split_huge_page(page, list, end, flags);
>> -		if (PageSwapCache(head)) {
>> -			swp_entry_t entry = { .val = page_private(head) };
>> -
>> -			ret = split_swap_cluster(entry);
>> -		} else
>> -			ret = 0;
>> +		ret = 0;
>>  	} else {
>>  		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>>  			pr_alert("total_mapcount: %u, page_count(): %u\n",
>> -- 
>> 2.28.0
>> 
