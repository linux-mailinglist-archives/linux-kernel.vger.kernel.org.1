Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6A2C1F04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKXHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgKXHlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:41:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606203702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1gMJyqOlFP62gR3VbRyFrd6rFqNzUZtLTMLS2oC9hk=;
        b=A17PhcB4oNVJLRwOHUgnZ+HyjBTSLqN38fECNVmAlcH7nJPTf5dxN+gYPGBFaDFCjMHR9A
        pctzalZHy8rQv7sD1K9WStrRzTtuNC2SxZ90g+H1XuOz3qZ5Osz4RWANtwUMTMdHYrJRnW
        CyhSwSLpI39wbXauMrd6kLJHOsC4BlQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CC69AD35;
        Tue, 24 Nov 2020 07:41:42 +0000 (UTC)
Date:   Tue, 24 Nov 2020 08:41:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
Message-ID: <20201124074141.GR27488@dhcp22.suse.cz>
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
 <20201123141354.GQ27488@dhcp22.suse.cz>
 <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-11-20 20:40:40, Charan Teja Kalla wrote:
> 
> Thanks Michal!
> On 11/23/2020 7:43 PM, Michal Hocko wrote:
> > On Mon 23-11-20 19:33:16, Charan Teja Reddy wrote:
> >> When the pages are failed to get isolate or migrate, the page owner
> >> information along with page info is dumped. If there are continuous
> >> failures in migration(say page is pinned) or isolation, the log buffer
> >> is simply getting flooded with the page owner information. As most of
> >> the times page info is sufficient to know the causes for failures of
> >> migration or isolation, place the page owner information under DEBUG_VM.
> > 
> > I do not see why this path is any different from others that call
> > dump_page. Page owner can add a very valuable information to debug
> > the underlying reasons for failures here. It is an opt-in debugging
> > feature which needs to be enabled explicitly. So I would argue users
> > are ready to accept a lot of data in the kernel log.
> 
> Just thinking how frequently failures can happen in those paths. In the
> memory hotplug path, we can flood the page owner logs just by making one
> page pinned.

If you are operating on a movable zone then pages shouldn't be pinned
for unbound amount of time. Yeah there are some ways to break this
fundamental assumption but this is a bigger problem that needs a
solution.

> Say If it is anonymous page, the page owner information
> shows is something like below, which is not really telling anything
> other than how the pinned page is allocated.

Well you can tell an anonymous page from __dump_page, all right, but
this is not true universally.

> page last allocated via order 0, migratetype Movable, gfp_mask
> 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
>   prep_new_page+0x7c/0x1a4
>   get_page_from_freelist+0x1ac/0x1c4
>   __alloc_pages_nodemask+0x12c/0x378
>   do_anonymous_page+0xac/0x3b4
>   handle_pte_fault+0x2a4/0x3bc
>   __handle_speculative_fault+0x208/0x3c0
>   do_page_fault+0x280/0x508
>   do_translation_fault+0x3c/0x54
>   do_mem_abort+0x64/0xf4
>   el0_da+0x1c/0x20
>  page last free stack trace:
>   free_pcp_prepare+0x320/0x454
>   free_unref_page_list+0x9c/0x2a4
>   release_pages+0x370/0x3c8
>   free_pages_and_swap_cache+0xdc/0x10c
>   tlb_flush_mmu+0x110/0x134
>   tlb_finish_mmu+0x48/0xc0
>   unmap_region+0x104/0x138
>   __do_munmap+0x2ec/0x3b4
>   __arm64_sys_munmap+0x80/0xd8
> 
> I see at some places in the kernel where they put the dump_page under
> DEBUG_VM, but in the end I agree that it is up to the users need. Then
> there are some users who don't care for these page owner logs.

Well, as I've said page_owner requires an explicit enabling and I would
expect that if somebody enables this tracking then it is expected to see
the information when we dump a page state.

> And an issue on Embedded systems with these continuous logs being
> printed to the console is the watchdog timeouts, because console logging
> happens by disabling the interrupts.

Are you enabling page_owner on those systems unconditionally?
-- 
Michal Hocko
SUSE Labs
