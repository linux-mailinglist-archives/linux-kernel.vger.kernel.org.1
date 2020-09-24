Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2872774D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIXPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728292AbgIXPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600960121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sM32U47HMbXDQBXjEiz101uEL2026nmry9OxMJaqapc=;
        b=SFVhu5oC5UHnIcxxNHrC6HQFSAQ4s+zWu6ZJznMEIZhHp1AAAtGxCAeA1nXflk9+52nCIo
        m9DUbM8iZVg4OGuQijCOJYWZuHuI4oKtpAXIbt5wWk4vhqgRjmrWp9JI45ZzSQITUDVXgK
        Qi5r3KGM7mUQWVwyFqmpFn9WpxWQfAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-5goT9VO7NkuV4M76j_ZSJg-1; Thu, 24 Sep 2020 11:08:39 -0400
X-MC-Unique: 5goT9VO7NkuV4M76j_ZSJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00A5C64179;
        Thu, 24 Sep 2020 15:08:38 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 970DB702E7;
        Thu, 24 Sep 2020 15:08:36 +0000 (UTC)
Date:   Thu, 24 Sep 2020 11:08:33 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200924150833.GE1023012@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
 <878sd1qllb.fsf@yhuang-dev.intel.com>
 <20200923043459.GL795820@optiplex-lnx>
 <87sgb9oz1u.fsf@yhuang-dev.intel.com>
 <20200923130138.GM795820@optiplex-lnx>
 <87blhwng5f.fsf@yhuang-dev.intel.com>
 <20200924020928.GC1023012@optiplex-lnx>
 <877dsjessq.fsf@yhuang-dev.intel.com>
 <20200924063038.GD1023012@optiplex-lnx>
 <87tuvnd3db.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuvnd3db.fsf@yhuang-dev.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:45:52PM +0800, Huang, Ying wrote:
> Rafael Aquini <aquini@redhat.com> writes:
> 
> > On Thu, Sep 24, 2020 at 11:51:17AM +0800, Huang, Ying wrote:
> >> Rafael Aquini <aquini@redhat.com> writes:
> >> > The bug here is quite simple: split_swap_cluster() misses checking for
> >> > lock_cluster() returning NULL before committing to change cluster_info->flags.
> >> 
> >> I don't think so.  We shouldn't run into this situation firstly.  So the
> >> "fix" hides the real bug instead of fixing it.  Just like we call
> >> VM_BUG_ON_PAGE(!PageLocked(head), head) in split_huge_page_to_list()
> >> instead of returning if !PageLocked(head) silently.
> >>
> >
> > Not the same thing, obviously, as you are going for an apples-to-carrots
> > comparison, but since you mentioned:
> >
> > split_huge_page_to_list() asserts (in debug builds) *page is locked,
> 
> 	VM_BUG_ON_PAGE(!PageLocked(head), head);
> 
> It asserts *head instead of *page.
>
> > and later checks if *head bears the SwapCache flag. 
> > deferred_split_scan(), OTOH, doesn't hand down the compound head locked, 
> > but the 2nd page in the group instead.
> 
> No.  deferred_split_scan() will can trylock_page() on the 2nd page in
> the group, but
> 
> static inline int trylock_page(struct page *page)
> {
> 	page = compound_head(page);
> 	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
> }
> 
> So the head page will be locked instead.
> 

Yep, missed that. Thanks for straighten me out on this one.


> > This doesn't necessarely means it's a problem, though, but might help
> > on hitting the issue. 
> >  
> >> > The fundamental problem has nothing to do with allocating, or not allocating
> >> > a swap cluster, but it has to do with the fact that the THP deferred split scan
> >> > can transiently race with swapcache insertion, and the fact that when you run
> >> > your swap area on rotational storage cluster_info is _always_ NULL.
> >> > split_swap_cluster() needs to check for lock_cluster() returning NULL because
> >> > that's one possible case, and it clearly fails to do so.
> >> 
> >> If there's a race, we should fix the race.  But the code path for
> >> swapcache insertion is,
> >> 
> >> add_to_swap()
> >>   get_swap_page() /* Return if fails to allocate */
> >>   add_to_swap_cache()
> >>     SetPageSwapCache()
> >> 
> >> While the code path to split THP is,
> >> 
> >> split_huge_page_to_list()
> >>   if PageSwapCache()
> >>     split_swap_cluster()
> >> 
> >> Both code paths are protected by the page lock.  So there should be some
> >> other reasons to trigger the bug.
> >
> > As mentioned above, no they seem to not be protected (at least, not the
> > same page, depending on the case). While add_to_swap() will assure a 
> > page_lock on the compound head, split_huge_page_to_list() does not.
> >
> >
> >> And again, for HDD, a THP shouldn't have PageSwapCache() set at the
> >> first place.  If so, the bug is that the flag is set and we should fix
> >> the setting.
> >> 
> >
> > I fail to follow your claim here. Where is the guarantee, in the code, that 
> > you'll never have a compound head in the swapcache? 
> 
> We may have a THP in the swap cache, only if non-rotational disk is used
> as swap device.  This is the design assumption of the THP swap support.
> And this is guaranteed via swap space allocation for THP will fail for
> HDD.  If the implementation doesn't guarantee this, we will fix the
> implementation to guarantee this.
> 
> >> > Run a workload that cause multiple THP COW, and add a memory hogger to create
> >> > memory pressure so you'll force the reclaimers to kick the registered
> >> > shrinkers. The trigger is not heavy swapping, and that's probably why
> >> > most swap test cases don't hit it. The window is tight, but you will get the
> >> > NULL pointer dereference.
> >> 
> >> Do you have a script to reproduce the bug?
> >> 
> >
> > Nope, a convoluted set of internal regression tests we have usually
> > triggers it. In the wild, customers running HANNA are seeing it,
> > occasionally.
> 
> So you haven't reproduce the bug on upstream kernel?
> 

Have you seen the stack dump in the patch? It still reproduces with v5.9,
even though the rate is a lot lower than with earlier kernels.


> Or, can you help to run the test with a debug kernel based on upstream
> kernel.  I can provide some debug patch.
> 

Sure, I can set your patches to run with the test cases we have that tend to 
reproduce the issue with some degree of success.


> >> > Regardless you find furhter bugs, or not, this patch is needed to correct a
> >> > blunt coding mistake.
> >> 
> >> As above.  I don't agree with that.
> >> 
> >
> > It's OK to disagree, split_swap_cluster still misses the cluster_info NULL check,
> > though.
> 
> In contrast, if the checking is necessary, we shouldn't ignore it, but
> use something like
> 
>         ci = lock_cluster(si, offset);
> +       VM_BUG_ON(!ci);

Wrong. This will still allow for NULL ptr dereference on non-debug builds.
If ci can be NULL -- and it clearly can, we need to protect 
cluster_clear_huge(ci) against that.



