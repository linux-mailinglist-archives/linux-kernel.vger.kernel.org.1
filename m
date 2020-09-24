Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF82769D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIXG5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:57:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:20416 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgIXG5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:57:22 -0400
IronPort-SDR: UkvnZ22gcJmiuYv9GxL4WopM7GWsdTrYojPmFHn5enNPRslwyD7T0PpuxIUI8MLv+g0G1sxzSK
 TYcOsUwEQVWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="148872655"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="148872655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 23:57:22 -0700
IronPort-SDR: TtuPRGHSrFfPT77WvdNkzCxkOuBtHHh8rPRBoT2X/iSXQsRe6KpFaKORl9wqrWlnho3kF0tT9q
 yn1f6l3PoCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="338944949"
Received: from unknown (HELO yhuang-dev) ([10.239.159.65])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2020 23:57:20 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
        <878sd1qllb.fsf@yhuang-dev.intel.com>
        <20200923043459.GL795820@optiplex-lnx>
        <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
        <87blhwng5f.fsf@yhuang-dev.intel.com>
        <20200924020928.GC1023012@optiplex-lnx>
        <877dsjessq.fsf@yhuang-dev.intel.com>
        <20200924063038.GD1023012@optiplex-lnx>
Date:   Thu, 24 Sep 2020 14:57:20 +0800
In-Reply-To: <20200924063038.GD1023012@optiplex-lnx> (Rafael Aquini's message
        of "Thu, 24 Sep 2020 02:30:38 -0400")
Message-ID: <87y2kzd5m7.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

>> 
>> If there's a race, we should fix the race.  But the code path for
>> swapcache insertion is,
>> 
>> add_to_swap()
>>   get_swap_page() /* Return if fails to allocate */
>>   add_to_swap_cache()
>>     SetPageSwapCache()
>> 
>> While the code path to split THP is,
>> 
>> split_huge_page_to_list()
>>   if PageSwapCache()
>>     split_swap_cluster()
>> 
>> Both code paths are protected by the page lock.  So there should be some
>> other reasons to trigger the bug.
>
> As mentioned above, no they seem to not be protected (at least, not the
> same page, depending on the case). While add_to_swap() will assure a 
> page_lock on the compound head, split_huge_page_to_list() does not.
>

int split_huge_page_to_list(struct page *page, struct list_head *list)
{
	struct page *head = compound_head(page);
	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
	struct deferred_split *ds_queue = get_deferred_split_queue(head);
	struct anon_vma *anon_vma = NULL;
	struct address_space *mapping = NULL;
	int count, mapcount, extra_pins, ret;
	unsigned long flags;
	pgoff_t end;

	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
	VM_BUG_ON_PAGE(!PageLocked(head), head);

I found there's page lock checking in split_huge_page_to_list().

Best Regards,
Huang, Ying
