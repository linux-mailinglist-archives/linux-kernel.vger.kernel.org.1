Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162942EE8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbhAGWdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbhAGWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610058703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sH1Oz4zaoHH/onOXGglouMWNOSaa/V+B/VSZ6QQ9VbE=;
        b=etDT8riLzV4nmOOtYIF9HWMFiJAosee8GI0/rrv90dxBvR22tpdNQjRcAO3BpNOBIMz7UI
        aEHvAIAoUT6TndnF78t+APnOus7P5/WScFVQFYB6Z7UCLOEic1AR0RTOMkbinemW7de0Jp
        6gwyzHW0HerdVk2UJXBYunikZul15vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-28Qz9KUBPwau2GZF_C58Ag-1; Thu, 07 Jan 2021 17:31:39 -0500
X-MC-Unique: 28Qz9KUBPwau2GZF_C58Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41A7800D62;
        Thu,  7 Jan 2021 22:31:36 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA0C6268F;
        Thu,  7 Jan 2021 22:31:30 +0000 (UTC)
Date:   Thu, 7 Jan 2021 17:31:29 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <X/eLwQPd5bi620Vt@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:29:43PM -0800, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 12:59 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > The problem is it's not even possible to detect reliably if there's
> > really a long term GUP pin because of speculative pagecache lookups.
> 
> So none of the normal code _needs_ that any more these days, which is
> what I think is so nice. Any pinning will do the COW, and then we have
> the logic to make sure it stays writable, and that keeps everything
> nicely coherent and is all fairly simple.
> 
> And yes, it does mean that if somebody then explicitly write-protects
> a page, it may end up being COW'ed after all, but if you first pinned
> it, and then started playing with the protections of that page, why
> should you be surprised?
> 
> So to me, this sounds like a "don't do that then" situation.
> 
> Anybody who does page pinning and wants coherency should NOT TOUCH THE
> MAPPING IT PINNED.
> 
> (And if you do touch it, it's your own fault, and you get to keep both
> of the broken pieces)
> 
> Now, I do agree that from a QoI standpoint, it would be really lovely
> if we actually enforced it. I'm not entirely sure we can, but maybe it
> would be reasonable to use that
> 
>   mm->has_pinned && page_maybe_dma_pinned(page)
> 
> at least as the beginning of a heuristic.
> 
> In fact, I do think that "page_maybe_dma_pinned()" could possibly be
> made stronger than it is. Because at *THAT* point, we might say "we
> know a pinned page always must have a page_mapcount() of 1" - since as
> part of pinning it and doing the GUP_PIN, we forced the COW, and then
> subsequent fork() operations enforce it too.
> 
> So I do think that it might be possible to make that clear_refs code
> notice "this page is pinned, I can't mark it WP without the pinning
> coherency breaking".
> 
> It might not even be hard. But admittedly I'm somewhat handwaving
> here, and I might not have thought of some situation.

I suppose the objective would be to detect when it's a transient pin
(as an O_DIRECT write) and fail clear_refs with an error for all other
cases of real long term pins that need to keep reading at full PCI
bandwidth, without extra GUP invocations after the wp_copy_page run.

Because of the speculative lookups are making the count unstable, it's
not even enough to use mmu notifier and never use FOLL_GET in GUP to
make it safe again (unlike what I mentioned in a previous email).

Random memory corruption will still silently materialize as result of
the speculative lookups in the above scenario.

My whole point here in starting this new thread to suggest page_count
in do_wp_page is an untenable solution is that such commit silently
broke every single long term PIN user that may be used in combination
of clear_refs since 2013.

Silent memory corruption undetected or a detectable error out of
clear_refs, are both different side effects the same technical ABI
break that rendered clear_refs fundamentally incompatible with
clear_refs, so detecting it or not still an ABI break that is.

I felt obliged to report there's something much deeper and
fundamentally incompatible between the page_count in do_wp_page any
wrprotection of exclusive memory in place, as if used in combination
with any RDMA for example. The TLB flushing and the
mmap_read/write_lock were just the tip of the iceberg and they're not
the main concern anymore.

In addition, the inefficiency caused by the fact the page_count effect
is multiplied by 512 times or 262144 while the mapcount remains 4k
granular, makes me think the page_count is unsuitable to be used there
and this specific cure with page_count in do_wp_page, looks worse than
the initial zygote disease.

Thanks,
Andrea

