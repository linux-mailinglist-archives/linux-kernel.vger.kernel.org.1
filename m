Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1E2EE9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbhAGXto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbhAGXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610063297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArymLbcV4Aen3TKFT30N1pqHUczMFTRBIcU4+sJi//w=;
        b=GHwmNyvvrPLSa924f7I6FY9Nw1bL5ISFyNrQFN3TfFnwgPr9I3wLg5NcEUSbitFjRRWfrk
        FL+KKNDvgurWh0/7oXbEWacNsGyL+6F/xx7YqL2gVHOxvni5TwBqCdEV9DizzlBfIo4QFg
        kzS1v1dMggjrQFM0Q5drXpm6CvIlz+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-eSP__PFENyCcMVAw0GfpQg-1; Thu, 07 Jan 2021 18:48:13 -0500
X-MC-Unique: eSP__PFENyCcMVAw0GfpQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 651B3180A093;
        Thu,  7 Jan 2021 23:48:10 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B245B10013C1;
        Thu,  7 Jan 2021 23:48:01 +0000 (UTC)
Date:   Thu, 7 Jan 2021 18:48:01 -0500
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
Message-ID: <X/edsWgguQDgsOtx@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:51:24PM -0800, Linus Torvalds wrote:
> Ho humm. I had obviously not looked very much at that code. I had done
> a quick git grep, but now that I look closer, it *does* get the
> mmap_sem for writing, but only for that VM_SOFTDIRTY bit clearing, and
> then it does a mmap_write_downgrade().
> 
> So that's why I had looked more at the UFFD code, because that one was
> the one I was aware of doing this all with just the read lock. I
> _thought_ the softdirty code already took the write lock and wouldn't
> race with page faults.
> 
> But I had missed that write_downgrade. So yeah, this code has the same issue.

I overlooked the same thing initially. It's only when I noticed it
also used mmap_read_lock, that I figured that the group lock thingy
uffd-wp ad-hoc solution, despite it was fully self contained thanks to
the handle_userfault() catcher for the uffd-wp bit in the pagetable,
wasn't worth it since uffd-wp could always use whatever clear_refs
used to solve it.

> Anyway, the fix is - I think - the same I outlined earlier when I was
> talking about UFFD: take the thing for writing, so that you can't
> race.

Sure.

> The alternate fix remains "make sure we always flush the TLB before
> releasing the page table lock, and make COW do the copy under the page
> table lock". But I really would prefer to just have this code follow

The copy under PT lock isn't enough.

Flush TLB before releasing is enough of course.

Note also the patch in 2/2 patch that I sent:

     https://lkml.kernel.org/r/20210107200402.31095-3-aarcange@redhat.com

2/2 would have been my preferred solution for both and it works
fine. All corruption that was trivially reproducible with heavy
selftest program in the kernel, is all gone.

If only the TLB pending issue was the only regression page_count in
do_wp_page introduced, I would have never suggested we should
re-evaluate it. It'd be a good tradeoff in such case, even if it'd
penalize the soft-dirty runtime, especially if we were allowed to
deploy 2/2 as a non-blocking solution.

Until yesterday I fully intended to just propose 1/2 and 2/2, with a
whole different cover letter, CC stable and close this case.

> all the usual rules, and if it does a write protect, then it should
> take the mmap_sem for writing.

The problem isn't about performance anymore, the problem is a silent
ABI break to long term PIN user attached to an mm under clear_refs.

> Why is that very simple rule so bad?
> 
> (And see my unrelated but incidental note on it being a good idea to
> try to minimize latency by making surfe we don't do any IO under the
> mmap lock - whether held for reading _or_ writing. Because I do think
> we can improve in that area, if you have some good test-case).

That would be great indeed.

Thanks,
Andrea

