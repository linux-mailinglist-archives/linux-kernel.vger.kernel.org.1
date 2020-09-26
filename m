Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3380279A51
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgIZPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 11:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIZPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 11:16:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601133413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33UPzLQj6SL41GTzdVo+0ldCUQihOaT6ZbD0HSc6L5Y=;
        b=TnST7xwFccDLcJiYsvIinUbxxu646LHYtjJ/R0sTO+A59FhA8WMFVpvnOOlYfxZy9VKEPh
        0Ju8hgoGSUWm0g/ZlHt5UARHl7JHOWlWOOWhLCe43k/FZisxvH7/qGqkzIM6tpXsp72yus
        +IRDRt4hunytcqOxV13l3Mbp9wwqs9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-B2Ea7k3kMniBF32z5Yafiw-1; Sat, 26 Sep 2020 11:16:49 -0400
X-MC-Unique: B2Ea7k3kMniBF32z5Yafiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E449484E246;
        Sat, 26 Sep 2020 15:16:47 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 954D71002C05;
        Sat, 26 Sep 2020 15:16:46 +0000 (UTC)
Date:   Sat, 26 Sep 2020 11:16:43 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200926151643.GA1325930@optiplex-lnx>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1qqbkx5.fsf@yhuang-dev.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:21:58AM +0800, Huang, Ying wrote:
> Rafael Aquini <aquini@redhat.com> writes:
> >> Or, can you help to run the test with a debug kernel based on upstream
> >> kernel.  I can provide some debug patch.
> >> 
> >
> > Sure, I can set your patches to run with the test cases we have that tend to 
> > reproduce the issue with some degree of success.
> 
> Thanks!
> 
> I found a race condition.  During THP splitting, "head" may be unlocked
> before calling split_swap_cluster(), because head != page during
> deferred splitting.  So we should call split_swap_cluster() before
> unlocking.  The debug patch to do that is as below.  Can you help to
> test it?
>


I finally could grab a good crashdump and confirm that head is really
not locked. I still need to dig into it to figure out more about the
crash. I guess that your patch will guarantee that lock on head, but
it still doesn't help on explaining how did we get the THP marked as 
PG_swapcache, given that it should fail add_to_swap()->get_swap_page()
right? 

I'll give your patch a run over the weekend, hopefully we'll have more
info on this next week.

  
> Best Regards,
> Huang, Ying
> 
> ------------------------8<----------------------------
> From 24ce0736a9f587d2dba12f12491c88d3e296a491 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Fri, 25 Sep 2020 11:10:56 +0800
> Subject: [PATCH] dbg: Call split_swap_clsuter() before unlock page during
>  split THP
> 
> ---
>  mm/huge_memory.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index faadc449cca5..8d79e5e6b46e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2444,6 +2444,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  
>  	remap_page(head);
>  
> +	if (PageSwapCache(head)) {
> +		swp_entry_t entry = { .val = page_private(head) };
> +
> +		split_swap_cluster(entry);
> +	}
> +
>  	for (i = 0; i < HPAGE_PMD_NR; i++) {
>  		struct page *subpage = head + i;
>  		if (subpage == page)
> @@ -2678,12 +2684,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		}
>  
>  		__split_huge_page(page, list, end, flags);
> -		if (PageSwapCache(head)) {
> -			swp_entry_t entry = { .val = page_private(head) };
> -
> -			ret = split_swap_cluster(entry);
> -		} else
> -			ret = 0;
> +		ret = 0;
>  	} else {
>  		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
>  			pr_alert("total_mapcount: %u, page_count(): %u\n",
> -- 
> 2.28.0
> 

