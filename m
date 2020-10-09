Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0921287F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgJIASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:18:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:61644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgJIASM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:18:12 -0400
IronPort-SDR: lQwk+2c6U8wDROwV/WWYQwmYfvQ8lKrgiKxEQ8fnOT2tNC5iMbijuMJe/qZHrbFs1tVaK9OTj/
 FwDA3HJfyacA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250117701"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="250117701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 17:18:12 -0700
IronPort-SDR: xGkoKYj6edt+3zDBVIF/CtpWiCILzKtBx554qkiD2ga8QMUVBwT0zlVeuA1FOVRh9vv8qbNMAW
 EzQlMvnH3CQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="461990802"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2020 17:18:10 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
        <87blhwng5f.fsf@yhuang-dev.intel.com>
        <20200924020928.GC1023012@optiplex-lnx>
        <877dsjessq.fsf@yhuang-dev.intel.com>
        <20200924063038.GD1023012@optiplex-lnx>
        <87tuvnd3db.fsf@yhuang-dev.intel.com>
        <20200924150833.GE1023012@optiplex-lnx>
        <87r1qqbkx5.fsf@yhuang-dev.intel.com>
        <20201001143157.GA1530324@optiplex-lnx>
        <20201005133907.GE1530324@optiplex-lnx>
Date:   Fri, 09 Oct 2020 08:18:10 +0800
In-Reply-To: <20201005133907.GE1530324@optiplex-lnx> (Rafael Aquini's message
        of "Mon, 5 Oct 2020 09:39:07 -0400")
Message-ID: <877ds09rr1.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

> On Thu, Oct 01, 2020 at 10:31:57AM -0400, Rafael Aquini wrote:
>> On Fri, Sep 25, 2020 at 11:21:58AM +0800, Huang, Ying wrote:
>> > Rafael Aquini <aquini@redhat.com> writes:
>> > >> Or, can you help to run the test with a debug kernel based on upstream
>> > >> kernel.  I can provide some debug patch.
>> > >> 
>> > >
>> > > Sure, I can set your patches to run with the test cases we have that tend to 
>> > > reproduce the issue with some degree of success.
>> > 
>> > Thanks!
>> > 
>> > I found a race condition.  During THP splitting, "head" may be unlocked
>> > before calling split_swap_cluster(), because head != page during
>> > deferred splitting.  So we should call split_swap_cluster() before
>> > unlocking.  The debug patch to do that is as below.  Can you help to
>> > test it?
>> > 
>> > Best Regards,
>> > Huang, Ying
>> > 
>> > ------------------------8<----------------------------
>> > From 24ce0736a9f587d2dba12f12491c88d3e296a491 Mon Sep 17 00:00:00 2001
>> > From: Huang Ying <ying.huang@intel.com>
>> > Date: Fri, 25 Sep 2020 11:10:56 +0800
>> > Subject: [PATCH] dbg: Call split_swap_clsuter() before unlock page during
>> >  split THP
>> > 
>> > ---
>> >  mm/huge_memory.c | 13 +++++++------
>> >  1 file changed, 7 insertions(+), 6 deletions(-)
>> > 
>> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > index faadc449cca5..8d79e5e6b46e 100644
>> > --- a/mm/huge_memory.c
>> > +++ b/mm/huge_memory.c
>> > @@ -2444,6 +2444,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>> >  
>> >  	remap_page(head);
>> >  
>> > +	if (PageSwapCache(head)) {
>> > +		swp_entry_t entry = { .val = page_private(head) };
>> > +
>> > +		split_swap_cluster(entry);
>> > +	}
>> > +
>> >  	for (i = 0; i < HPAGE_PMD_NR; i++) {
>> >  		struct page *subpage = head + i;
>> >  		if (subpage == page)
>> > @@ -2678,12 +2684,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>> >  		}
>> >  
>> >  		__split_huge_page(page, list, end, flags);
>> > -		if (PageSwapCache(head)) {
>> > -			swp_entry_t entry = { .val = page_private(head) };
>> > -
>> > -			ret = split_swap_cluster(entry);
>> > -		} else
>> > -			ret = 0;
>> > +		ret = 0;
>> >  	} else {
>> >  		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>> >  			pr_alert("total_mapcount: %u, page_count(): %u\n",
>> > -- 
>> > 2.28.0
>> > 
>> 
>> I left it running for several days, on several systems that had seen the
>> crash hitting before, and no crashes were observed for either the upstream
>> kernel nor the distro build 4.18-based kernel.
>> 
>> I guess we can comfortably go with your patch. Thanks!
>> 
>>
> Ping
>
> Are you going to post this patchfix soon? Or do you rather have me
> posting it?

Sorry for late replying.  I just come back from a long local holiday.
Thanks a lot for testing!  I will prepare the formal fixing patch.

Best Regards,
Huang, Ying
